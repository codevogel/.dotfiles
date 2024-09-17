return {
   {
      'https://github.com/hrsh7th/cmp-nvim-lsp',
   },

   {
      'hrsh7th/nvim-cmp',

      dependencies = {
         'L3MON4D3/LuaSnip',
         'saadparwaiz1/cmp_luasnip',
         'onsails/lspkind.nvim',
      },

      config = function()
         local cmp = require 'cmp'
         local lspkind = require 'lspkind'

         cmp.setup {
            snippet = {
               expand = function(args)
                  require('luasnip').lsp_expand(args.body)
               end,
            },
            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert {
               ['<C-b>'] = cmp.mapping.scroll_docs(-4),
               ['<C-f>'] = cmp.mapping.scroll_docs(4),
               ['<C-Space>'] = cmp.mapping.complete(),
               ['<C-e>'] = cmp.mapping.abort(),
               ['<CR>'] = cmp.mapping.confirm { select = true },
            },
            sources = cmp.config.sources({
               { name = 'nvim_lsp' },
            }, {
               { name = 'buffer' },
            }),
            formatting = {
               format = lspkind.cmp_format {
                  mode = 'symbol',
                  maxwidth = 50,
                  ellipsis_char = '...',
                  show_labelDetails = true,
                  before = function(entry, vim_item)
                     return vim_item
                  end,
               },
            },
         }
      end,
   },
}
