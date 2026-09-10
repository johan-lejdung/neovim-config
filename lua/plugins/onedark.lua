return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
        highlights = {
          -- Comments are quite dim in the "darker" style; lift them to the
          -- palette's lighter grey so they are easier to read.
          Comment = { fg = "$light_grey" },
          SpecialComment = { fg = "$light_grey" },
          ["@comment"] = { fg = "$light_grey" },
          ["@comment.documentation"] = { fg = "$light_grey" },
          -- Active tab: same colors as the editor instead of an inverted light block.
          TabLineSel = { fg = "$fg", bg = "$bg0" },
        },
      })
      -- Enable theme
      require("onedark").load()
    end,
  },
}
