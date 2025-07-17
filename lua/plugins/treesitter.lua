return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    config = function()
      -- Register the Bruno parser before setting up treesitter
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.bruno = {
        install_info = {
          url = "https://github.com/Scalamando/tree-sitter-bruno",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "bruno",
      }

      -- Set up filetype detection for .bru files
      vim.filetype.add({
        extension = {
          bru = "bruno",
        },
      })

      -- NOTE: On adding bruno, the above only adds the syntaxt tree, the highlight queries must be installed manually
      -- 1. mkdir -p ~/.config/nvim/queries/bruno
      -- 2. move the queries/highlights.scm and queries/injections.scm to ~/.config/nvim/queries/bruno/x.scm
      -- 3. Force reload: TSBufToggle highlight
      -- End Register Bruno

      -- Now configure treesitter with your existing options
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "bruno",
          "c",
          "go",
          "javascript",
          "diff",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
      })
    end,

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
