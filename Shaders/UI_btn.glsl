extern vec2 _Pos;
extern vec2 _Size;
extern sampler2D _Img;
extern bool _IsHovered;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 card_size =_Size - vec2(10,10);
    vec2 uv = (screen_coords - _Pos) / card_size;
    vec4 card = texture2D(_Img, uv);

    vec4 shadow = vec4(0.0);

    if (_IsHovered) {
        vec2 shadowOffset = vec2(5.0, 5.0);
        vec2 shadowUV = (screen_coords - _Pos - shadowOffset) / card_size;
        float shadowAlpha = 0.4;
        float cardAlpha = texture2D(_Img, shadowUV).a * shadowAlpha;
        shadow = vec4(vec3(0.2), cardAlpha);
    }

    vec4 result = shadow * (1.0 - card.a) + card;
    return result;
}
