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

uniform vec3 boundingBoxMin; // cantonada minima de la capsa englobant 
uniform vec3 boundingBoxMax; // cantonada maxima de la capsa englobant

uniform vec2 mousePosition;  // coordenades del cursor (window space; origen a la cantonada inferior esquerra)

void main()
{
    // Lighting Phong
    // Formula: Ka Ia + Kd Id (N · L) + Ks Is (R · V)^s
    // Ka, Kd, Ks = reflectivitat ambient, difosa i especular del material
    // s = shininess del material
    // Ia, Id, Is = propietats ambient, difosa i especular de la llum 
    // N = vector normal unitari 
    // L = vector unitari cap a la font de llum 
    // V = vector unitari del vèrtex cap a la càmera 
    // R =  reflexió del vector L respecte N. Es pot calcular com R=2(N·L)N-L 
        
    vec4 vertexEyeSpace = modelViewMatrix * vec4(vertex,1.0);
    vec3 N = normalize(normalMatrix * normal);
    vec3 L = normalize((lightPosition - vertexEyeSpace).xyz);
    vec3 V = normalize(-vertexEyeSpace.xyz);
    vec3 R = normalize(2 * dot(N,L) * N - L);    
    frontColor = matAmbient * lightAmbient + matDiffuse * lightDiffuse * max(0.0, dot(N,L)) + 
                 matSpecular * lightSpecular * pow(max(0.0, dot(R,V)),matShininess);
    
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
