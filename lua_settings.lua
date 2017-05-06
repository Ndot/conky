-- Center of the clock.
clock_x = 200
clock_y = 200
-- Center of the first system info.
sys01_x = 200
sys01_y = 610
-- Center of the second system info.
sys02_x = 200
sys02_y = 850

rings = {
    ----------------------------------------------------------------- 
    ------------------------------------------------------ CLOCK RING
    
    ------------------ Hours --------------------
    {
        name        = 'time',
        arg         = '%I',
        max         = 12,
        bg_color    = { '#555555', 0.3 },
        fg_color    = { '#f5ff00', 0.3 },
        x           = clock_x,
        y           = clock_y,
        radius      = 135,
        thickness   = 10,
        start_angle = 30,
        end_angle   = 390,
        gap_percent = 0.1,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    ----------------- Minutes -------------------
    {
        name        = 'time',
        arg         = '%M.%S',
        max         = 60,
        bg_color    = { '#555555', 0.3 },
        fg_color    = { '#f5ff00', 0.3 },
        x           = clock_x,
        y           = clock_y,
        radius      = 150,
        thickness   = 10,
        start_angle = 0,
        end_angle   = 360,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    ----------------- Seconds -------------------
    {
        name        = 'time',
        arg         = '%S',
        max         = 60,
        bg_color    = { '#000000', 0 },
        fg_color    = { '#ffffff', 0.5 },
        x           = clock_x,
        y           = clock_y,
        radius      = 150,
        thickness   = 5,
        start_angle = 0,
        end_angle   = 360,
        gap_percent = 0.9,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    ------------------- Days --------------------
    {
        name        = 'time',
        arg         = '%d',
        max         = 31,
        bg_color    = { '#555555', 0.3 },
        fg_color    = { '#2e935d', 0.8 },
        x           = clock_x,
        y           = clock_y,
        radius      = 180,
        thickness   = 17,
        start_angle = 50,
        end_angle   = 280,
        gap_percent = 0.98,
        line_cap    = CAIRO_LINE_CAP_ROUND
    },
    ------------------ Months -------------------
    {
        name        = 'time',
        arg         = '%m',
        max         = 12,
        bg_color    = { '#555555', 0.3 },
        fg_color    = { '#00c4ff', 0.8 },
        x           = clock_x,
        y           = clock_y,
        radius      = 180,
        thickness   = 17,
        start_angle = -70,
        end_angle   = 40,
        gap_percent = 0.98,
        line_cap    = CAIRO_LINE_CAP_ROUND
    },
    -----------------------------------------------------------------
    ------------------------------------------------------------- CPU
    {
        name        = 'cpu',
        arg         = 'cpu1',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        fg_color    = { '#00c4ff', 0.8 },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 30,
        thickness   = 10,
        start_angle = 0,
        end_angle   = 270,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'cpu',
        arg         = 'cpu2',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        fg_color    = { '#00c4ff', 0.8 },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 45,
        thickness   = 10,
        start_angle = 0,
        end_angle   = 270,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'cpu',
        arg         = 'cpu3',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        fg_color    = { '#00c4ff', 0.8 },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 60,
        thickness   = 10,
        start_angle = 0,
        end_angle   = 270,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'cpu',
        arg         = 'cpu4',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        fg_color    = { '#00c4ff', 0.8 },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 75,
        thickness   = 10,
        start_angle = 0,
        end_angle   = 270,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    -----------------------------------------------------------------
    ------------------------------------------------ CPU TEMPERATURES
    {
        name        = 'exec',
        arg         = 'sensors | awk \'/Core 0/ {print 1*$3}\'',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = nil,
        range_value = { 0, 55, 60 },
        range_color = { { '#a7ac2a', 0.5 }, { '#ff8000', 0.5 }, { '#ff0000', 0.5 } },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 133,
        thickness   = 20,
        start_angle = 0,
        end_angle   = 45,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'exec',
        arg         = 'sensors | awk \'/Core 1/ {print 1*$3}\'',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = nil,
        range_value = { 0, 55, 60 },
        range_color = { { '#a7ac2a', 0.5 }, { '#ff8000', 0.5 }, { '#ff0000', 0.5 } },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 133,
        thickness   = 20,
        start_angle = 45,
        end_angle   = 90,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'exec',
        arg         = 'sensors | awk \'/Core 2/ {print 1*$3}\'',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = nil,
        range_value = { 0, 55, 60 },
        range_color = { { '#a7ac2a', 0.5 }, { '#ff8000', 0.5 }, { '#ff0000', 0.5 } },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 133,
        thickness   = 20,
        start_angle = 90,
        end_angle   = 135,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    {
        name        = 'exec',
        arg         = 'sensors | awk \'/Core 3/ {print 1*$3}\'',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = nil,
        range_value = { 0, 55, 60 },
        range_color = { { '#a7ac2a', 0.5 }, { '#ff8000', 0.5 }, { '#ff0000', 0.5 } },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 133,
        thickness   = 20,
        start_angle = 135,
        end_angle   = 180,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    -----------------------------------------------------------------
    ---------------------------------------------------------- MEMORY
    {
        name        = 'memperc',
        arg         = '',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = { '#04f44e', 0.2 },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 50,
        thickness   = 20,
        start_angle = 290,
        end_angle   = 360,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_ROUND
    },
    -----------------------------------------------------------------
    ------------------------------------------------------------ DISK
    {
        name        = 'fs_used_perc',
        arg         = '/media/MAIN/',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = { '#f40d0d', 0.2 },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 50,
        thickness   = 20,
        start_angle = 90,
        end_angle   = 160,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_ROUND
    },
    {
        name        = 'fs_used_perc',
        arg         = '',
        max         = 100,
        bg_color    = { '#555555', 0.2 },
        fg_color    = { '#ff8000', 0.2 },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 50,
        thickness   = 20,
        start_angle = 190,
        end_angle   = 260,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_ROUND
    },
    -----------------------------------------------------------------
    ---------------------------------------------------------- NVIDIA 
    
    ----------------  Temperatures ---------------
    {
        name        = 'exec',
        arg         = 'nvidia-smi -q -d TEMPERATURE | awk \'/GPU Current Temp/ {print $5}\'',
        max         = 100,
        bg_color    = { '#555555', 0.4 },
        fg_color    = nil,
        range_value = { 0, 50, 70 },
        range_color = { { '#a7ac2a', 0.7 }, { '#ff8000', 0.7 }, { '#ff0000', 0.7 } },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 90,
        thickness   = 10,
        start_angle = 180,
        end_angle   = 360,
        gap_percent = 0.5,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    ----------------- Fan Speed -----------------
    {
        name        = 'exec',
        arg         = 'nvidia-smi -q  | awk \'/Fan Speed/ {print $4}\'',
        max         = 100,
        bg_color    = { '#555555', 0.5 },
        fg_color    = { '#04f44e', 0.9 },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 110,
        thickness   = 5,
        start_angle = 120,
        end_angle   = 320,
        gap_percent = 0.5,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    -----------------------------------------------------------------
    ------------------------------------------------ DECORATION RINGS
    
    ----------------- CPU Ring ------------------
    {
        name        = '',
        arg         = '',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        x           = sys01_x,
        y           = sys01_y,
        radius      = 120,
        thickness   = 6,
        start_angle = -30,
        end_angle   = 180,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    },
    ---------------- Other Ring -----------------
    {
        name        = '',
        arg         = '',
        max         = 100,
        bg_color    = { '#a2a2a2', 0.2 },
        x           = sys02_x,
        y           = sys02_y,
        radius      = 100,
        thickness   = 6,
        start_angle = 150,
        end_angle   = 360,
        gap_percent = 0,
        line_cap    = CAIRO_LINE_CAP_BUTT
    }
}

clock_hands = {
    -----------------------------------------------------------------
    ----------------------------------------------------- CLOCK HANDS
    -- Center of the clock hands.
    x                   = clock_x,
    y                   = clock_y,
    -- Clock pointers extent.
    hours_width         = 140,
    minutes_width       = 165,
    seconds_width       = 180,
    -- Clock pointers offset from center.
    hours_offset        = 128,
    minutes_offset      = 128,
    seconds_offset      = 128,
    -- Line thickness.
    hours_thickness     = 10,
    minutes_thickness   = 5,
    seconds_thickness   = 2,
    -- Show seconds TRUE / FALSE
    show_seconds        = true,
    color               = { '#564037', 1 },
    line_cap            = CAIRO_LINE_CAP_BUTT
}