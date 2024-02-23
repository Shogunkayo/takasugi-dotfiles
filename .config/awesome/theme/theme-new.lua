----------------------------
-- Pigroy's awesome theme --
----------------------------

local theme = {}

local shapes = require("gears.shape")
local naughty = require("naughty")
local nconf = naughty.config
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local animation = require("modules.animation")
local xrsrc = require("beautiful.xresources")
local dpi = xrsrc.apply_dpi
local beautiful = require("beautiful")

theme.font = "JetBrainsMono NF"

--- color scheme ---
theme.bg       = "#1c1b17"
theme.fg       = "#e5e0c9"
theme.red      = "#f26d4f"
theme.lred     = "#d18777"
theme.green    = "#a5dd4f"
theme.lgreen   = "#a0b77c"
theme.dgreen   = "#626b55"
theme.yellow   = "#ddc14d"
theme.lyellow  = "#c6b675"
theme.blue     = "#4d8ee2"
theme.lblue    = "#6e8db5"
theme.magenta  = "#b46dce"
theme.lmagenta = "#a589af"
theme.cyan     = "#4bc6c0"
theme.lcyan    = "#80b5b2"
theme.disabled = "#8c8775"

--- general window ---
theme.useless_gap   = 7
theme.border_width  = 2
theme.border_normal = theme.disabled
theme.border_focus  = theme.lgreen

--- titlebars ---
theme.titlebar_bg_normal = theme.bg
theme.titlebar_bg_focus = theme.bg
theme.titlebar_fg_normal = theme.fg
theme.titlebar_fg_focus = theme.fg

-- notifications --
nconf.defaults.border_width = 2
nconf.defaults.shape = shapes.rounded_rect
nconf.defaults.timeout = 3
nconf.defaults.icon_size = 100
nconf.padding = 15

theme.notification_font = "JetBrainsMono Nerd Font Mono Bold 12"
theme.notification_bg = theme.bg
theme.notification_fg = theme.fg
theme.notification_border_color = theme.lyellow
theme.notification_width = 500
theme.notification_margin = 8

--- status bar ---
theme.wibar_ontop        = true
theme.wibar_type         = "dock"
theme.wibar_bg           = theme.bg
theme.wibar_fg           = theme.fg

--- taglist ---
theme.taglist_spacing = 10
theme.taglist_shape = shapes.circle
theme.taglist_shape_focus = shapes.rounded_bar

--- wallpaper ---
theme.wallpaper = "~/.config/wall.jpg"

function theme.at_screen_connect(s)
    local space = wibox.widget.textbox("   ") -- spacing widget
    local sep = wibox.widget.textbox("<span color='" .. beautiful.fg .. "'> | </span>") -- separator widget
    sep.font = beautiful.font .. " Bold 14"

    local date = wibox.widget({
        widget = wibox.widget.textclock,
        format = "<span color='" .. beautiful.lgreen .. "'>%B %d, %Y</span>",
        align = "center",
        valign = "center",
        font = beautiful.font .. " Bold 14"
    })
    local time = wibox.widget({
        widget = wibox.widget.textclock,
        format = "<span color='" .. beautiful.lgreen .. "'>%I:%M %P</span>",
        align = "center",
        valign = "center",
        font = beautiful.font .. " Bold 14"
    })

    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    s.taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = -12
        },
        widget_template = {
            widget = wibox.container.margin,
            forced_width = dpi(25),
            forced_height = dpi(20),
            create_callback = function(self, c3, _)
                local indicator = wibox.widget({
                    widget = wibox.container.place,
                    valign = "center",
                    {
                        widget = wibox.container.background,
                        forced_height = dpi(10),
                        shape = gears.shape.rounded_bar,
                    },
                })

                self.indicator_animation = animation:new({
                    duration = 0.125,
                    easing = animation.easing.linear,
                    update = function(self, pos)
                        indicator.children[1].forced_width = pos
                    end,
                })

                self:set_widget(indicator)

                if c3.selected then
                    self.widget.children[1].bg = beautiful.lgreen
                    self.indicator_animation:set(dpi(35))
                elseif #c3:clients() == 0 then
                    self.widget.children[1].bg = beautiful.disabled
                    self.indicator_animation:set(dpi(10))
                else
                    self.widget.children[1].bg = beautiful.disabled
                    self.indicator_animation:set(dpi(18))
                end
            end,
            update_callback = function(self, c3, _)
                if c3.selected then
                    self.widget.children[1].bg = beautiful.lgreen
                    self.indicator_animation:set(dpi(35))
                elseif #c3:clients() == 0 then
                    self.widget.children[1].bg = beautiful.disabled
                    self.indicator_animation:set(dpi(10))
                else
                    self.widget.children[1].bg = beautiful.disabled
                    self.indicator_animation:set(dpi(18))
                end
            end
        },
        buttons = taglist_buttons,
    })

    s.wibar = awful.wibar({
        stretch = true,
        position = "top",
        height = 35,
        screen = s,
        shape = gears.shape.rounded_bar,
        margins = {
            top = 14,
            left = 14,
            right = 14,
            bottom = 0
        }
    })

    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            space,
            date,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            s.taglist,
        },
        {
            layout = wibox.layout.fixed.horizontal,
--            volume_widget,
            space,
            time,
            space,
        }
    }
end

return theme
