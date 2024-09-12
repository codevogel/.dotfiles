return {
   { -- Autoformat
      'stevearc/conform.nvim',
      lazy = false,
      keys = {
         {
            '<leader>f',
            function()
               require('conform').format { async = true, lsp_fallback = true }
            end,
            mode = '',
            desc = '[F]ormat buffer',
         },
      },
      opts = {
         notify_on_error = false,
         format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            return {
               timeout_ms = 500,
               lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
         end,
         formatters_by_ft = {
            lua = { 'stylua' },
            json = { 'jq' },
            gdscript = { 'gdformat' },

            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            -- javascript = { { "prettierd", "prettier" } },
         },
         formatters = {
            beautysh = {
               condition = function()
                  -- check if the filename does not contain the word "_spec"
                  return not vim.fn.expand('%:t'):match '.sh'
               end,
            },
         },
      },
   },
}
-- vim: ts=2 sts=2 sw=2 et
