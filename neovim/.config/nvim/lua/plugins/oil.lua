return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup()
  end,
  keys = function()
    local oil = require("oil")
    return {
      { "<leader>oo", ":Oil<CR>", "n", desc = "Open Oil.nvim file explorer" },
      { "<leader>oc", ":Oil .<CR>", "n", desc = "Open Oil.nvim file explorer in CWD" },
      {
        "<leader>oh",
        function()
          oil:toggle_hidden()
        end,
        "n",
        desc = "Open Oil.nvim file explorer",
      },
    }
  end,
}
