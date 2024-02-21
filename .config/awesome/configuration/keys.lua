require("configuration.init")

-- A client keybinding only works when a window is focused
-- while a global one works all the time.

globalkeys = mytable.join(
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
            hotkeys_popup.show_help
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
            awful.screen.focus_relative(+1)
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
    awful.key({ modkey, "Control" }), "=",
        function()
            beautiful.useless_gaps = beautiful.useless_gaps + 1
        end,
        {description = "increase gap between windows", group = "client"}
    ),
    awful.key({ modkey, "Control" }), "-",
        function()
            beautiful.useless_gaps = beautiful.useless_gaps - 1
        end,
        {description = "decrease gap between windows", group = "client"}
    ),

    awful.key({ modkey }, "j",
        function()
            awful.client.focus.byidx(+1)
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
            awful.client.swap.byidx(+1)
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
            awful.tag.incmwfact(+0.05)
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
            awful.tag.viewprev
        end,
        {description = "go to previous tab", group = "tag"}
    ),
    awful.key({ modkey }, "Right",
        function()
            awful.tag.viewnext
        end,
        {description = "go to next tab", group = "tag"}
    ),
    awful.key({ modkey }, "Esc",
        function()
            awful.tag.history.restore
        end,
        {description = "go to last tab in history", group = "tag"}
    ),

    awful.key({ modkey, "Shift" }, "l",
        function()
            awful.tag.incmaster(+1, nil, true)
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
            awful.tag.inccol(+1, nil, true)
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
)
