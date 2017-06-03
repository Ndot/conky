conky.config = {
    alignment = 'top_left',
    double_buffer = true,
    draw_borders = true,
    draw_borders = false,
    draw_graph_borders = false,
    gap_x = 20,
    gap_y = 20,
    maximum_width = 1920,
    minimum_width = 1890,
    minimum_height = 80,
    own_window = true,
    own_window_hints = 'undecorated,below,sticky',
    own_window_transparent = true,
    own_window_argb_visual = true,
    own_window_argb_value = 0,
    border_inner_margin = 0,
    border_outer_margin = 0,
    update_interval = 1.0,
    use_xft = true,
    font = 'SourceCodePro-Medium:size=8',
    uppercase = true,

    ----------------------------------------------------------------- COLORS
    default_color = 'ffffff',   -- White
    color1 = '#7a7a7a',         -- Grey
    color2 = '#444444',         -- Dark Grey
}

conky.text = [[
#
#----------------------------------------------------------------------- EXEC CALENDAR
#
${font courier:size=12}${alignr}${execpi 300 ./../scripts/horizontal_calendar.sh}$font
#
#----------------------------------------------------------------------- HR - HORIZONTAL LINE
#
${voffset -15}
${goto 300}${color2}${hr 2}
#
#----------------------------------------------------------------------- DIFFERENT TIME ZONES
#----------------------------------------------------------------------- For the variable "tztime" look in /usr/share/zoneinfo
#
${voffset -10}
${goto 540}${color1}San Francisco $color${tztime Etc/GMT+7 %H:%M}       \
${color1}Toronto $color${tztime Canada/Eastern %H:%M}       \
${color1}London $color${tztime Europe/London %H:%M}       \
${color1}Amsterdam $color${tztime Europe/Amsterdam %H:%M}       \
${color1}Hongkong $color${tztime Hongkong %H:%M}       \
${color1}Tokyo $color${tztime Japan %H:%M}       \
${color1}Sydney $color${tztime Australia/Sydney %H:%M}
]]
