#!/bin/bash

prev="none"
music_dir="/home/${USER}/music"
destination="~/.config/rofi/images/mpdbg.png"

while : ; do
    mpc idle player
    current=$( mpc current )
    if [[ $prev != $current ]]; then
        prev=$current
        filename=$( mpc -f "%file%" current )
        filepath="${music_dir}/${filename}"
        ffmpeg -i "${filepath}" -map 0:v -map -0:V -c copy -y ~/.config/rofi/images/mpdbg.png
        magick ~/.config/rofi/images/mpdbg.png -gravity center -crop 750x625+0+0 +repage ~/.config/rofi/images/mpdbg.png
    fi
done
