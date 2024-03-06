pcall(require, "luarocks.loader")

-- Modules --------------------------------------------------------------
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
local lain          = require("lain")

-- Autostart ------------------------------------------------------------
awful.spawn("picom --animations -b")
awful.spawn.with_shell("sh ~/.screenlayout/default.sh")

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- Error ----------------------------------------------------------------
if awesome.startup_errors then
    naughty.notify {
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
        bg = beautiful.bg_urgent,
        fg = beautiful.fg_urgent,
        border_color = beautiful.bg_urgent
    }
end

do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        if in_error then return end

        in_error = true

        naughty.notify {
            title = "Oops, an error happened!",
            text = tostring(err),
            bg = beautiful.bg_urgent,
            fg = beautiful.fg_urgent,
            border_color = beautiful.bg_urgent
        }

        in_error = false
    end)
end

-- Defaults -------------------------------------------------------------
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor
local filemanager = "lf"
local modkey = "Mod1"
local browser = "vivaldi"

-- Tags -----------------------------------------------------------------
awful.util.terminal = terminal
awful.util.tagnames = { "   ♚   ", "   ♛   ", "   ♝   ", "   ♞   ", "   ♜   " }
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair
}

awful.util.taglist_buttons = mytable.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = mytable.join(
     awful.button({ }, 1, function(c)
         if c == client.focus then
             c.minimized = true
         else
             c:emit_signal("request::activate", "tasklist", { raise = true })
         end
     end),
     awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
     end),
     awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
     awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

beautiful.init("~/.config/awesome/theme/theme.lua")

-- Screen ---------------------------------------------------------------

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
    for _, c in pairs(s.clients) do
        if c.maximized or c.fullscreen then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
    function(s)
        beautiful.at_screen_connect(s)
    end)

