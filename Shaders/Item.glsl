extern vec2 _Size;
extern vec2 _ItemPos;
extern vec4 _Rarity;
extern sampler2D _Item;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = (screen_coords - _ItemPos) / _Size;
    vec2 uv2 = (screen_coords - (_ItemPos+vec2(5,5))) / (_Size-vec2(10,10));
    vec4 item = texture2D(_Item, uv2);

    if (item.a == 0){

        return _Rarity;
    }
        

    return item;
}
