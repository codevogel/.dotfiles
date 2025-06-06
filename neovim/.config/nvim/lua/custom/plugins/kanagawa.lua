return {
   'rebelot/kanagawa.nvim',
   priority = 99000,
   config = function()
      -- Default options:
      require('kanagawa').setup {
         compile = false, -- enable compiling the colorscheme
         undercurl = true, -- enable undercurls
         commentStyle = { italic = true },
         functionStyle = {},
         keywordStyle = { italic = true },
         statementStyle = { bold = true },
         typeStyle = {},
         transparent = false, -- do not set background color
         dimInactive = false, -- dim inactive window `:h hl-NormalNC`
         terminalColors = true, -- define vim.g.terminal_color_{0,17}
         colors = { -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
         },
         overrides = function(colors) -- add/modify highlights
            local theme = colors.theme
            local palette = colors.palette
            return {
               Constant = { fg = palette.oldWhite },
               -- dim gutter background for treesitter-context line numbers
               TreesitterContextLineNumber = { italic = true, bg = theme.ui.bg_dim, fg = theme.ui.nontext },

               DiagnosticUnderlineError = { sp = theme.diag.error, undercurl = true },
               DiagnosticUnderlineWarn = { sp = theme.diag.warning },
               DiagnosticUnderlineInfo = { sp = theme.diag.info },
               DiagnosticUnderlineHint = { sp = theme.diag.hint },

               -- modern Telescope block-look
               TelescopeTitle = { fg = theme.ui.special, bold = true },
               TelescopePromptNormal = { bg = theme.ui.bg_p1 },
               TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
               TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
               TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
               TelescopePreviewNormal = { bg = theme.ui.bg_dim },
               TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

               -- Dark completion (popup) menu
               PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
               Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
               PmenuSbar = { bg = theme.ui.bg_m1 },
               PmenuThumb = { bg = theme.ui.bg_p2 },

               NormalFloat = { bg = 'none' },
               FloatBorder = { bg = 'none' },
               FloatTitle = { bg = 'none' },

               -- Save an hlgroup with dark background and dimmed foreground
               -- so that you can use it where your still want darker windows.
               -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
               NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

               -- Popular plugins that open floats will link to NormalFloat by default;
               -- set their background accordingly if you wish to keep them dark and borderless
               LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
               MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            }
         end,
         theme = 'wave', -- Load "wave" theme when 'background' option is not set
         background = { -- map the value of 'background' option to a theme
            dark = 'wave', -- try "dragon" !
            light = 'lotus',
         },
      }
      require('kanagawa').load()
   end,
}
