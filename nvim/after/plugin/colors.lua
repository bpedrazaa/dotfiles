vim.o.background = 'dark'
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground= 'mix'
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_visual = 'blue background'
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_statusline_style = 'mix'

vim.cmd.colorscheme("gruvbox-material")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
