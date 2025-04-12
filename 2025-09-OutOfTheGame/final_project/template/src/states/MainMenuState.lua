-- MainMenuState.lua
-- State for the main menu of the game
MainMenuState = Class {
    __includes = BaseState
}

local gameList = {{
    name = "Game 1",
    state = "game1_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 2",
    state = "game2_menu"
}, {
    name = "Game 3",
    state = "game3_menu"
}}
local n_rows = 3
local n_cols = 5

local horizontalPadding = 80
local padding = 0

local optionSelected = 0
local showDetail = false
local dySelected = 0
local animationSelected = 1
local dySelectedLimit = 5

function MainMenuState:init()
    -- Initialize any variables or objects for the main menu
end

function MainMenuState:enter(params)
    -- Called when entering this state, with optional parameters
    titleFont = love.graphics.newFont('fonts/font.ttf', 128)
end

function HandleEnter()
    if showDetail then
        -- Transition to the selected game's state
        gStateMachine:change(gameList[optionSelected].state)
    else
        -- Show game details or other information
        showDetail = true
    end
end

function MainMenuState:update(dt)
    -- change selected option based on input
    if love.keyboard.wasPressed('left') then
        optionSelected = optionSelected - 1
    elseif love.keyboard.wasPressed('right') then
        optionSelected = optionSelected + 1
    elseif love.keyboard.wasPressed('up') then
        optionSelected = optionSelected - n_cols
    elseif love.keyboard.wasPressed('down') then
        optionSelected = optionSelected + n_cols
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        HandleEnter()
    end
    optionSelected = optionSelected % #gameList

    --  selected animation
    dySelected = dySelected + animationSelected * dt * 10
    if dySelected >= dySelectedLimit then
        animationSelected = -1
    elseif dySelected <= 0 then
        animationSelected = 1
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        if showDetail then
            showDetail = false
        else
            love.event.quit()
        end
    end
end

function MainMenuState:render()
    -- clear the screen
    love.graphics.clear(0.1, 0.1, 0.1, 1) -- Dark gray background
    -- Draw the main menu
    love.graphics.printf("Press Enter to Start" .. optionSelected, 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')

    -- Draw the game grid
    displayCorner()
    displayGrid()
    if showDetail then
        displayDetail()
    end
end

function displayDetail()
    local detailX = (VIRTUAL_WIDTH / n_cols) * ((optionSelected) % n_cols) + horizontalPadding / 2
    local detailY = 20 + math.floor((optionSelected) / n_cols) * 200 - dySelected
    local detailHeight = 250
    local detailWidth = 250	
    -- todo use this vars instead of doing stupid stuff
    
    -- draw background
    love.graphics.setColor(0, 0, 0, 1) -- Black color for the detail window
    love.graphics.rectangle(
        'fill',
        math.min( (VIRTUAL_WIDTH / n_cols) * ((optionSelected) % n_cols) + horizontalPadding / 2, VIRTUAL_WIDTH- detailWindowWidth - padding), -- x position todo use max or min
        math.min(20 + math.floor((optionSelected) / n_cols) * 200 , VIRTUAL_HEIGHT-detailWindowHeight - padding), -- y position
         detailWindowWidth, -- width
        detailWindowHeight-- height
    )

    -- disegna contorno
    love.graphics.setLineWidth( 5)
    love.graphics.setColor(1, 1, 1, 1) -- Default color
    love.graphics.rectangle(
        'line',
        math.min( (VIRTUAL_WIDTH / n_cols) * ((optionSelected) % n_cols) + horizontalPadding / 2, VIRTUAL_WIDTH- detailWindowWidth - padding), -- x position todo use max or min
        math.min(20 + math.floor((optionSelected) / n_cols) * 200 , VIRTUAL_HEIGHT-detailWindowHeight - padding), -- y position
         detailWindowWidth, -- width
        detailWindowHeight-- height
    )

    -- dettagli gioco
    love.graphics.printf(gameList[optionSelected + 1].name, (VIRTUAL_WIDTH - titleFont:getWidth(gameList[optionSelected + 1].name)) / 2, VIRTUAL_HEIGHT / 2 - titleFont:getHeight() / 2, VIRTUAL_WIDTH, 'center')
end

function displayGrid()
    -- print games
    for i, game in ipairs(gameList) do
        if i == optionSelected + 1 then
            love.graphics.setColor(1, 0, 1, 1) -- Highlight selected option
            love.graphics.rectangle(
                'fill', -- line
                (VIRTUAL_WIDTH / n_cols) * ((i - 1) % n_cols) + horizontalPadding / 2, -- x position
                20 + math.floor((i - 1) / n_cols) * 200 - dySelected, -- y position
                VIRTUAL_WIDTH / n_cols - horizontalPadding, -- width
                VIRTUAL_HEIGHT / n_rows - padding - 100 -- height
            )
        else
            love.graphics.setColor(1, 1, 1, 1) -- Default color
            love.graphics.rectangle(
                'fill', -- line
                (VIRTUAL_WIDTH / n_cols) * ((i - 1) % n_cols) + horizontalPadding/ 2, -- x position
                20 + math.floor((i - 1) / n_cols) * 200, -- y position
                VIRTUAL_WIDTH / n_cols - horizontalPadding, -- width
                VIRTUAL_HEIGHT / n_rows - padding - 100 -- height
            )
        end
    end
end

function displayCorner()
    local corner = 5
    -- print games
    for i, game in ipairs(gameList) do
        if i == optionSelected + 1 then
            love.graphics.setColor(1, 0, 0, 1) -- Highlight selected option

            love.graphics.rectangle(
                'fill', -- line
                (VIRTUAL_WIDTH / n_cols) * ((i - 1) % n_cols) + horizontalPadding / 2 - corner, -- x position
                20 + math.floor((i - 1) / n_cols) * 200 - corner - dySelected, -- y position
                VIRTUAL_WIDTH / n_cols - horizontalPadding + corner * 2, -- width
                VIRTUAL_HEIGHT / n_rows - padding - 100 + corner * 2 -- height
            )
        else
            love.graphics.setColor(1, 1, 0, 1) -- Default color
            love.graphics.rectangle(
                'fill', -- line
                (VIRTUAL_WIDTH / n_cols) * ((i - 1) % n_cols) + horizontalPadding / 2 - corner, -- x position
                20 + math.floor((i - 1) / n_cols) * 200 - corner, -- y position
            VIRTUAL_WIDTH / n_cols - horizontalPadding + corner * 2, -- width
                VIRTUAL_HEIGHT / n_rows - padding - 100 + corner * 2 -- height
            )
        end

    end
end

function MainMenuState:exit()
    -- Cleanup or reset when exiting this state
end
