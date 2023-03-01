varying vec3 normal, lightDir, eyeVec;
varying float render;

void main (void) {	
	if (1) {
		vec4 color = (gl_FrontLightModelProduct.sceneColor * gl_FrontMaterial.ambient) + 
					 (gl_LightSource[0].ambient * gl_FrontMaterial.ambient);						
						
		vec3 N = normalize(normal);		
		vec3 L = normalize(lightDir);
		
		float lambertTerm = dot(N, L);
		
		if (lambertTerm > 0.0) {
			color += gl_LightSource[0].diffuse * gl_FrontMaterial.diffuse * lambertTerm;	
			
			vec3 E = normalize(eyeVec);
			vec3 R = reflect(-L, N);
			float specular = pow( max(dot(R, E), 0.0), gl_FrontMaterial.shininess);
			color += gl_LightSource[0].specular * gl_FrontMaterial.specular * specular;	
		}
		gl_FragColor = color;		
	}
	else {
		gl_FragColor = vec4(0.0, 0.0, 0.2, 1.0);
	}	
}