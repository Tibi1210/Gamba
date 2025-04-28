local time = 0
local is_fullscreen = true
local hand = {}
local card_size = {100,140}
local grab = false

local canvas = love.graphics.newCanvas(SW, SH)
local r, g, b = love.math.colorFromBytes(34, 115, 56,1)
love.graphics.setBackgroundColor(255, 0, 0)

function love.load()
    time = 0

    os.execute("cls")
    local currentDeck = Deck.New(1)
    Deck.Print(currentDeck)
    print()
    
    print("HAND")
    hand["cards"] = Deck.Draw(currentDeck,5, "top")
    Deck.Print(hand["cards"])

    local temp = 0
    for i = 1, #hand["cards"] do
        hand["cards"][i][4] = {temp, 0}
        temp=temp+120
    end

end

function love.update(dt)
    time = time + dt

    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()
        for i = 1, #hand["cards"] do
            if x>hand["cards"][i][4][1] and x<hand["cards"][i][4][1]+card_size[1] and y>hand["cards"][i][4][2] and y<hand["cards"][i][4][2]+card_size[2] and not grab then
                hand["cards"][i][4] = {x - card_size[1]/2, y - card_size[2]/2}
                grab = true
            else
                grab = false
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
        for i = 1, #hand["cards"] do
            Shader.SetTexture2D("_Card", hand["cards"][i][3], "clamp", "nearest")
            Shader.SetVector2("_CardPos", hand["cards"][i][4])
            love.graphics.rectangle("fill", hand["cards"][i][4][1], hand["cards"][i][4][2], card_size[1], card_size[2])
        end
        love.graphics.setShader()
    love.graphics.setCanvas()

end

function love.draw()
    love.graphics.draw(canvas, 0,0)
end

function love.mousepressed(x, y, button, istouch)
    if button == 2 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
       print(x)
       print(y)

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
