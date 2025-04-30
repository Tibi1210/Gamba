local Game_handler = {}


    Game_handler.hand = {}
    local prev_time = 0
    local grab_num = 0
    Game_handler.canvas = nil

    function Game_handler.load()
        -- local currentDeck = Deck.New(1)
        -- hand["cards"] = Deck.Draw(currentDeck,10, "top")
        Game_handler.hand["cards"] = Deck.New(5)

        --local temp = {0,-100}
        for i = 1, #Game_handler.hand["cards"] do
            if i%10==1 then
                --temp[1] = 0
                --temp[2] = temp[2]+100
            end
            Game_handler.hand["cards"][i][4] = {0, 0}
            --temp[1]=temp[1]+120
        end

    end

    function Game_handler.update(time)

        if love.mouse.isDown(1) then
            local x, y = love.mouse.getPosition()
            for i = 1, #Game_handler.hand["cards"] do
                if Game_handler.hand["cards"][i][5] and x>Game_handler.hand["cards"][i][4][1] and x<Game_handler.hand["cards"][i][4][1]+CardSize[1] and y>Game_handler.hand["cards"][i][4][2] and y<Game_handler.hand["cards"][i][4][2]+CardSize[2] then
                    Game_handler.hand["cards"][i][4] = {x - CardSize[1]/2, y - CardSize[2]/2}
                end
            end
        end
        if love.mouse.isDown(2) and time-prev_time>0.1 then
            prev_time = time
            for i = #Game_handler.hand["cards"], 1, -1 do
                if Game_handler.hand["cards"][i][5] then
                    Game_handler.hand["cards"][i][5] = false
                    grab_num = grab_num - 1
                    break
                end
            end
        end

        love.graphics.setCanvas(Cards.canvas)


        Background_handler.setBackground(34,115,56)
        Shader.New("Shaders/Card.glsl")
        love.graphics.setShader(Shader.Get())
        Shader.SetVector2("_Size", CardSize)
        for i = #Game_handler.hand["cards"], 1, -1  do
            Shader.SetTexture2D("_Card", Game_handler.hand["cards"][i][3], "clampzero", "nearest")
            Shader.SetVector2("_CardPos", Game_handler.hand["cards"][i][4])
            Shader.SetBoolean("_IsGrabbed", Game_handler.hand["cards"][i][5])
            love.graphics.rectangle("fill", Game_handler.hand["cards"][i][4][1], Game_handler.hand["cards"][i][4][2], CardSize[1], CardSize[2])
        end
        love.graphics.setShader()
        love.graphics.setCanvas()


    end

    function Game_handler.draw()
        love.graphics.draw(Game_handler.canvas, 0,0)
        love.graphics.setColor(0,0,0,1)
        love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 12)
    end

    function Game_handler.mousepressed(x, y, button)
        if button == 1 then
            for i = 1, #Game_handler.hand["cards"] do
                if x>Game_handler.hand["cards"][i][4][1] and x<Game_handler.hand["cards"][i][4][1]+CardSize[1] and y>Game_handler.hand["cards"][i][4][2] and y<Game_handler.hand["cards"][i][4][2]+CardSize[2] then
                    Game_handler.hand["cards"][i][5] = true

                    table.insert(Game_handler.hand["cards"], 1+grab_num, table.remove(Game_handler.hand["cards"], i))
                    grab_num = grab_num + 1
                end
            end
        end

    end

    function Game_handler.mousereleased(_, _, button)
        if button == 1 then
            for i = 1, #Game_handler.hand["cards"] do
                Game_handler.hand["cards"][i][5] = false
            end
            grab_num = 0
        end
    end

return Game_handler