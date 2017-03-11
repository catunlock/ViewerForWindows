#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D explosion;

const float slice = 1.0 /30.0;

void main()
{
    int frame = int(time/slice)%48;
    float fila = 5 - frame/8;
    float col = frame%8;
    vec2 tex = vec2((vtexCoord.s + col) * 1.0/8.0, (vtexCoord.t + fila) * 1.0/6.0);
    vec4 color = texture(explosion, tex);
    fragColor = color.a * color;

}
