return {
  "folke/snacks.nvim",
  opts = {
    -- enable snakes.image
    image = {
      enable = true,
      resolve = function(path, src)
        if require("obsidian.api").path_is_note(path) then
          return require("obsidian.api").resolve_image_path(src)
        end
      end,
    },
    terminal = {
      enable = true,
      win = {
        -- make the terminal float
        position = "float",
        backdrop = 60,
        height = 0.7,
        width = 0.7,
        border = "rounded",
        zindex = 50,
      },
    },
  },
}
