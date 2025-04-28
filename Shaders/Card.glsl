extern vec2 _Size;
extern vec2 _CardPos;
extern sampler2D _Card;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = (screen_coords - _CardPos) / _Size;
    vec4 card = texture2D(_Card, uv);
    return card;
}