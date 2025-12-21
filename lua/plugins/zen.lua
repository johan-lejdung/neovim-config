return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", ":ZenMode<CR>", desc = "Toggle [Z]en mode" },
    },
    opts = {
      window = {
        backdrop = 0.8,
        width = 180,
        height = 1,
      },
    },
  },
}
