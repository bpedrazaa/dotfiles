-- Catppuccin
vim.cmd.colorscheme "catppuccin"
require("catppuccin").setup({
    flavour = "mocha",
    background = {
        dark = "mocha",
    },
    transparent_background = true,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.8,
    },
    no_italic = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
    },
})

-- Everforest
-- vim.cmd.colorscheme "everforest"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
