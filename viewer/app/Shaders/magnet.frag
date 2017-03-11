#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;
in vec3 N;

uniform sampler2D colorMap;

void main()
{
	fragColor = vec4(vec3(N.z),1.0);
//     fragColor = frontColor * texture(colorMap, vtexCoord);
}
