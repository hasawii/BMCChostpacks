#version 150

#moj_import <fog.glsl>

#moj_import <emissives_config_impl.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;

in vec4 lightMapValue;
in vec4 normalLightValue;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);

    color = applyLighting(getAlpha(color.a), color * vertexColor, normalLightValue, lightMapValue);
    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor) * ColorModulator;
}
