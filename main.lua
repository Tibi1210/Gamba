local time = 0
local is_fullscreen = true
local hand = Cards.hand
local prev_time = 0
Cards.canvas = love.graphics.newCanvas(SW, SH)
love.graphics.setBackgroundColor(255, 0, 0)
local grab_num = 0

function love.load()
    time = 0

    Cards.load()

end

function love.update(dt)
    time = time + dt

    Cards.update(time)
end

function love.draw()
    Cards.draw()
end

function love.mousepressed(x, y, button)
    Cards.mousepressed(x, y, button)

 end

 function love.mousereleased(x, y, button)
    Cards.mousereleased(x, y, button)
 end

function love.keypressed(key)
    Cards.keypressed(key)
end
