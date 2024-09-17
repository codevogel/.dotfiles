return {
   'ray-x/lsp_signature.nvim',
   event = 'VeryLazy',
   opts = {
      hint_inline = function()
         return false
      end,
      hint_enable = false,
      doc_lines = 0,
      max_height = 3,
      handler_opts = {
         border = 'rounded',
      },
      floating_window_off_x = 12,
      floating_window_off_y = 4,
   },
   config = function(_, opts)
      require('lsp_signature').setup(opts)
   end,
}
