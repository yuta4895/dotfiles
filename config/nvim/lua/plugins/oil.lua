return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-k>"] = false,
      ["<C-j>"] = false,
      ["<leader>sh"] = { "actions.select", opts = { horizontal = true } },
      ["<leader>sv"] = { "actions.select", opts = { vertical = true } },
    }
  },
    -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
