require 'src/Dependencies'

-- Virtual resolution

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('SUNLAB 50')

    math.randomseed(os.time())

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }
    love.graphics.setFont(gFonts['small'])

    -- Set up push for virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    gSounds = {
        ['main_optionchange'] = love.audio.newSource('sounds/main_optionchange.wav', 'static'),
        ['main_optionselected'] = love.audio.newSource('sounds/main_optionselected.wav', 'static')
        -- ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }

    -- states
    gStateMachine = StateMachine {
        ['main_intro'] = function() return MainIntroState() end,
        ['main_menu'] = function() return MainMenuState() end,
        ['game1_menu'] = function() return Game1MenuState() end,
    }
    gStateMachine:change('main_intro', {
        -- highScores = loadHighScores()
    })

    -- play our music outside of all states and set it to looping
    -- gSounds['music']:play()
    -- gSounds['music']:setLooping(true)

    -- DEBUGGG ------------------
    -- gStateMachine:change('main_menu', {})
    
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)
    
    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    -- Start push rendering
    push:apply('start')

    gStateMachine:render()

    -- End push rendering
    push:apply('end')
end

--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    -- love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
