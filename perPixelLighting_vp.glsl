varying vec3 normal, lightDir, eyeVec;

void main() {
	// Calculate the vertex normal
	normal = gl_NormalMatrix * gl_Normal;
	
	// Calculate the position in world space
	vec3 position = gl_ModelViewMatrix * gl_Vertex;
	
	// Calculate the light direction and eye vector
	lightDir = gl_LightSource[0].position.xyz - position;
	eyeVec = -position;
	
	// Transform the position, as is necessary for all vertex programs
	gl_Position = ftransform();	
}