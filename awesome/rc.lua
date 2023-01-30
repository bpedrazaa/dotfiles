-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
  require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain = require("lain")
local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
  require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi = require("beautiful.xresources").apply_dpi
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
  for _, cmd in ipairs(cmd_arr) do
    awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
  end
end

run_once({"unclutter -root"}) -- entries must be comma-separated
-- }}}

-- {{{ Variable definitions
-- keep themes in alfabetical order for ATT
local themes = {
  "blackburn",
  "copland",
  "multicolor",
  "powerarrow",
  "powerarrow-blue",
  "powerarrow-dark",
  "powerarrow-mod",
}

-- choose your theme here
local chosen_theme = themes[7]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- modkey or mod4 = super key
local modkey       = "Mod4"
local modkey1      = "Control"
local altkey       = "Mod1"

-- personal variables
--change these variables if you want
local browser           = "firefox"
local editorgui         = "code"
local filemanager       = "thunar"
local mailclient        = "thunderbird"
local mediaplayer       = "spotify"
local terminal          = "alacritty"

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = {"", "", "󰈹", "󰠮", "󰀻"}
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  --awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  --awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  --awful.layout.suit.corner.nw,
  --awful.layout.suit.corner.ne,
  --awful.layout.suit.corner.sw,
  --awful.layout.suit.corner.se,
  --lain.layout.cascade,
  --lain.layout.cascade.tile,
  --lain.layout.centerwork,
  --lain.layout.centerwork.horizontal,
  --lain.layout.termfair,
  --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({modkey}, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({modkey}, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
  awful.button({}, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({}, 3, function ()
    local instance = nil

    return function ()
      if instance and instance.wibox.visible then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({theme = {width = dpi(250)}})
      end
    end
  end),
  awful.button({}, 4, function () awful.client.focus.byidx(1) end),
  awful.button({}, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = dpi(2)
lain.layout.cascade.tile.offset_y = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}

-- {{{ Menu
local myawesomemenu = {
  {"hotkeys", function() return false, hotkeys_popup.show_help end},
  {"arandr", "arandr"},
}

awful.util.mymainmenu = freedesktop.menu.build({
  before = {
    {"Awesome", myawesomemenu},
    -- other triads can be put here
  },
  after = {
    {"Terminal", terminal},
    {"Log out", function() awesome.quit() end},
    {"Sleep", "systemctl suspend"},
    {"Restart", "systemctl reboot"},
    {"Shutdown", "systemctl poweroff"},
    -- other triads can be put here
  }
})
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
  local only_one = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if only_one and not c.floating or c.maximized then
      c.border_width = 2
    else
      c.border_width = beautiful.border_width
    end
  end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s)
  s.systray = wibox.widget.systray()
  s.systray.visible = true
end)
-- }}}



-- {{{ Mouse bindings
root.buttons(my_table.join(
  awful.button({}, 3, function () awful.util.mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
-- }}}



-- {{{ Key bindings
local globalkeys = my_table.join(
  -- super
  awful.key({modkey}, "Return", function () awful.spawn(terminal) end,
    {description = terminal, group = "super"}),
  awful.key({modkey}, "w", function () awful.util.spawn( browser ) end,
    {description = browser, group = "super"}),
  awful.key({modkey}, "c", function () awful.util.spawn( "conky-toggle" ) end,
    {description = "conky-toggle", group = "super"}),
  awful.key({modkey}, "e", function () awful.util.spawn( editorgui ) end,
    {description = "run gui editor", group = "super"}),
  awful.key({modkey}, "d", function () awful.util.spawn( "rofi -show drun" ) end,
    {description = "rofi theme selector", group = "super"}),
  awful.key({modkey}, "v", function () awful.util.spawn( "pavucontrol" ) end,
    {description = "pulseaudio control", group = "super"}),
  awful.key({modkey}, "x",  function () awful.util.spawn( "archlinux-logout" ) end,
    {description = "exit", group = "super"}),
  awful.key({modkey}, "Escape", function () awful.util.spawn( "xkill" ) end,
    {description = "Kill proces", group = "super"}),

  -- super+shift
  awful.key({modkey, "Shift"}, "d",
    function ()
      awful.spawn(string.format("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn NotoMonoRegular:bold:pixelsize=14",
      beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
    end,
    {description = "show dmenu", group = "super+shift"}),

  -- ctrl+alt
  awful.key({modkey1, altkey}, "o", function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
    {description = "Picom toggle", group = "alt+ctrl"}),

  -- screenshots
  awful.key({}, "Print", function () awful.util.spawn("scrot 'screenshot-%Y-%m-%d-%s.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'") end,
    {description = "Scrot", group = "screenshots"}),
  awful.key({modkey}, "Print", function () awful.util.spawn( "xfce4-screenshooter" ) end,
    {description = "Xfce screenshot", group = "screenshots"}),

  -- hotkeys Awesome
  awful.key({modkey}, "s", hotkeys_popup.show_help,
    {description = "show help", group="awesome"}),

  -- non-empty tag browsing
  awful.key({modkey}, "Tab", function () lain.util.tag_view_nonempty(1) end,
    {description = "view next nonempty", group = "tag"}),
  awful.key({modkey, "Shift"}, "Tab", function () lain.util.tag_view_nonempty(-1) end,
    {description = "view  previous nonempty", group = "tag"}),

  -- By direction client focus
  awful.key({modkey}, "j",
    function()
      awful.client.focus.global_bydirection("down")
      if client.focus then client.focus:raise() end
    end,
    {description = "focus down", group = "client"}),
  awful.key({modkey}, "k",
    function()
      awful.client.focus.global_bydirection("up")
      if client.focus then client.focus:raise() end
    end,
    {description = "focus up", group = "client"}),
  awful.key({modkey}, "h",
    function()
      awful.client.focus.global_bydirection("left")
      if client.focus then client.focus:raise() end
    end,
    {description = "focus left", group = "client"}),
  awful.key({modkey}, "l",
    function()
      awful.client.focus.global_bydirection("right")
      if client.focus then client.focus:raise() end
    end,
    {description = "focus right", group = "client"}),

  -- Layout manipulation
  awful.key({modkey, "Shift"}, "j", function () awful.client.swap.byidx(1) end,
    {description = "swap with next client by index", group = "layout"}),
  awful.key({modkey, "Shift"}, "k", function () awful.client.swap.byidx(-1) end,
    {description = "swap with previous client by index", group = "layout"}),
  awful.key({altkey, "Shift"}, "l", function () awful.tag.incmwfact(0.05) end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({altkey, "Shift"}, "h",     function () awful.tag.incmwfact(-0.05) end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key({modkey}, "Right", function () awful.layout.inc(1) end,
    {description = "select next layout", group = "layout"}),
  awful.key({modkey}, "Left", function () awful.layout.inc(-1) end,
    {description = "select previous layout", group = "layout"}),

  -- Show/Hide Wibox
  awful.key({modkey}, "b", function ()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
        if s.mybottomwibox then
          s.mybottomwibox.visible = not s.mybottomwibox.visible
        end
      end
    end,
    {description = "toggle wibox", group = "awesome"}),

  -- Show/Hide Systray
  awful.key({modkey}, "-", function ()
      awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end,
    {description = "Toggle systray visibility", group = "awesome"}),

  -- On the fly useless gaps change
  awful.key({altkey, "Control"}, "j", function () lain.util.useless_gaps_resize(1) end,
    {description = "increment useless gaps", group = "tag"}),
  awful.key({altkey, "Control"}, "h", function () lain.util.useless_gaps_resize(-1) end,
    {description = "decrement useless gaps", group = "tag"}),

  -- Standard program
  awful.key({modkey, "Shift"}, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),

  -- Brightness
  awful.key({}, "XF86MonBrightnessUp", function () os.execute("light -A 10") end,
    {description = "+10%", group = "hotkeys"}),
  awful.key({}, "XF86MonBrightnessDown", function () os.execute("light -U 10") end,
    {description = "-10%", group = "hotkeys"}),

  -- ALSA volume control
  awful.key({}, "XF86AudioRaiseVolume",
    function ()
      os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
      beautiful.volume.update()
    end),
  awful.key({}, "XF86AudioLowerVolume",
    function ()
      os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
      beautiful.volume.update()
    end),
  awful.key({}, "XF86AudioMute",
    function ()
      os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
      beautiful.volume.update()
    end),

  --Media keys supported by vlc, spotify, audacious, xmm2, ...
  awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
  awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
  awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
  awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end)
)

local clientkeys = my_table.join(
  awful.key({modkey}, "space", lain.util.magnify_client,
    {description = "magnify client", group = "client"}),
  awful.key({modkey}, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({modkey}, "q", function (c) c:kill() end,
    {description = "close", group = "hotkeys"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_move
  if i == 1 or i == 9 then
    descr_view = {description = "view tag #", group = "tag"}
    descr_move = {description = "move focused client to tag #", group = "tag"}
  end
  globalkeys = my_table.join(globalkeys,
  -- View tag only.
  awful.key({modkey}, "#" .. i + 9,
    function ()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end,
    descr_view),
    -- Move client to tag.
    awful.key({modkey, "Shift"}, "#" .. i + 9,
    function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
          tag:view_only()
        end
      end
    end,
    descr_move)
  )
end

local clientbuttons = gears.table.join(
  awful.button({}, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
  awful.button({modkey}, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
    end),
  awful.button({modkey}, 3, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hints_honor = false
    }
  },
  -- Titlebars
  {
    rule_any = {
      type = {
        "dialog",
        "normal"
      }
    },
    properties = {titlebars_enabled = false}
  },
  -- Set applications to always map on the specific screen and tag.
  -- find class or role via xprop command
  {
    rule = {class = "Code"},
    properties = {
      screen = 1,
      tag = awful.util.tagnames[2],
      switchtotag = true
    }
  },
  {
    rule = {class = browser},
    properties = {
      screen = 1,
      tag = awful.util.tagnames[3],
      switchtotag = true
    }
  },
  {
    rule = {class = "notion-app"},
    properties = {
      screen = 1,
      tag = awful.util.tagnames[4],
      switchtotag = true
    }
  },
  {
    rule = {class = "discord"},
    properties = {
      screen = 1,
      tag = awful.util.tagnames[5],
      switchtotag = true
    }
  },
  -- Set applications to be maximized at startup.
  -- find class or role via xprop command
  -- {
  --   rule = {class = editorgui},
  --   properties = {maximized = true}
  -- },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
      },
      class = {
        "Arandr",
        "Arcolinux-welcome-app.py",
        "Blueberry",
        "Galculator",
        "Gnome-font-viewer",
        "Gpick",
        "Imagewriter",
        "Font-manager",
        "Kruler",
        "MessageWin",  -- kalarm.
        "archlinux-logout",
        "Peek",
        "Skype",
        "System-config-printer.py",
        "Sxiv",
        "Unetbootin.elf",
        "Wpa_gui",
        "pinentry",
        "veromix",
        "xtightvncviewer",
      },
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        "Preferences",
        "setup",
      }
    },
    properties = {floating = true}
  },
  -- Floating clients but centered in screen
  {
    rule_any = {
      class = {
        "Polkit-gnome-authentication-agent-1",
        "Arcolinux-calamares-tool.py"
      },
    },
    properties = {floating = true},
    callback = function (c)
      awful.placement.centered(c,nil)
    end
  }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and
    not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- Custom
  if beautiful.titlebar_fun then
    beautiful.titlebar_fun(c)
    return
  end

  -- Default
  -- buttons for the titlebar
  local buttons = my_table.join(
    awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
      end),
    awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
      end)
  )

  awful.titlebar(c, {size = dpi(21)}) : setup
    {
      {
        -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
      },
      {
        -- Middle
        {
          -- Title
          align  = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
      },
      {
        -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Workaround to map spotify client to specific tag
client.connect_signal("property::class", function(c)
   if c.class == "Spotify" then
      c:move_to_screen(1)
      c:move_to_tag(screen[1].tags[5])
      tag = awful.tag.gettags(1)[5]
      if tag then
        awful.tag.viewonly(tag)
      end
   end
end)
-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")
