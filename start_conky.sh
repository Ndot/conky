#!/bin/bash

# Mind the relative path on the conky command.
# If you add this to your StartUp scripts make sure you add it as
# symlink or change the commands path to an absolute path.

sleep 5 &&
conky -c ./conky_calendar.lua &

sleep 5 &&
conky -c ./conky_main.lua &