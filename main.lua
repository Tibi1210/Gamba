local time = 0

love.graphics.setBackgroundColor(255, 0, 0)


function love.load()
    time = 0

    
    MainMenu.canvas = love.graphics.newCanvas(SW, SH)
    MainMenu.load()


end

function love.update(dt)
    time = time + dt
    
    MainMenu.update(time)
end

function love.draw()
    MainMenu.draw()
end

function love.mousepressed(x, y, button)
    MainMenu.mousepressed(x, y, button)
 end

 function love.mousereleased(x, y, button)
    MainMenu.mousereleased(x, y, button)
 end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'r' then
        love.event.quit("restart")
    end
end
