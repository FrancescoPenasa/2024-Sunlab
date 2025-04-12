--[[
    Starting State of our game, simply display the title and first menu to start game
]]

MainIntroState = Class{__includes = BaseState}

local optionSelected = 0
local n_options = 2
local padding = 10

function MainIntroState:enter(params)
    print('StartState:enter')
    
    titleFont = love.graphics.newFont('fonts/font.ttf', 128)
    subtitleFont = love.graphics.newFont('fonts/font.ttf', 32)
end

function MainIntroState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        optionSelected = (optionSelected + 1) % n_options
        gSounds['main_optionchange']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['main_optionselected']:play()

        if optionSelected == 0 then
            print(' todo')
            gStateMachine:change('main_menu', {})
        else
            print('nothings here')
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function MainIntroState:render()

    -- title
    love.graphics.setFont(titleFont)
    local titleText = "SUNLAB\n50"
    local textWidth = titleFont:getWidth(titleText)
    local textHeight = titleFont:getHeight() * 2 -- accounting for two lines
    love.graphics.printf(titleText, (VIRTUAL_WIDTH - textWidth) / 2, (VIRTUAL_HEIGHT - textHeight) / 2, textWidth, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
 
    -- instructions
    if optionSelected == 0 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.setFont(subtitleFont)
    local subtitleText = "press enter to start"
    local subtitleWidth = subtitleFont:getWidth(subtitleText)
    local subtitleHeight = subtitleFont:getHeight()
    love.graphics.printf(subtitleText, (VIRTUAL_WIDTH - subtitleWidth) / 2, (VIRTUAL_HEIGHT - textHeight) / 2 + textHeight + 20, subtitleWidth, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if optionSelected == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.setFont(subtitleFont)
    local subtitleText = "other option"
    local subtitleWidth = subtitleFont:getWidth(subtitleText)
    local subtitleHeight = subtitleFont:getHeight()
    love.graphics.printf(subtitleText, (VIRTUAL_WIDTH - subtitleWidth) / 2, (VIRTUAL_HEIGHT - textHeight) / 2 + textHeight + subtitleHeight + 40, subtitleWidth, 'center')



end