require 'cairo'
require 'lua_settings'

---
-- Convert #ffffff colors to rgba(1,1,1,1).
-- Lua colors work from 0 to 1 instead of 0 to 255.
--
-- @param {number} color - Color
-- @param {number} alpha - Alpha
--
function rgb_to_r_g_b(color)
    if color == nil then return end -- In case range_value has more values then range_color has colors (color will be nil and throw an error)
    local c = color[1]:gsub('#', '0x')
    return ((c / 0x10000) % 0x100) / 255., ((c / 0x100) % 0x100) / 255., (c % 0x100) / 255., color[2]
end

---
-- Draw ring - I just draw RINGS!!!!
-- And I do -90 just for you...
--
-- @param {} cr                 - Surface to draw. (cr = cairo_create(cs) -> this creates the surface to draw).
-- @param {Object} obj          - Object with the settings of the ring.
-- @param {array} color         - An array with color and alpha (eg: { '#bbaa88', 0.4 })
-- @param {number} center_x     - Center of the X position of the ring.
-- @param {number} center_y     - Center of the Y position of the ring.
-- @param {number} radius       - Radius of the ring.
-- @param {number} start_angle  - Starting angle of the ring.
-- @param {number} end_angle    - Ending angle of the ring.
-- 
function draw_ring(cr, obj, color, center_x, center_y, radius, start_angle, end_angle)
    -- Rotate angle by -90 deg
    start_angle = start_angle - math.pi / 2
    end_angle = end_angle - math.pi / 2
    
    cairo_arc(cr, center_x, center_y, radius, start_angle, end_angle)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(color))
    cairo_set_line_width(cr, obj['thickness'])
    cairo_set_line_cap(cr, obj['line_cap'])
    cairo_stroke(cr)
end

--- 
-- Setup draw the rings
--
-- @param {} cr                     - Surface to draw. (cr = cairo_create(cs) -> this creates the surface to draw).
-- @param {number} indicator_value  - The returning value (from conky) to apply on indicator part of the ring (eg: 53% = 0.53).
-- @param {Object} obj              - One object with the settings of the ring.
--
function setup_draw_ring(cr, indicator_value, obj)
    
    -- Convert radians to degrees
    local start_angle   = obj['start_angle'] * (2 * math.pi / 360)
    local end_angle     = obj['end_angle'] * (2 * math.pi / 360)
    local indicator     = indicator_value * (end_angle - start_angle)
    
    -- To change indicator color depending on the range value
    if obj['range_value'] ~= nil then
        local i, indicator = 1, indicator_value * obj['max']
        
        while i <= table.getn(obj['range_value']) do
            if indicator >= obj['range_value'][i] and indicator < obj['max'] then
                obj['fg_color'] = obj['range_color'][i]
            end
            i = i + 1
        end
    end
    
    -- For the rings that are divided into sections
    if obj['gap_percent'] > 0 then
        local i = 1
        local unit = ((end_angle - start_angle) / obj['max'])               -- To get one unit value
        local start_section = start_angle                                   -- The first value is the same as start_angle
        local end_section = start_section + unit * (1 - obj['gap_percent']) -- The start_section plus one unit minus the gap percentage
        local indicator = indicator_value * obj['max']                      -- To get a value from 0 to 100 instead of 0 to 1
        
        while i <= obj['max'] do
            -- Draw each one of the sections for the background
            draw_ring(cr, obj, obj['bg_color'], obj['x'], obj['y'], obj['radius'], start_section, end_section)
            
            if i <= indicator then
                -- Draw each one of the sections for the indicator
                draw_ring(cr, obj, obj['fg_color'], obj['x'], obj['y'], obj['radius'], start_section, end_section)
            end
            start_section = start_section + unit    -- Increase the start by one unit/section
            end_section   = end_section + unit      -- Increase the end by one unit/section
            i = i + 1                               -- Increase i by one for the next iteration
        end
        return
    end
    
    -- Draw background ring AND indicator ring
    draw_ring(cr, obj, obj['bg_color'], obj['x'], obj['y'], obj['radius'], start_angle, end_angle)
    draw_ring(cr, obj, obj['fg_color'], obj['x'], obj['y'], obj['radius'], start_angle, start_angle + indicator)
end

