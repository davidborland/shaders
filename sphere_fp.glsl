varying vec3 posInObj, eyeInObj, lightInObj;

void main() {	
	// Calculate the intersection of eye ray with the sphere
	vec3 dir = normalize(posInObj - eyeInObj);	
	vec3 dst = eyeInObj;
	
	float B = dot(dst, dir);
	float C = dot(dst, dst) - 1.0;
	float D = B * B - C;
	
	if (D <= 0.0) discard;
	
	// Hit the sphere, calculate the position
	vec3 pos = eyeInObj + dir * (-B - sqrt(D));
	
	
	// Perform lighting in object space
	vec3 N = normalize(pos);
	vec3 L = normalize(pos - lightInObj);
	
	vec3 E = normalize(pos - eyeInObj);
	vec3 R = reflect(-L, N);
	
	float lambertTerm = abs(dot(N, L));
	float specularTerm = pow(max(dot(R, E), 0.0), gl_FrontMaterial.shininess);

	vec4 color = gl_FrontLightModelProduct.sceneColor;
	color += gl_FrontLightProduct[0].ambient;
	color += gl_FrontLightProduct[0].diffuse * lambertTerm;
	color += gl_FrontLightProduct[0].specular * specularTerm;
	
	gl_FragColor = color;
	
	
	// Calculate z by transforming to clip space and mapping to 0..1
	vec4 tPos = gl_ModelViewProjectionMatrix * vec4(pos.x, pos.y, pos.z, 1.0);	
	float z = tPos.z / tPos.w;
	z = (z + 1.0) * 0.5;
	
	gl_FragDepth = z;
}