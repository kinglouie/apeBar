#!/usr/bin/env sh

exit_no_battery() {
    echo "battstat: no battery found"
    exit 1
}

battery_details=$(pmset -g batt)

# Exit if no battery exists.
if ! echo "$battery_details" | grep -q InternalBattery; then
    exit_no_battery
fi

#charged=$(echo "$battery_details" | grep -w 'charged')
#charging=$(echo "$battery_details" | grep -w 'AC Power')
discharging=$(echo "$battery_details" | grep -w 'Battery Power')
if [ -z "$discharging" ]; then
    discharging=0
else
    discharging=1
fi
#time=$(echo "$battery_details" | grep -Eo '([0-9][0-9]|[0-9]):[0-5][0-9]')
percent=$(echo "$battery_details" | grep -o "[0-9]*"%)

echo "$discharging:$percent"
