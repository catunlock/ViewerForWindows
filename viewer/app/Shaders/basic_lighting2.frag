#version 330 core

in vec4 frontColor;
in vec3 normalNormalized;
out vec4 fragColor;

void main()
{
    fragColor = frontColor * normalNormalized.z;
}
