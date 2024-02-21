require("configuration.init")

awful.spawn("picom --animations -b")
awful.spawn("sh ~/.screenlayout/default.sh")
