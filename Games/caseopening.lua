
local Case_handler = {}

    Case_handler.canvas = nil
    local item
    local case
    local display_pos
    
    local prev_time = 0
    local stop = 0
    local num = 0
    local slow = 0.1

    local item_line = {}

    function Case_handler.load()

        case = Case.New(18)
        item = Case.Open(case)
        
        for _ = 1, 5 do
            table.insert(item_line, Case.Open(case))
        end


    end

    function Case_handler.update(time)
        
        if time-prev_time>slow and stop < 10 then
            prev_time = time
            stop = stop + 1

            slow = slow + 0.01
            if stop == 8 then
                table.insert(item_line, 1, item)
            else
                table.insert(item_line, 1, Case.Open(case))
            end

            table.remove(item_line, 6)

        end

        love.graphics.setCanvas(Case_handler.canvas)

        Support_functions.setBackground(54,54,54)

        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill", SW/2-450, 100, 900, 300)

        Shader.New("Shaders/Item.glsl")
        display_pos = {100, 150}
        love.graphics.setShader(Shader.Get())
        Shader.SetVector2("_Size", {200, 200})
        for index, value in ipairs(item_line) do
            if value[1] < 8 then
                Shader.SetVector4("_Rarity", {78/255, 111/255, 255/255, 1})
            elseif value[1] < 13 then
                Shader.SetVector4("_Rarity", {138/255, 72/255, 254/255, 1})
            elseif value[1] < 16 then
                Shader.SetVector4("_Rarity", {149/255, 37/255, 168/255, 1})
            elseif value[1] < 18 then
                Shader.SetVector4("_Rarity", {217/255, 69/255, 73/255, 1})
            else
                Shader.SetVector4("_Rarity", {252/255, 179/255, 57/255, 1})
            end
            Shader.SetTexture2D("_Item", value[2], "clampzero", "nearest")
            Shader.SetVector2("_ItemPos", {display_pos[1], display_pos[2]})
            love.graphics.rectangle("fill", display_pos[1], display_pos[2], 200, 200)
            
            display_pos[1] = display_pos[1] + 210

        end
        love.graphics.setShader()

        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("fill", SW/2-2.5, 80, 5, 340)
        love.graphics.setColor(1,1,1,1)

        display_pos = {50, 450}
        love.graphics.setShader(Shader.Get())
        Shader.SetVector2("_Size", {100, 100})
        for index, value in ipairs(case) do
            if value[1] < 8 then
                Shader.SetVector4("_Rarity", {78/255, 111/255, 255/255, 1})
            elseif value[1] < 13 then
                Shader.SetVector4("_Rarity", {138/255, 72/255, 254/255, 1})
            elseif value[1] < 16 then
                Shader.SetVector4("_Rarity", {149/255, 37/255, 168/255, 1})
            elseif value[1] < 18 then
                Shader.SetVector4("_Rarity", {217/255, 69/255, 73/255, 1})
            else
                Shader.SetVector4("_Rarity", {252/255, 179/255, 57/255, 1})
            end
            Shader.SetTexture2D("_Item", value[2], "clampzero", "nearest")
            Shader.SetVector2("_ItemPos", {display_pos[1], display_pos[2]})
            love.graphics.rectangle("fill", display_pos[1], display_pos[2], 100, 100)
            
            display_pos[1] = display_pos[1] + 110
            if index==10 then
                display_pos[1] = 50
                display_pos[2] = display_pos[2] + 110
            end
        end
        love.graphics.setShader()

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