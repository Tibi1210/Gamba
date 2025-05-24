local UI_btn = {}


    function UI_btn.New(x, y, w, h, img)
        img = img or nil
        local btn = {}
        btn.pos = {x, y, w, h}
        function btn.Show(mouse)
            if img then
                Shader.New("Shaders/UI_btn.glsl")
                love.graphics.setShader(Shader.Get())
                Shader.SetVector2("_Pos", {x, y})
                Shader.SetVector2("_Size", {w, h})
                Shader.SetTexture2D("_Img", love.graphics.newImage("Assets/Buttons/"..img..".png"), "clampzero", "nearest")
                Shader.SetBoolean("_IsHovered", btn.onClick(mouse[1], mouse[2]))
                love.graphics.rectangle("fill", btn.pos[1], btn.pos[2], btn.pos[3], btn.pos[4])
                love.graphics.setShader()
            else
                love.graphics.setColor(219/255, 3/255, 252/255, 1)
                love.graphics.rectangle("fill", btn.pos[1], btn.pos[2], btn.pos[3], btn.pos[4])
            end
        end
        function btn.onClick(m_x, m_y)
            if m_x>btn.pos[1] and m_x<btn.pos[1]+btn.pos[3] and m_y>btn.pos[2] and m_y<btn.pos[2]+btn.pos[4] then
                return true
            end
            return false
        end
        return btn
    end





return UI_btn