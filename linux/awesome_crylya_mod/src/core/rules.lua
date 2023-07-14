-------------------------------------------------------------------------------------------------
-- This class contains rules for float exceptions or special themeing for certain applications --
-------------------------------------------------------------------------------------------------

-- Awesome Libs
local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

awful.rules.rules = {
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus        = awful.client.focus.filter,
      raise        = true,
      keys         = require("../../mappings/client_keys"),
      buttons      = require("../../mappings/client_buttons"),
      screen       = awful.screen.preferred,
      placement    = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },
  {
    rule_any = {
      instance = {},
      class = {
        "Arandr",
        "Lxappearance",
        "kdeconnect.app",
        "zoom",
        "file-roller",
        "File-roller"
      },
      name = {},
      role = {
        "AlarmWindow",
        "ConfigManager",
        "pop-up"
      }
    },
    properties = { floating = true, titlebars_enabled = true }
  },
  {
    id = "titlebar",
    rule_any = {
      type = { "normal", "dialog", "modal", "utility" }
    },
    properties = { titlebars_enabled = true }
  },
  {
    rule = {class = "Code"},
    properties = {
      screen = 1,
      tag = "2",
      switchtotag = true
    }
  },
  {
    rule = {class = "firefox"},
    properties = {
      screen = 1,
      tag = "3",
      switchtotag = true
    }
  },
  {
    rule = {class = "notion-app"},
    properties = {
      screen = 1,
      tag = "4",
      properties = { floating = false },
      switchtotag = true
    }
  },
  {
    rule = {class = "discord"},
    properties = {
      screen = 1,
      tag = "6",
      switchtotag = true
    }
  }
}

awful.spawn.easy_async_with_shell(
  "cat ~/.config/awesome/src/assets/rules.txt",
  function(stdout)
  for class in stdout:gmatch("%a+") do
    ruled.client.append_rule {
      rule = { class = class },
      properties = {
        floating = true
      },
    }
  end
end
)

-- Workaround to map spotify client to specific tag
client.connect_signal("property::class", function(c)
   if c.class == "Spotify" then
      c:move_to_screen(1)
      c:move_to_tag(screen[1].tags[6])
      tag = awful.tag.gettags(1)[6]
      if tag then
        awful.tag.viewonly(tag)
      end
   end
end)
