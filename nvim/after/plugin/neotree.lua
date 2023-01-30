vim.keymap.set("n", "<leader>nn", vim.cmd.NeoTreeShowToggle)
require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    width = 40
  }
})
