local module = {}

function module.setBackground(r,g,b)
    love.graphics.setColor(r/255, g/255, b/255,1)
    love.graphics.rectangle("fill", 0, 0, SW, SH)
    love.graphics.setColor(1,1,1,1)
end

return module