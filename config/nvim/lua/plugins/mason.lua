return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
    }
  },
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "mason" } },
  build = ":MasonUpdate", 
}
