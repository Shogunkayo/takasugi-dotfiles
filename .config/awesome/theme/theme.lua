--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")
local markup = lain.util.markup

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Separators
local space = wibox.widget.textbox(" ")
local rspace1 = wibox.widget.textbox()
local rspace0 = wibox.widget.textbox()
local rspace2 = wibox.widget.textbox()
local rspace3 = wibox.widget.textbox()
local tspace1 = wibox.widget.textbox()
tspace1.forced_width = dpi(18)
rspace1.forced_width = dpi(16)
rspace0.forced_width = dpi(18)
rspace2.forced_width = dpi(19)
rspace3.forced_width = dpi(21)

local lspace1 = wibox.widget.textbox()
local lspace2 = wibox.widget.textbox()
local lspace3 = wibox.widget.textbox()
lspace1.forced_height = dpi(18)
lspace2.forced_height = dpi(10)
lspace3.forced_height = dpi(16)

local space3 = markup.font("Roboto 3", " ")

local theme                                     = {}

theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/theme"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/theme/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/wall.jpg"
theme.useless_gap                               = 5

theme.font                                      = "JetBrainsMono Nerd Font Mono Regular 12"
theme.fg_normal                                 = "#F7EFDE"
theme.fg_focus                                  = "#3A3B41"
theme.fg_urgent                                 = "#F7EFDE"
theme.bg_normal                                 = "#3A3B41"
theme.bg_focus                                  = "#A2B674"
theme.bg_urgent                                 = "#906262"
theme.border_width                              = 2
theme.border_normal                             = "#C77674"
theme.border_focus                              = "#A2B674"
theme.border_marked                             = "#EBD6AE"

theme.taglist_spacing                           = 20
theme.taglist_border                            = 10
theme.taglist_font                              = "JetBrainsMono Nerd Font Mono Regular 19"
theme.taglist_shape_focus                       = gears.shape.rounded_rect
theme.taglist_shape_urgent                      = gears.shape.rounded_rect
theme.taglist_bg_focus                          = "#A2B674"
theme.taglist_fg_focus                          = "#494B52"
theme.taglist_bg_urgent                         = "#906262"
theme.taglist_fg_urgent                         = "#F7EFDE"

theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"

theme.widget_bg_1                               = "#EBD6AE"
theme.widget_bg_2                               = "#A9AD83"
theme.widget_bg_3                               = "#648B96"
theme.widget_bg_4                               = "#C77674"

theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"

theme.bat000charging                            = theme.icon_dir .. "/bat-000-charging.png"
theme.bat000                                    = theme.icon_dir .. "/bat-000.png"
theme.bat020charging                            = theme.icon_dir .. "/bat-020-charging.png"
theme.bat020                                    = theme.icon_dir .. "/bat-020.png"
theme.bat040charging                            = theme.icon_dir .. "/bat-040-charging.png"
theme.bat040                                    = theme.icon_dir .. "/bat-040.png"
theme.bat060charging                            = theme.icon_dir .. "/bat-060-charging.png"
theme.bat060                                    = theme.icon_dir .. "/bat-060.png"
theme.bat080charging                            = theme.icon_dir .. "/bat-080-charging.png"
theme.bat080                                    = theme.icon_dir .. "/bat-080.png"
theme.bat100charging                            = theme.icon_dir .. "/bat-100-charging.png"
theme.bat100                                    = theme.icon_dir .. "/bat-100.png"
theme.batcharged                                = theme.icon_dir .. "/bat-charged.png"
theme.ethon                                     = theme.icon_dir .. "/ethernet.png"
theme.ethoff                                    = theme.icon_dir .. "/ethernet-disconnected.png"
theme.volhigh                                   = theme.icon_dir .. "/volume-high.png"
theme.vollow                                    = theme.icon_dir .. "/volume-low.png"
theme.volmed                                    = theme.icon_dir .. "/volume-medium.png"
theme.volmutedblocked                           = theme.icon_dir .. "/volume-muted-blocked.png"
theme.volmuted                                  = theme.icon_dir .. "/volume-muted.png"
theme.voloff                                    = theme.icon_dir .. "/volume-off.png"
theme.wifidisc                                  = theme.icon_dir .. "/wireless-disconnected.png"
theme.wififull                                  = theme.icon_dir .. "/wireless-full.png"
theme.wifihigh                                  = theme.icon_dir .. "/wireless-high.png"
theme.wifilow                                   = theme.icon_dir .. "/wireless-low.png"
theme.wifimed                                   = theme.icon_dir .. "/wireless-medium.png"
theme.wifinone                                  = theme.icon_dir .. "/wireless-none.png"


