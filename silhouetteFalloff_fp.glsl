varying vec3 objectPosition, normal, lightDir, eyeVec;

void main() {					 
	// Compute vectors needed for lighting
	vec3 N = normalize(normal);		
	vec3 L = normalize(lightDir);
	
	vec3 E = normalize(eyeVec);
	vec3 R = reflect(-L, N);
	
	// Compute opacity based on dot product of eye vector and surface normal
	float opacity = 1.0 - dot(N, E);
	float epsilon = 0.1;
	if (opacity > 1.0 + epsilon) discard;
	
	// Perform lighting
	float lambertTerm = abs(dot(N, L));	
	float specularTerm = pow(max(dot(R, E), 0.0), gl_FrontMaterial.shininess);
	
	vec4 color = gl_FrontLightModelProduct.sceneColor;
	color += gl_FrontLightProduct[0].ambient;
	color += gl_FrontLightProduct[0].diffuse * lambertTerm;
	color += gl_FrontLightProduct[0].specular * specularTerm;
	
	color.a = 1.0;
	color *= opacity;
	
	gl_FragColor = color;
}