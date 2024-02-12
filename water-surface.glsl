#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 u_mouse;
uniform vec2 resolution;

uniform sampler2D textures;
varying vec2 vUv;


#define MAX_ITER 100
void main( void ) {
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 p =  uv * 4.0 - vec2(15.0);
	vec2 i = p;
	float c = 1.0;
	float inten = .05;

	for (int n = 0; n < MAX_ITER; n++) 
	{
		float t = time * (0.1 - (0.1 / float(n+1)));
		i = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(t + i.x));
		c += 1.0/length(vec2(p.x / (sin(i.x+t)/inten),p.y / (cos(i.y+t)/inten)));
	}
	c /= float(MAX_ITER);
	c = 1.5-sqrt(c);
	gl_FragColor = vec4(vec3(c*c*c*c), 1.0) + vec4(0.43, 0.17, 0.05, 1.0);

}
