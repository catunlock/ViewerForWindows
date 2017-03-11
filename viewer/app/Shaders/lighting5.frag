#version 330 core

in vec3 vertexObjectSpace;
in vec3 normalObjectSpace;
out vec4 fragColor;

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
uniform bool world = true;

// Light Phong
// Ka*Ia + Kd*Id*max(0.0,dot(N,L)) + Ks*Is+pow(max(0.0, dot(R,v)),s)
vec4 light(vec3 N, vec3 V, vec3 L) 
{
    N = normalize(N);
    V = normalize(V);
    L = normalize(L);
    vec3 R = normalize(2*dot(N,L)*N-L);
    float NdotL = max(0.0,dot(N,L));
    float ISpec = 0.0;
    if (NdotL > 0)
    {
       ISpec = pow(max(0.0,dot(R,V)),matShininess);
    }
    
    return matAmbient * lightAmbient + matDiffuse * lightDiffuse * NdotL + matSpecular * lightSpecular * ISpec;
}

void main()
{
    vec3 V = vec3(0.0,0.0,0.0);
    vec3 N = vec3(0.0,0.0,0.0);
    vec3 L = vec3(0.0,0.0,0.0);
    if (!world)
    {
        V = -(modelViewMatrix * vec4(vertexObjectSpace,1.0)).xyz;
        N = normalMatrix * normalObjectSpace;
        L = lightPosition.xyz + V;
    }
    else
    {        
        V = -vertexObjectSpace;
        N = normalObjectSpace;
        L = (viewMatrixInverse * lightPosition).xyz + V;
    }
    
    fragColor = light(N,V,L);
}
