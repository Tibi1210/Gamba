local time = 0
local is_fullscreen = true
local hand = {}
local card_size = {100,140}
local prev_time = 0
local canvas = love.graphics.newCanvas(SW, SH)
local r, g, b = love.math.colorFromBytes(34, 115, 56,1)
love.graphics.setBackgroundColor(255, 0, 0)
local grab_num = 0

function love.load()
    time = 0

    os.execute("cls")
    local currentDeck = Deck.New(1)

    --hand["cards"] = Deck.Draw(currentDeck,10, "top")
    hand["cards"] = Deck.New(1)

    local temp = {0,-100}
    for i = 1, #hand["cards"] do
        if i%10==1 then
            temp[1] = 0
            temp[2] = temp[2]+100
        end
        hand["cards"][i][4] = {temp[1], temp[2]}
        temp[1]=temp[1]+120
    end

end

function love.update(dt)
    time = time + dt

    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()
        for i = 1, #hand["cards"] do
            if hand["cards"][i][5] and x>hand["cards"][i][4][1] and x<hand["cards"][i][4][1]+card_size[1] and y>hand["cards"][i][4][2] and y<hand["cards"][i][4][2]+card_size[2] then
                hand["cards"][i][4] = {x - card_size[1]/2, y - card_size[2]/2}
            end
        end
    end
    if love.mouse.isDown(2) and time-prev_time>0.1 then
        prev_time = time
        for i = #hand["cards"], 1, -1 do
            if hand["cards"][i][5] then
                hand["cards"][i][5] = false
                grab_num = grab_num - 1
                break
            end
        end
    end

    
    love.graphics.setCanvas(canvas)
        love.graphics.setColor(r,g,b,1)
        love.graphics.rectangle("fill", 0, 0, SW, SH)
        love.graphics.setColor(1,1,1,1)
        Shader.New("Shaders/Card.glsl")
        love.graphics.setShader(Shader.Get())
        Shader.SetVector2("_Size", card_size)
        for i = #hand["cards"], 1, -1  do
            Shader.SetTexture2D("_Card", hand["cards"][i][3], "clampzero", "nearest")
            Shader.SetVector2("_CardPos", hand["cards"][i][4])
            love.graphics.rectangle("fill", hand["cards"][i][4][1], hand["cards"][i][4][2], card_size[1], card_size[2])
        end
        love.graphics.setShader()
    love.graphics.setCanvas()

end

function love.draw()
    love.graphics.draw(canvas, 0,0)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        for i = 1, #hand["cards"] do
            if x>hand["cards"][i][4][1] and x<hand["cards"][i][4][1]+card_size[1] and y>hand["cards"][i][4][2] and y<hand["cards"][i][4][2]+card_size[2] then
                hand["cards"][i][5] = true

                table.insert(hand["cards"], 1+grab_num, table.remove(hand["cards"], i))
                grab_num = grab_num + 1
            end
        end
    end

 end

 function love.mousereleased(x, y, button)
    if button == 1 then
        for i = 1, #hand["cards"] do
            hand["cards"][i][5] = false
        end
        grab_num = 0
    end
 end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'r' then
        love.event.quit("restart")
    end

    if key == 'f' then
        love.window.setFullscreen(is_fullscreen)
        if not is_fullscreen then
            SW = 1200
            SH = 675
            love.load()
        else
            SW = love.graphics.getWidth()
            SH = love.graphics.getHeight()
            love.load()
        end
        is_fullscreen = not is_fullscreen
    end
end
