
local menu = {}

    menu.start = 2
    menu.canvas = nil
    local card_btn = {1200/2-75, 675/2-37.5, 150, 75}
    local case_btn = {1200/2-75, 675/2-37.5+100, 150, 75}

    function menu.load()
        print(menu.start)
        if menu.start == 1 then
            Cards.canvas = love.graphics.newCanvas(1200, 675)
            Cards.load()
        elseif menu.start == 2 then
            Case.canvas = love.graphics.newCanvas(1200, 675)
            Case.load()
        end
    end

    function menu.update(time)
        if menu.start == 1 then
            Cards.update(time)
        elseif menu.start == 2 then
            Case.update(time)
        else
            love.graphics.setCanvas(menu.canvas)
            Shader.New("Shaders/noise_art_fbm.glsl")
            love.graphics.setShader(Shader.Get())
            Shader.SetFloat("_Time", time)
            Shader.SetVector2("_ScreenSize", { love.graphics.getWidth(), love.graphics.getHeight() })
            love.graphics.rectangle("fill", 0, 0, SW, SH)
            love.graphics.setShader()
            love.graphics.setColor(34/255, 45/255, 115/255,1)
            love.graphics.rectangle("fill", card_btn[1], card_btn[2], card_btn[3], card_btn[4])
            love.graphics.setColor(115/255, 80/255, 34/255,1)
            love.graphics.rectangle("fill", case_btn[1], case_btn[2], case_btn[3], case_btn[4])
            love.graphics.setColor(1,1,1,1)
            love.graphics.setCanvas()
        end
    end

    function menu.draw()
        if menu.start == 1 then
            Cards.draw()
        elseif menu.start == 2 then
            Case.draw()
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
            elseif menu.start == 2 then
                Case.mousepressed(x, y, button)
            else
                if x>card_btn[1] and x<card_btn[1]+card_btn[3] and y>card_btn[2] and y<card_btn[2]+card_btn[4] then
                    menu.start = 1
                    menu.load()
                end
                if x>case_btn[1] and x<case_btn[1]+case_btn[3] and y>case_btn[2] and y<case_btn[2]+case_btn[4] then
                    menu.start = 2
                    menu.load()
                end
            end
        end
    end

    function menu.mousereleased(x, y, button)
        if menu.start == 1 then
            Cards.mousereleased(x, y, button)
        elseif menu.start == 2 then
            Case.mousereleased(x, y, button)
        end
    end


return menu