return {
   'github/copilot.vim',
   config = function()
      vim.print 'Setting up Copilot'
      vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
         expr = true,
         replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
   end,
}
