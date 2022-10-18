conky.config = {
    alignment = 'top_left',
    double_buffer = true,
    draw_borders = false,
    -- draw_borders = true,
    draw_graph_borders = false,
    gap_x = 1500,
    gap_y = 50,
    minimum_width = 400,
    maximum_width = 1400,
    minimum_height = 1000,
    own_window = true,
    own_window_hints = 'undecorated,below,sticky',
    draw_shades = false,
    own_window_transparent = true,
    own_window_argb_visual = true,
    own_window_argb_value = 0,
    border_inner_margin = 0,
    border_outer_margin = 1,
    update_interval = 1.0,
    use_xft = true,
    -- font = 'size=8',
    uppercase = false,

    ----------------------------------------------------------------- LUA LOAD
    lua_load = './../scripts/main.lua',
    lua_draw_hook_pre = 'conky_main',

    ----------------------------------------------------------------- COLORS
    default_color = 'ffffff',  -- White
    color1 = '#808080',        -- Grey
    color2 = '#c4c4c4',        -- Light Grey
    color3 = '#333333',        -- Dark Grey
    color4 = '#2e935d',        -- Green
    color5 = '#5ac0ff',        -- Blue
    color6 = '#215924',        -- DarkGreen
    color7 = '#FF6600'         -- Orange

}

img_vpn_x = 179
img_vpn_y = 826

conky.text = [[
#-----------------------------#
#- HOURS : MINUTES : SECONDS -#
#-----------------------------#
#
${voffset 120}
${goto 110}${font :size=40}${time %k:%M}${font :size=26}:${time %S}
#
#---------------------------#
#- WEEK DAY - MONTH - YEAR -#
#---------------------------#
#
${voffset -70}
${color4}${goto 110}${font :size=42}${time %d}$color2}${font :size=16}${time %A}
${color5}${goto 150}${font :size=12}${time %B}${color1} ${time %Y}$font
#
#-------#
#- CPU -#
#-------#
#
${voffset 210}
${color2}${goto 177}${font :size=6}${freq_g 1}${voffset 4}
${color2}${goto 177}${font :size=6}${freq_g 2}${voffset 4}
${color2}${goto 177}${font :size=6}${freq_g 3}${voffset 4}
${color2}${goto 177}${font :size=6}${freq_g 4}$font

${voffset -48}
${goto 185}${color7}CPU
#
#----------#
#- MEMORY -#
#----------#
#
${font :size=6}${color}
${voffset 153}${goto 220}${mem}
#
#------------------#
#- VPN - ON / OFF -#
#------------------#
#
${if_match  "${execi 3  nmcli -g GENERAL.STATE connection show Wired\ connection\ 1}" != "activated"}
  ${image ./../img/x-icon.001.64x64.png -p ]] .. img_vpn_x .. [[, ]] .. img_vpn_y .. [[ -s 40x40}
$else  
  ${if_up tun0}
    ${image ./../img/vpn_ON.png -p ]] .. img_vpn_x .. [[, ]] .. img_vpn_y .. [[ -s 40x40}
  $else 
    ${image ./../img/vpn_OFF.png -p ]] .. img_vpn_x .. [[, ]] .. img_vpn_y .. [[ -s 40x40}
  ${endif} 
${endif}
]]
