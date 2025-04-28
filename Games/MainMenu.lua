
local menu = {}

    menu.start = 0
    menu.canvas = nil
    local start_btn = {1200/2-75, 675/2-37.5, 150, 75}

    function menu.load()
        if menu.start == 1 then
            Cards.canvas = love.graphics.newCanvas(1200, 675)
            Cards.load()
        end
    end

    function menu.update(time)
        if menu.start == 1 then
            Cards.update(time)
        else
            love.graphics.setCanvas(menu.canvas)
            Shader.New("Shaders/noise_art_fbm.glsl")
            love.graphics.setShader(Shader.Get())
            Shader.SetFloat("_Time", time)
            Shader.SetVector2("_ScreenSize", { love.graphics.getWidth(), love.graphics.getHeight() })
            love.graphics.rectangle("fill", 0, 0, 1200, 675)
            love.graphics.setShader()
            love.graphics.setColor(34/255, 45/255, 115/255,1)
            love.graphics.rectangle("fill", start_btn[1], start_btn[2], start_btn[3], start_btn[4])
            love.graphics.setColor(1,1,1,1)
            love.graphics.setCanvas()
        end
    end

    function menu.draw()
        if menu.start == 1 then
            Cards.draw()
        else
            love.graphics.draw(menu.canvas, 0,0)
            love.graphics.setColor(0,0,0,1)
            love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 12)
        end
        
    end

    function menu.mousepressed(x, y, button)
        if button == 1 then
            if menu.start == 1 then
                Cards.mousepressed(x, y, button)
            else
                if x>start_btn[1] and x<start_btn[1]+start_btn[3] and y>start_btn[2] and y<start_btn[2]+start_btn[4] then
                    menu.start = 1
                    love.load()
                end
            end
        end
    end

    function menu.mousereleased(x, y, button)
        if menu.start == 1 then
            Cards.mousereleased(x, y, button)
        end
    end


return menu