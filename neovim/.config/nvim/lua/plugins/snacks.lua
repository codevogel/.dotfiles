return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    ---- explorer
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File [e]xplorer",
    },
    ---- search
    -- search files
    {
      "<leader>sf",
      function()
        Snacks.picker.smart()
      end,
      desc = "[s]earch [f]iles",
    },
    {
      "<leader>sn",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "[s]earch [n]eovim files",
    },
    -- search grep
    {
      "<leader>sga",
      function()
        Snacks.picker.grep()
      end,
      desc = "[s]earch [g]rep [a]ll",
    },
    {
      "<leader>sgb",
      function()
        Snacks.picker.lines()
      end,
      desc = "[s]earch [g]rep [b]uffer",
    },
    -- search quickfix
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "[s]earch [q]uickfix",
    },
    ---- lsp
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "[g]oto [d]efinition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "[g]oto [D]eclaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "[g]oto [r]eferences",
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "[g]oto [i]mplementation",
    },
    {
      "gt",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto [t]ype Definition",
    },
    ---- zen
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle [Z]en mode",
    },
  },
}
