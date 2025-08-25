-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

-- NOTE: Yes, you can install new plugins here!
return {
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      "<leader>dd",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<leader>dc",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Debug: Run to Cursor",
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Debug: Hover Variables",
      mode = { "n", "v" },
    },
    {
      "<leader>dH",
      function()
        require("dap.ui.widgets").preview()
      end,
      desc = "Debug: Preview",
    },
    {
      "<leader>dw",
      function()
        local word = vim.fn.expand("<cword>")
        require("dapui").elements.watches.add(word)
      end,
      desc = "Debug: Add word to watchlist",
    },
    {
      "<leader>dW",
      function()
        local dapui = require("dapui")
        local watches = dapui.elements.watches

        -- Get current watch expressions
        local watch_list = {}
        for i, watch in ipairs(watches.get()) do
          table.insert(watch_list, string.format("%d: %s", i, watch.expression))
        end

        if #watch_list == 0 then
          vim.notify("No watch expressions to remove", vim.log.levels.INFO)
          return
        end

        -- Use vim.ui.select to choose which one to remove
        vim.ui.select(watch_list, {
          prompt = "Select watch expression to remove:",
        }, function(choice, idx)
          if choice and idx then
            watches.remove(idx)
            vim.notify(string.format("Removed watch: %s", choice), vim.log.levels.INFO)
          end
        end)
      end,
      desc = "Debug: Choose watch to remove",
    },
    {
      "<leader>dr",
      function()
        require("dap").restart()
      end,
      desc = "Debug: Restart",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<leader>du",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Debug: Terminate",
    },
    {
      "<leader>dD",
      function()
        require("dap").disconnect()
      end,
      desc = "Debug: Disconnect",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>dC",
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "Debug: Clear All Breakpoints",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debug: Set Breakpoint",
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      "<leader>dS",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: See last session result.",
    },
    {
      "<leader>dp",
      function()
        require("dap").up()
      end,
      desc = "Debug: Move up the stack",
    },
    {
      "<leader>dn",
      function()
        require("dap").down()
      end,
      desc = "Debug: Move down the stack",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.set_log_level("TRACE")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "delve",
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      element_mappings = {
        stacks = {
          open = "<CR>",
          expand = "o",
        },
      },
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    require("dap-go").setup({
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has("win32") == 0,
      },
    })
  end,
}