---
-- Draw line - I just draw LINES!!!!
--
-- @param {} cr                     - Surface to draw. (cr = cairo_create(cs) -> this creates the surface to draw).
-- @param {array} s                 - X and Y start position.
-- @param {array} e                 - X and Y end position.
-- @param {Object} obj              - Object with the settings for the line.
-- @param {number} line_thickness   - Thickness of the line.
-- 
function draw_line(cr, s, e, obj, line_thickness)
    cairo_set_line_width(cr, line_thickness)
    cairo_set_line_cap(cr, obj['line_cap'])
    cairo_set_source_rgba(cr, rgb_to_r_g_b(obj['color']))
    cairo_move_to(cr, s[1], s[2])
    cairo_line_to(cr, e[1], e[2])
    cairo_stroke(cr)
end

---
-- Setup the clock hands.
--
-- @param {} cr         - Surface to draw. (cr = cairo_create(cs) -> this creates the surface to draw).
-- @param {Object} obj  - One object with the settings for the line.
--
function setup_clock_hands(cr, obj)
    local secs, mins, hours, secs_arc, mins_arc, hours_arc, x_start, x_end, y_start, y_end
    
    secs  = os.date("%S")    
    mins  = os.date("%M")
    hours = os.date("%I")
    
    secs_arc  = (2 * math.pi / 60) * secs
    mins_arc  = (2 * math.pi / 60) * mins + secs_arc / 60
    hours_arc = (2 * math.pi / 12) * hours + mins_arc / 12
    
    -- Draw hours hand
    x_start = obj['x'] + obj['hours_offset'] * math.sin(hours_arc)
    y_start = obj['y'] - obj['hours_offset'] * math.cos(hours_arc)
    x_end   = obj['x'] + obj['hours_width'] * math.sin(hours_arc)
    y_end   = obj['y'] - obj['hours_width'] * math.cos(hours_arc)
    
    draw_line(cr, {x_start, y_start}, {x_end, y_end}, obj, obj['hours_thickness'])
    
    -- Draw minutes hand
    x_start = obj['x'] + obj['minutes_offset'] * math.sin(mins_arc)
    y_start = obj['y'] - obj['minutes_offset'] * math.cos(mins_arc)
    x_end   = obj['x'] + obj['minutes_width'] * math.sin(mins_arc)
    y_end   = obj['y'] - obj['minutes_width'] * math.cos(mins_arc)
    
    draw_line(cr, {x_start, y_start}, {x_end, y_end}, obj, obj['minutes_thickness'])
    
    -- Draw seconds hand
    if obj['show_seconds'] then
        x_start = obj['x'] + obj['seconds_offset'] * math.sin(secs_arc)
        y_start = obj['y'] - obj['seconds_offset'] * math.cos(secs_arc)
        x_end   = obj['x'] + obj['seconds_width'] * math.sin(secs_arc)
        y_end   = obj['y'] - obj['seconds_width'] * math.cos(secs_arc)
        
        draw_line(cr, {x_start, y_start}, {x_end, y_end}, obj, obj['seconds_thickness'])
    end
end

---
-- Gets the conky values and calls setup_draw_ring with the obj and the conky value for the indicator.
--
-- @param {} cr         - Surface to draw. (cr = cairo_create(cs) -> this creates the surface to draw).
-- @param {Object} obj  - Object from the rings table above.
--
function setup_rings(cr, obj)
    if obj['name'] == '' then setup_draw_ring(cr, 0, obj); return end -- For decorative rings
    
    local value   = tonumber(conky_parse(string.format('${%s %s}', obj['name'], obj['arg'])))
    
    -- The first time 'conky_parse' is called for each 'exec' command the return value is nill.
    -- The bellow if statement avoids the script to exit on each of those calls.
    -- This avoids conky to draw the rings in steps.
    if value == nil then value = 0 end
    
    local val_dec = value / obj['max']
    
    setup_draw_ring(cr, val_dec, obj)
end

---
-- Main function this is the function called by conky.
-- To call the function in conky: "lua_draw_hook_pre = 'conky_main'"
--
function conky_main()
    if conky_window == nil then return end
    
    local cs = cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    local cr = cairo_create(cs)    
    
    --[[
        IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault
        if it tries to draw a ring straight away. This if statement uses a delay to make 
        sure that this doesn't happen. Generally, a value of 5s is long enough, so if you
        update Conky every 1s, use update_num > 5.
    ]]
    local update_num = tonumber(conky_parse('${updates}'))

    if update_num > 5 then
        for i in pairs(rings) do
            setup_rings(cr, rings[i])
        end
    end
    
    setup_clock_hands(cr, clock_hands)
 
    -- These lines do some clean up.
    -- One thing that lua can do is to eat up memory over time.
    -- These lines help to avoid that.
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
