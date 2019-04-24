#!/bin/bash

#Script to directly write Backlight in an old computer where xbacklight does not work
#Possible Parameter: inc, dec
#Second Parameter: steps number
#Example: change_backlight inc 2

if [ "$1" == "" ]; then
    exit 1
fi

steps=$([ "$2" == "" ] && echo "1" || echo "$2")
actual_bright_value="$(cat /sys/class/backlight/acpi_video0/brightness)"
max_brightness="$(cat /sys/class/backlight/acpi_video0/max_brightness)"

if   [ "$1" == "dec" ]; then
    new_value="$((actual_bright_value-$steps))"
    if   [ "$new_value" -lt "0" ]; then
    	new_value=0
    fi
elif [ "$1" = "inc" ]; then
	new_value="$((actual_bright_value+$steps))"
	if   [ "$new_value" -gt "$max_brightness" ]; then
    	new_value="$max_brightness"
    fi
else
	exit 1
fi

echo $new_value
echo $new_value > /sys/class/backlight/acpi_video0/brightness



