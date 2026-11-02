return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      nu = { "nufmt" },
    },
    formatters = {
      nufmt = {
        command = "nufmt",
      },
    },
  },
}
