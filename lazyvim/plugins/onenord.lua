return {
  {
    "rmehri01/onenord.nvim",
    opts = {
      theme = "dark",
      borders = true,
      disable = {
        background = true,
        float_background = true,
      },
      custom_highlights = {
        ["@comment"] = { fg = "#A0A8C4" },
        ["Comment"] = { fg = "#A0A8C4" },
        ["SpecialComment"] = { fg = "#A0A8C4" },
      },
      custom_colors = {
        highlight = "#566178",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onenord",
    },
  },
}
