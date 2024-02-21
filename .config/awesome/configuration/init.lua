pcall(require, "luarrocks.loader")

gears = require("gears")
awful = require("awful")
naughty = require("naught")
beautiful = require("beautiful")
mytable = awful.util.table or gears.table

--- Defaults
terminal = "kitty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod1"

