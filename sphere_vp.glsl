varying vec3 positionInObj, eyeInObj, lightInObj;

void main() {		
	// Lighting will be calculated in object space, so transform the 
	// eyepoint from eye space to object space here
	eyeInObj = gl_ModelViewMatrixInverse * vec4(0.0, 0.0, 0.0, 1.0);
	lightInObj = gl_ModelViewMatrixInverse * gl_LightSource[0].position;
	
	// The vertex position is already in object space
	positionInObj = gl_Vertex;	
	
	// Transform the position, as is necessary for all vertex programs
	gl_Position = ftransform();	
}