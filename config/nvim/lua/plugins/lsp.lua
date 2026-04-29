return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = function()
      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "✘",
              [vim.diagnostic.severity.WARN] = "▲",
              [vim.diagnostic.severity.HINT] = "⚑",
              [vim.diagnostic.severity.INFO] = "»",
            },
          },
        },
        keys = {
          { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
          { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
          { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
          { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
          { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
          { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
          { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
          { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
          { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
          { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" }, has = "codeAction" },
          { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" }, has = "codeLens" },
          { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
          { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
          { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
          { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
            desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
          { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
            desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
          { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
            desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
          { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
            desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
        },
        servers = {
          lua_ls = {
            settings = {
              Lua = { completion = { callSnippet = "Replace" } },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- inlay hints
      Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)

      -- folds
      Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
        if vim.wo.foldmethod == "expr" then
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end)

      -- code lens
      Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "bufenter", "cursorhold", "insertleave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)

      -- Map global keys defined in opts.keys
      for _, keys in ipairs(opts.keys) do
        local filters = {}
        if keys.has then
          local methods = type(keys.has) == "string" and { keys.has } or keys.has
          for _, method in ipairs(methods) do
            method = method:find("/") and method or ("textDocument/" .. method)
            table.insert(filters, { method = method })
          end
        else
          table.insert(filters, {})
        end

        for _, f in ipairs(filters) do
          local k_opts = {
            desc = keys.desc,
            nowait = keys.nowait,
            expr = keys.expr,
            silent = keys.silent ~= false,
            lsp = f,
            enabled = keys.enabled,
          }
          Snacks.keymap.set(keys.mode or "n", keys[1], keys[2], k_opts)
        end
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright"
      },
      automatic_enable = true,
    },
  }
}
