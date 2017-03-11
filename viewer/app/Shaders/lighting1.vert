#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform mat4 modelMatrixInverse;
uniform mat4 viewMatrixInverse;
uniform mat4 projectionMatrixInverse;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewProjectionMatrixInverse;

uniform mat3 normalMatrix;

uniform vec4 lightAmbient;  // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse;  // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position; en eye space
uniform vec4 matAmbient;    // similar a gl_FrontMaterial.ambient 
uniform vec4 matDiffuse;    // similar a gl_FrontMaterial.diffuse 
uniform vec4 matSpecular;   // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess



void main()
{
    
    // Lighting Blinn-Phong
    
    // Ka Ia + Kd Id (N · L) + Ks Is (N · H)^S
    // K = material
    // I = luz
    
    vec4 vertexEyeSpace = modelViewMatrix * vec4(vertex, 1.0);
    vec3 L = normalize((lightPosition - vertexEyeSpace).xyz);
    vec3 N = normalize(normalMatrix * normal);
    vec3 V = normalize(-(vertexEyeSpace).xyz);
    vec3 H = normalize(V + L);
    frontColor = matAmbient * lightAmbient + matDiffuse * lightDiffuse * max(0.0,dot(N,L)) + 
                 matSpecular * lightSpecular * pow(max(0.0,dot(N,H)),matShininess);
    
    vtexCoord = texCoord;
    gl_Position = projectionMatrix * vertexEyeSpace;
}
