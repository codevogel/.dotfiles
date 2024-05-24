local wezterm = require("wezterm")

-- Helper function to merge all the values from source table into the
-- target table, overwriting any existing values in the target table.
function mergeTable(source, target)
   for key, value in pairs(source) do
      target[key] = value
   end
end

local style = {
   font = wezterm.font("JetBrains Mono"),
   font_size = 12.0,
   line_height = 1.0,
   window_decorations = "INTEGRATED_BUTTONS|RESIZE",
   enable_scroll_bar = false,
   scrollback_lines = 3500,
   colors = {
      foreground = "#dcd7ba",
      background = "#1f1f28",
      cursor_bg = "#c8c093",
      cursor_fg = "#c8c093",
      cursor_border = "#c8c093",
      selection_fg = "#c8c093",
      selection_bg = "#2d4f67",
      scrollbar_thumb = "#16161d",
      split = "#16161d",
      ansi = {
         "#090618",
         "#c34043",
         "#76946a",
         "#c0a36e",
         "#7e9cd8",
         "#957fb8",
         "#6a9589",
         "#c8c093",
      },
      brights = {
         "#727169",
         "#e82424",
         "#98bb6c",
         "#e6c384",
         "#7fb4ca",
         "#938aa9",
         "#7aa89f",
         "#dcd7ba",
      },
      indexed = {
         [16] = "#ffa066",
         [17] = "#ff5d62",
      },
   },
}

local defaults = {
   default_domain = "WSL:Ubuntu",
   default_cwd = "~",
}

local conf = {}
mergeTable(style, conf)
mergeTable(defaults, conf)

return conf
