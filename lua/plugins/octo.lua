-- GitHub PRs and issues inside Neovim: list PRs, review diffs, leave inline
-- comments, and submit reviews. Needs the `gh` CLI, authenticated.
-- https://github.com/pwntester/octo.nvim
return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  keys = {
    { "<leader>op", "<cmd>Octo pr list<cr>", desc = "[O]cto [P]R list" },
    { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "[O]cto [I]ssue list" },
    { "<leader>or", "<cmd>Octo review start<cr>", desc = "[O]cto start [R]eview" },
    { "<leader>oR", "<cmd>Octo review resume<cr>", desc = "[O]cto [R]esume review" },
    { "<leader>os", "<cmd>Octo review submit<cr>", desc = "[O]cto [S]ubmit review" },
  },
  opts = {
    picker = "telescope",
    enable_builtin = true, -- bare `:Octo` opens a picker of every action
    use_local_fs = false,
    default_merge_method = "squash",
  },
}
