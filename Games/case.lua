
local Case_handler = {}

    Case_handler.canvas = nil

    function Case_handler.load()

    end

    function Case_handler.update(time)
        love.graphics.setCanvas(Case_handler.canvas)

        Background_handler.setBackground(54,54,54)

        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill", SW/2-450, SH/2-150, 900, 300)
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", SW/2-2.5, 87.5, 5, 500)
        --love.graphics.line( SW/2, 187.5, SW/2, 300+187.5)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setCanvas()

    end

    function Case_handler.draw()
        love.graphics.draw(Case_handler.canvas, 0,0)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 12)
    end

    function Case_handler.mousepressed(x, y, button)

    end

    function Case_handler.mousereleased(x, y, button)

    end


return Case_handler