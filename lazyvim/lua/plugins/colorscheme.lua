-- General colorschemes table
local colorSchemes = {
  oneNord = {
    pluginSpecs = {
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
          -- highlight = "#333333",
        },
      },
    },
    colorSchemeNameOptions = {
      "onenord",
    },
  },
  gruvbox = {
    pluginSpecs = {
      "ellisonleao/gruvbox.nvim",
      opts = {
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        transparent_mode = true,
      },
    },
    colorSchemeNameOptions = {
      "gruvbox",
    },
  },
  gruvboxMaterial = {
    pluginSpecs = {
      "f4z3r/gruvbox-material.nvim",
      opts = {
        italics = false,
        contrast = "hard",
        comments = {
          italics = false,
        },
        background = {
          transparent = true,
        },
      },
    },
    colorSchemeNameOptions = {
      "gruvbox-material",
    },
  },
  blackMetal = {
    pluginSpecs = {
      "metalelf0/black-metal-theme-neovim",
    },
    colorSchemeNameOptions = {
      "bathory",
      "burzum",
      "dark-funeral",
      "darkthrone",
      "emperor",
      "gorgoroth",
      "immortal",
      "impaled-nazarene",
      "khold",
      "marduk",
      "mayhem",
      "nile",
      "taake",
      "thyrfing",
      "venom",
      "windir",
    },
  },
  black = {
    pluginSpecs = {
      "alexanderbluhm/black.nvim",
    },
    colorSchemeNameOptions = {
      "black",
    },
  },
  midnight = {
    pluginSpecs = {
      "dasupradyumna/midnight.nvim",
    },
    colorSchemeNameOptions = {
      "midnight",
    },
  },
  obscure = {
    pluginSpecs = {
      "killitar/obscure.nvim",
      opts = {
        transparent = true,
        styles = {
          booleans = { italic = false, bold = true },
        },
      },
    },
    colorSchemeNameOptions = {
      "obscure",
    },
  },
}

return {
  colorSchemes.oneNord.pluginSpecs,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorSchemes.oneNord.colorSchemeNameOptions[1],
    },
  },
}
