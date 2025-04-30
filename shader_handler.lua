local module = {}

local shader_instance = nil

function module.New(path)
    shader_instance = love.graphics.newShader(path)
end

function module.Get()
    if shader_instance then
        return shader_instance
    end
end

function module.SetFloat(uniform, value)
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        shader_instance:send(uniform, value)
    end
end

function module.SetInteger(uniform, value)
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        shader_instance:send(uniform, math.floor(value))
    end
end

function module.SetBoolean(uniform, value)
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        shader_instance:send(uniform, value)
    end
end

function module.SetVector2(uniform, vec2)
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        if #vec2 == 2 then
            shader_instance:send(uniform, vec2)
        else
            error("Shader uniform Vector2 expected, got Vector" .. #vec2)
        end
    end
end

function module.SetVector4(uniform, vec4)
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        if #vec4 == 4 then
            shader_instance:send(uniform, vec4)
        else
            error("Shader uniform Vector2 expected, got Vector" .. #vec4)
        end
    end
end

function module.SetTexture2D(uniform, image, wrap, filter)
    wrap = wrap or 'repeat'
    filter = filter or 'linear'
    if shader_instance ~= nil and shader_instance:hasUniform(uniform) then
        image:setWrap(wrap, wrap)
        image:setFilter(filter, filter)
        shader_instance:send(uniform, image)
    end
end

return module
