if true then
  return {}
end

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        comments = { italic = false },
        -- sidebars = "transparent",
        floats = "transparent",
      },
      lualine_bold = true,
      on_highlights = function(hl)
        hl.comment = { bg = "#222436", fg = "#d3e9c6" }
        hl.perlComment = { bg = "#222436", fg = "#d3e9c6" }
        hl.Comment = { bg = "#222436", fg = "#d3e9c6" }
        hl.DiagnosticUnnecessary = { fg = "#6B8DB6" }
      end,
      on_colors = function(colors)
        colors.border = "#bb9af7"
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
    },
  },
}
