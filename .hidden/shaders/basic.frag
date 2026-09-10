#version 330 core


uniform vec4 uColor;   // rgb + base alpha
out vec4 FragColor;
uniform bool uBlend;

void main() {
    if (uBlend==1) {
        FragColor = vec4(uColor.rgb, 0.35); // translucent
    } else {
        FragColor = vec4(0.0 , 1.0, 0.0, 1.0);  // opaque
    }
}