-- Key bindings ---------------------------------------------------------
globalkeys = gears.table.join(
    -- Awesome
    awful.key({ modkey }, "b",
        function()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox on/off", group = "awesome"}
    ),
    awful.key({ modkey }, "s",
        function()
            hotkeys_popup.show_help()
        end,
        {description = "show help", group = "awesome"}
    ),  
    
    awful.key({ modkey }, "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next layout", group = "awesome"}
    ),
    awful.key({ modkey, "Shift" }, "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select prev layout", group = "awesome"}
    ),

    -- System
    awful.key({ modkey, "Control" }, "r",
        awesome.restart,
        {description = "restart awesome", group = "system"}
    ),
    awful.key({ modkey, "Shift" }, "r",
        awesome.quit,
        {desrciption = "quit awesome", group = "system"}
    ),

    awful.key({ }, "XF86AudioLowerVolume",
        function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end,
        {description = "lower volyme by 5%", group = "system"}
    ),
    awful.key({ }, "XF86AudioRaiseVolume",
        function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end,
        {description = "raise volume by 5%", group = "system"}
    ),
    awful.key({ }, "XF86AudioMute",
        function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end,
        {description = "toggle volume on/off", group = "system"}
    ),
    awful.key({ modkey, "Control" }, "m",
        function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end,
        {description = "toggle volume on/off", group = "system"}
    ),

    awful.key({ }, "XF86MonBrightnessUp",
        function()
            os.execute("brightnessctl set 5%+")
        end,
        {description = "increase brightness by 5%", group = "system"}
    ),
    awful.key({ }, "XF86MonBrightnessDown",
        function()
            os.execute("brightnessctl set 5%-")
        end,
        {description = "decrease brightness by 5%", group = "system"}
    ),

    awful.key({ modkey, "Control"}, "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus next screen", group = "system"}
    ),
    awful.key({ modkey, "Control"}, "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus prev screen", group = "system"}
    ),

    -- Client
    awful.key({ modkey, "Control" }, "=",
        function()
            beautiful.useless_gap = beautiful.useless_gap + 1
        end,
        {description = "increase gap between windows", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "-",
        function()
            beautiful.useless_gap = beautiful.useless_gap - 1
        end,
        {description = "decrease gap between windows", group = "client"}
    ),

    awful.key({ modkey }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next client by index", group = "client"}
    ),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus prev client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift" }, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift" }, "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with prev client by index", group = "client"}
    ),
    
    awful.key({ modkey }, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master client width", group = "client"}
    ),
    awful.key({ modkey }, "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master client width", group = "client"}
    ),

    -- Tags
    awful.key({ modkey }, "Left",
        function()
            awful.tag.viewprev()
        end,
        {description = "go to previous tab", group = "tag"}
    ),
    awful.key({ modkey }, "Right",
        function()
            awful.tag.viewnext()
        end,
        {description = "go to next tab", group = "tag"}
    ),
    awful.key({ modkey }, "Escape",
        function()
            awful.tag.history.restore()
        end,
        {description = "go to last tab in history", group = "tag"}
    ),

    awful.key({ modkey, "Shift" }, "l",
        function()
            awful.tag.incmaster(1, nil, true)
        end,
        {description = "increase number of master clients", group = "tag"}
    ),
    awful.key({ modkey, "Shift" }, "h",
        function()
            awful.tag.incmaster(-1, nil, true)
        end,
        {description = "decrease number of master clients", group = "tag"}
    ),
    awful.key({ modkey, "Control" }, "l",
        function()
            awful.tag.inccol(1, nil, true)
        end,
        {description = "increase number of columns", group = "tag"}
    ),
    awful.key({ modkey, "Control" }, "h",
        function()
            awful.tag.inccol(-1, nil, true)
        end,
        {description = "decrease number of columns", group = "tag"}
    ),

    -- General apps
    awful.key({ modkey }, "r",
        function()
            awful.spawn(terminal)
        end,
        {description = "open terminal", group = "terminal"}
    ),

    awful.key({ modkey, "Shift" }, "m",
        function()
            awful.spawn.with_shell(string.format("%s -e pacmixer", terminal))
        end,
        {description = "open pacmixer", group = "terminal"}
    ),

    awful.key({ modkey }, "o",
        function()
            awful.spawn.with_shell(string.format("%s -e lf -command fzf_jump", terminal))
        end,
        {description = "open lf file manager", group = "terminal"}
    ),

    awful.key({ modkey }, "q",
        function()
            awful.spawn.with_shell("rofi -show drun -theme ~/.config/rofi/launcher.rasi")
        end,
        {description = "open rofi", group = "rofi"}
    ),
    awful.key({ modkey, "Shift" }, "q",
        function()
            awful.spawn.with_shell("~/.config/rofi/applets/powermenu.sh")
        end,
        {description = "open rofi powermenu", group = "rofi"}
    ),
    awful.key({ modkey, "Control" }, "q",
        function()
            awful.spawn.with_shell("~/.config/rofi/applets/mpd.sh")
        end,
        {description = "open rofi mpd", group = "rofi"}
    ),

    awful.key({ modkey, "Shift" }, "s",
        function()
            awful.spawn.with_shell("flameshot gui")
        end,
        {description = "open flameshot gui", group = "flameshot"}
    ),

    awful.key({ modkey }, "n",
        function()
            awful.spawn("mpc next")
        end,
        {deescription = "play next song", group = "mpd"}
    ),
    awful.key({ modkey }, "p",
        function()
            awful.spawn("mpc prev")
        end,
        {description = "play prev song", group = "mpd"}
    ),
    awful.key({ modkey, "Control" }, "p",
        function()
            awful.spawn("mpc toggle")
        end,
        {description = "toggle play/pause", group = "mpd"}
    ),
    awful.key({ modkey, "Shift" }, "n",
        function()
            awful.spawn.with_shell(string.format("%s -e ncmpcpp", terminal))
        end,
        {description = "open ncmpcpp", group = "terminal"}
    ),

    -- Send a test notification
    -- info at https://awesomewm.org/doc/api/libraries/naughty.html#notify
    awful.key({ modkey, "Shift"   }, "t", function ()
        --[[ local notif_icon = gears.surface.load_uncached(
                           gears.filesystem.get_configuration_dir() .. "path/to/icon") ]]
        naughty.notify({
            -- screen = 1,
            -- timeout = 0,-- in seconds
            -- ignore_suspend = true,-- if true notif shows even if notifs are suspended via naughty.suspend
            -- fg = "#ff0",
            -- bg = "#ff0000",
            title = "Test Title",
            text = "Test Notification",
            -- icon = gears.color.recolor_image(notif_icon, "#ff0"),
            -- icon_size = 24,-- in px
            -- border_color = "#ffff00",
            -- border_width = 2,
        })
    end,
        {description = "send test notification", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"}, "c",
        function(c)
            c:kill()
        end,
        {description = "close client", group = "client"}
    ),

    awful.key({ modkey }, "]",
        function(c)
            c.minimized = true
        end,
        {description = "minimize client", group = "client"}
    ),

    awful.key({ modkey }, "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move client to master", group = "client"}
    ),

    awful.key({ modkey }, "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle client on top", group = "client"}
    ),
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen mode", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "space",
        function()
            awful.client.floating.toggle()
        end,
        {description ="toggle floating mode", group = "client"}
    ),

    awful.key({ modkey }, "e",
        function(c)
            c:move_to_screen()
        end,
        {description = "move client to different screen", group = "client"}
    ),

    -- Snap floating windows
    awful.key({ modkey, "Shift"}, "w",
        function(c)
            c.height = screen[c.screen].workspace.height / 2 - beautiful.useless_gap * 3/2
            c.width = screen[c.screen].workspace.width / 2 - beautiful.useless_gap * 3/2
            c.x = screen[c.screen].workarea.x + screen[c.screen].workarea.x + beautiful.uselss_gap
            c.y = screen[c.screen].workarea.y + beautiful.useless_gap
        end,
        {description = "snap top left", group = "floating client"}
    ),
	awful.key({ modkey, "Control" }, "a",
        function (c)
            c.height = screen[c.screen].workarea.height/2 - beautiful.useless_gap*3/2
            c.width = screen[c.screen].workarea.width/2 - beautiful.useless_gap*3/2
            c.x = screen[c.screen].workarea.x + screen[c.screen].workarea.x + beautiful.useless_gap
            c.y = screen[c.screen].workarea.y + screen[c.screen].workarea.height/2 + beautiful.useless_gap/2
        end,
        {description = "snap bottom left", group = "floating client"}
    ),
	awful.key({ modkey, "Control" }, "s",
        function (c)
            c.height = screen[c.screen].workarea.height/2 - beautiful.useless_gap*3/2
            c.width = screen[c.screen].workarea.width/2 - beautiful.useless_gap*3/2
            c.x = screen[c.screen].workarea.width/2 + beautiful.useless_gap/2
            c.y = screen[c.screen].workarea.y + screen[c.screen].workarea.height/2 + beautiful.useless_gap/2
        end,
        {description = "snap bottom right", group = "floating client"}
    ),
	awful.key({ modkey, "Control" }, "d",
        function (c)
            c.height = screen[c.screen].workarea.height/2 - beautiful.useless_gap*3/2
            c.width = screen[c.screen].workarea.width/2 - beautiful.useless_gap*3/2
            c.x = screen[c.screen].workarea.width/2 + beautiful.useless_gap/2
            c.y = screen[c.screen].workarea.y + beautiful.useless_gap
        end,
        {description = "snap top right", group = "floating client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                   tag:view_only()
                end
          end,
          {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- mouse button bindings
clientbuttons = gears.table.join(
    awful.button({ modkey }, 1,
        function (c)
            c.emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button({ modkey }, 3,
        function(c)
            c.emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

-- set global keys
root.keys(globalkeys)

-- Window rules ---------------------------------------------------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            callback = awful.client.setslave,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },

    -- Floating clients.
    { 
        rule_any = {
            instance = {
                "pinentry",
            },
            class = {
                "Arandr",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = { "normal", "dialog" }},
        properties = { titlebars_enabled = true }
    },
}


-- Signals --------------------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- switch to parent after closing child window
local function backham()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end

-- attach to minimized state
client.connect_signal("property::minimized", backham)
-- attach to closed state
client.connect_signal("unmanage", backham)
-- ensure there is always a selected client during tag switching or logins
tag.connect_signal("property::selected", backham)
