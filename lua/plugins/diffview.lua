return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    {
      "<leader>hv",
      function()
        local lib = require("diffview.lib")
        if lib.get_current_view() then
          vim.cmd("DiffviewClose")
          return
        end
        -- A view is open in another tab: go there instead of opening a second one.
        for _, view in ipairs(lib.views) do
          if view.tabpage and vim.api.nvim_tabpage_is_valid(view.tabpage) then
            vim.api.nvim_set_current_tabpage(view.tabpage)
            return
          end
        end
        vim.cmd("DiffviewOpen")
      end,
      desc = "git diff [v]iew (toggle)",
    },
  },
}
