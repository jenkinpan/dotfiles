return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    -- set lualine transparent
    on_colors = function(colors)
      colors.bg_statusline = colors.none
    end,
    on_highlights = function(hl, c)
      -- TabLineFill is currently set to black
      hl.TabLineFill = {
        bg = c.none,
      }
    end,
  },
}
