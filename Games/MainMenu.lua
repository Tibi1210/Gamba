
local menu = {}

    menu.start = 0
    menu.canvas = nil
    local card_btn = UI_btn.New(1200/2-75, 675/2-37.5,     175, 75, "card")
    local case_btn = UI_btn.New(1200/2-75, 675/2-37.5+100, 175, 75, "case")


    function menu.load()
        if menu.start == 1 then
            Card_game.canvas = love.graphics.newCanvas(1200, 675)
            Card_game.load()
        elseif menu.start == 2 then
            Case_game.canvas = love.graphics.newCanvas(1200, 675)
            Case_game.load()
        end
    end

    function menu.update(time)
        if menu.start == 1 then
            Card_game.update(time)
        elseif menu.start == 2 then
            Case_game.update(time)
        else
            love.graphics.setCanvas(menu.canvas)
            Support_functions.setBackground(148, 150, 33)
            local m_x, m_y = love.mouse.getPosition()
            card_btn.Show({m_x, m_y})
            case_btn.Show({m_x, m_y})
            love.graphics.setColor(1,1,1,1)
            love.graphics.setCanvas()
        end
    end

    function menu.draw()
        if menu.start == 1 then
            Card_game.draw()
        elseif menu.start == 2 then
            Case_game.draw()
        else
            love.graphics.draw(menu.canvas, 0,0)
            love.graphics.setColor(0,0,0,1)
            love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 12)
        end
        
    end

    function menu.mousepressed(x, y, button)
        if button == 1 then
            if menu.start == 1 then
                Card_game.mousepressed(x, y, button)
            elseif menu.start == 2 then
                Case_game.mousepressed(x, y, button)
            else
                if card_btn.onClick(x, y) then
                    menu.start = 1
                    menu.load()
                end
                if case_btn.onClick(x, y) then
                    menu.start = 2
                    menu.load()
                end
            end
        end
    end

    function menu.mousereleased(x, y, button)
        if menu.start == 1 then
            Card_game.mousereleased(x, y, button)
        elseif menu.start == 2 then
            Case_game.mousereleased(x, y, button)
        end
    end


return menu