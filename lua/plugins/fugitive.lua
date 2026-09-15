return {
  "tpope/vim-fugitive",
  -- Lazy-load on first use. `Git` and `G` cover `:Git commit`, `:Git commit --amend --no-edit`,
  -- and the bare `:Git` status window. Add more commands here if you start using them
  -- (e.g. "Gdiffsplit", "Gread", "Gwrite", "GBrowse").
  cmd = { "Git", "G" },
}
