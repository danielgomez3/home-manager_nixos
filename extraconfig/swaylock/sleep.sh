#!/bin/sh

# gtemp=$(brightnessctl g)
swayidle -w \
	timeout 60 'temp=$(brightnessctl g); brightnessctl set $((temp / 2))' \
	resume 'temp=$(brightnessctl g); brightnessctl set $((temp * 2))' \
	resume ''
# timeout 15 "hyprctl dispatch dpms off" \
# resume 'hyprctl dispatch dpms on'