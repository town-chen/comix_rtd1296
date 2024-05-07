#!/bin/bash

FAN_GPIO=123
TEMP_THRESHOLD=50000
FAN_STATUS=0

TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)

if [ $TEMP -gt $TEMP_THRESHOLD ]; then
    if [ $FAN_STATUS -eq 0 ]; then
        echo 123 > /sys/class/gpio/export
        echo out > /sys/class/gpio/gpio123/direction
        echo 1 > /sys/class/gpio/gpio123/value
    fi
else
    if [ $FAN_STATUS -eq 1 ]; then
        echo 0 > /sys/class/gpio/gpio123/value
    fi
fi