-- Clock
local mytextclock = wibox.widget.textclock(markup("#494B52", space3 .. "%H : %M" .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
theme.cal = lain.widget.cal({
    attach_to = { mytextclock, mytextcalendar },
    notification_preset = {
        fg = theme.fg_normal,
        bg = theme.bg_normal,
        position = "top_right",
        font = "Monospace 10"
    }
})

-- MPD
local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    awful.button({ }, 1, function ()
        os.execute("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        os.execute("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.bat000)
local battooltip = awful.tooltip({
    objects = { baticon },
    margin_leftright = dpi(20),
    margin_topbottom = dpi(20),
    fg = theme.fg_normal,
    bg = theme.bg_normal,
    opacity = 1.0,
    border_width = 2,
    border_color = theme.bg_focus,
    font = theme.font,
    shape = gears.shape.rounded_rect,
})
local bat = lain.widget.bat({
    settings = function()
        local index, perc = "bat", tonumber(bat_now.perc) or 0

        if perc <= 5 then
            index = index .. "000"
        elseif perc <= 20 then
            index = index .. "020"
        elseif perc <= 40 then
            index = index .. "040"
        elseif perc <= 60 then
            index = index .. "060"
        elseif perc <= 80 then
            index = index .. "080"
        elseif perc <= 100 then
            index = index .. "100"
        end

        if bat_now.ac_status == 1 then
            index = index .. "charging"
        end

        baticon:set_image(theme[index])
        
        if bat_now.status == "Full" then
            battooltip:set_markup(string.format("Fully Charged"))
        elseif bat_now.ac_status == 1 then
            battooltip:set_markup(string.format("Charging: %s%%", perc))
        else
            battooltip:set_markup(string.format("Discharging: %s%%", perc))
        end
    end
})

-- Pulse volume
local volicon = wibox.widget.imagebox()
local voltooltip = awful.tooltip({
    objects = { volicon },
    margin_leftright = dpi(20),
    margin_topbottom = dpi(20),
    fg = theme.fg_normal,
    bg = theme.bg_normal,
    opacity = 1.0,
    border_width = 2,
    border_color = theme.bg_focus,
    font = theme.font,
    shape = gears.shape.rounded_rect,
})
local volume = awful.widget.watch(
    'bash -c "pacmd list-sinks | grep -e volume -e muted"',
    1,
    function(widget, stdout)
        local index = ""
        -- assuming volume in both left and right will be same
        local perc = tonumber(stdout:match("(%d+)%%"))
        local isMuted = stdout:match("muted: (%a+)")

        if isMuted == "no" then
            if perc <= 5 then
                index = "volmuted"
            elseif perc <= 25 then
                index = "vollow"
            elseif perc <= 75 then
                index = "volmed"
            else
                index = "volhigh"
            end
            voltooltip:set_markup(string.format("Volume: %d%%", perc))
        else
            index = "volmutedblocked"
            voltooltip:set_markup(string.format("Volume: Muted"))
        end
        volicon:set_image(theme[index])

    end
)

volicon:buttons(my_table.join (
    awful.button({}, 1, function() -- left click
        awful.spawn("kitty -e pacmixer")
    end),
    awful.button({}, 3, function() -- right click
        os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    end)
))

-- Wifi carrier and signal strength
local wificon = wibox.widget.imagebox(theme.wifidisc)
local isEthernet = false
local mywifisig = awful.widget.watch(
    { awful.util.shell, "-c", "awk 'NR==3 {printf(\"%d-%.0f\\n\",$2, $3*10/7)}' /proc/net/wireless; iw dev wlan0 link" },
    2,
    function(widget, stdout)
        if not isEthernet then
            local carrier, perc = stdout:match("(%d)-(%d+)")
            perc = tonumber(perc)

            if carrier == "1" or not perc then
                wificon:set_image(theme.wifidisc)
            else
                if perc <= 5 then
                    wificon:set_image(theme.wifinone)
                elseif perc <= 25 then
                    wificon:set_image(theme.wifilow)
                elseif perc <= 50 then
                    wificon:set_image(theme.wifimed)
                elseif perc <= 75 then
                    wificon:set_image(theme.wifihigh)
                else
                    wificon:set_image(theme.wififull)
                end
            end
        end
    end
)

local ethersig = awful.widget.watch(
    'bash -c "ip route | grep enp2s0 | wc -l"',
    2,
    function (widget, stdout)
        local isether = tonumber(stdout)
        if isether < 1 then
            isEthernet = false
        else
            isEthernet = true
            wificon:set_image(theme.ethon)
        end
    end
)

wificon:connect_signal("button::press", function(lx, ly, unknown, button, find_widgets_result)
    if button == 1 then
        awful.spawn("kitty -e nmtui")
    elseif isEthernet == false then
        awful.spawn(string.format("%s -e wavemon", awful.util.terminal))
    end
end)

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, dpi(16), dpi(16)), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist{
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
    }

    local mpd_widget = wibox.widget {
        mpdicon,
        theme.mpd.widget,
        layout = wibox.layout.align.horizontal
    }

    local l_space1 = wibox.widget.textbox()

    -- Create the wibox
    s.wibox = awful.wibar({
        position = "top",
        screen = s,
        height = 30,
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        margins = {
            top = 0,
            left = 14,
            right = 14,
            bottom = 0
        }
    })

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(wibox.container.margin(mpd_widget, dpi(3), dpi(6)), theme.widget_bg_3),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            rspace1,
            wibox.container.background(wibox.container.margin(wificon, dpi(20), dpi(20), dpi(3), dpi(3)), theme.widget_bg_2),
            wibox.container.background(wibox.container.margin(baticon, dpi(20), dpi(20), dpi(3), dpi(3)), theme.widget_bg_3),
            wibox.container.background(wibox.container.margin(mytextclock, dpi(20), dpi(20), dpi(7), dpi(3)), theme.widget_bg_1),
        },
    }
end

return theme
