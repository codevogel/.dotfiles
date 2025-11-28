return {
  "saghen/blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
        },
      },
    },
  },
}
