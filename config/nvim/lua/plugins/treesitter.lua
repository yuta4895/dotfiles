return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    local ts = require("nvim-treesitter")

    local langs = {
      "c",
      "cpp",
      "python",
      "go",
      "java",
      "kotlin",
      "javascript",
      "typescript",
      "tsx",
      "svelte",
      "html",
      "css",
      "bash",
      "zsh",
      "dockerfile",
      "yaml",
      "xml",
      "json",
      "toml",
      "sql",
      "gitignore",
      "make",
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "query",
    }

    ts.install(langs, {
      summary = true,
    })
    
    vim.api.nvim_create_autocmd('FileType', {
      pattern = langs,
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

  end
}
