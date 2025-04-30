local module = {}


local cards = {}
for _, suite in pairs({'S', 'D', 'H', 'C'}) do
    for i = 2, 10 do
        cards[i..suite] = i
    end
for _, face in pairs({'J', 'Q', 'K', 'A'}) do
    cards[face..suite] = 10
end
end

function module.New(size)
    local temp = {}
    for _ = 1, size do
            for key, value in pairs(cards) do
                --print(key..": "..value)
                table.insert(temp, {key, value, love.graphics.newImage("Assets/Cards/"..key..".png"), {0, 0}, false})
            end
    end
    temp = module.Shuffle(temp)
    return temp
end

function module.Fold(from, to)
    for i = 1, module.Size(from) do
        table.insert(to, table.remove(from, 1))
    end
end

function module.Shuffle(deck)
    math.randomseed(os.time())
    local temp = {}
    for i = 1, module.Size(deck) do
        table.insert(temp, table.remove(deck, math.random(module.Size(deck))))
    end
    return temp
end

function module.Size(deck)
    local temp = 0
    for _, _ in pairs(deck) do
        temp = temp + 1
    end
    return temp
end

function module.Draw(from, num, where)
    math.randomseed(os.time())
    where = where or 'random'
    local hand = {}
    local size = module.Size(from)
    if num < size then
        for i = 1, num do
            if where == "top" then
                table.insert(hand,table.remove(from, size))
                size = size - 1
            elseif where == "bot" then
                table.insert(hand,table.remove(from, 1))
                size = size - 1
            else
                table.insert(hand,table.remove(from, math.random(size)))
                size = size - 1
            end
        end
    end
    return hand
end


return module