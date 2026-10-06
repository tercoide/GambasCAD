#version 330 core

// Matrices come from ShaderMatrices.class (column-major, built with Matrix4.class).
// uMVP = uProjection * uView * uModel, multiplied once per change on the CPU.
uniform mat4 uModel;
uniform mat4 uView;
uniform mat4 uProjection;
uniform mat4 uMVP;

// Attribute locations match ShaderMatrices.ATTRIB_* and vertex1.txt
layout(location = 0) in vec3 vertexPosition;
layout(location = 2) in vec4 vertexColor;   // VBO colors are rgb; alpha defaults to 1.0

out vec4 color;

void main()
{
    color = vertexColor;
    gl_Position = uMVP * vec4(vertexPosition, 1.0);
}
