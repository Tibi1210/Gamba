local module = {}

-- for displaying on the screen while opening
function module.New(size)
    local temp = {}
    for i = 1, size do
                table.insert(temp, {i, love.graphics.newImage("Assets/Items/item"..i..".png")})
                --table.insert(temp, "item"..i..".png")
    end
    return temp
end

local probabilities = {
    {range = {1, 7}, chance = 0.7992},
    {range = {8, 12}, chance = 0.1598},
    {range = {13, 15}, chance = 0.032},
    {range = {16, 17}, chance = 0.0064},
    {range = {18, 18}, chance = 0.0026}
  }

local function selectItem()
    local rand = math.random()
    local cumulative = 0
    for _, group in ipairs(probabilities) do
      cumulative = cumulative + group.chance
      if rand <= cumulative then
        return math.random(group.range[1], group.range[2])
      end
    end
  end

function module.Open(case)
    local selected = selectItem()
    return case[selected]
end

return module