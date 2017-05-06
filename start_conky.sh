#!/bin/bash

# Mind the relative path on the conky command.

conky -c ./conky_calendar.lua &
conky -c ./conky_main.lua &
