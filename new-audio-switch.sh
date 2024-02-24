#!/bin/bash

# Get the active sink name and the list of all sink names
active_sink_name=$(pactl info | grep "Default Sink" | awk -F': ' '{print $2}')
all_sink_names=$(pactl list short sinks | awk '{print $2}')

# Convert sink names to an array
sink_names=($all_sink_names)

# Find the index of the active sink name
for i in "${!sink_names[@]}"; do
    if [ "${sink_names[$i]}" = "$active_sink_name" ]; then
        active_index=$i
        break
    fi
done

# Calculate the next sink index in a circular fashion
next_index=$(( (active_index + 1) % ${#sink_names[@]} ))
next_sink_name=${sink_names[$next_index]}

# Change the default sink and move all audio streams to the new sink
pactl set-default-sink $next_sink_name
pactl list short sink-inputs | awk '{print $1}' | xargs -r -I {} pactl move-sink-input {} $next_sink_name

# Notify the user
#notify-send "Audio Switcher" "Switched to sink: $next_sink_name"

# Print info
echo "Switched to sink: $next_sink_name"t