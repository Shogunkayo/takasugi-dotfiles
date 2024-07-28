#!/bin/bash

printf "\n1. Download video\n2. Download audio only\n"
read x

printf "\n1. Download single video\n2. Download full playlist\n"
read choice

printf "\nEnter url\n"
read url

if [[ "$x" == '1' ]]; then
    if [[ "$choice" == '1' ]]; then
        yt-dlp --download-archive ~/video/archive.txt --no-playlist --embed-thumbnail -o '~/video/general/%(title)s.%(ext)s' $url
    else
        yt-dlp --download-archive ~/video/archive.txt --embed-thumbnail -o '~/video/general/%(title)s.%(ext)s' $url
    fi
else
    if [[ "$choice" == '1' ]]; then
        yt-dlp --download-archive ~/music/archive.txt --no-playlist --extract-audio --audio-format mp3 --embed-thumbnail -o '~/music/general/%(title)s.%(ext)s' $url
    else
        yt-dlp --download-archive ~/music/archive.txt --extract-audio --audio-format mp3 --embed-thumbnail -o '~/music/%(playlist_title)s/%(title)s.%(ext)s' $url
    fi
fi
