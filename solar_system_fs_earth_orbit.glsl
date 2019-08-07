#version 400

uniform sampler2D texture;
uniform vec4 lightPosition_ws; //light position in word space
uniform vec4 La;
uniform vec4 Ld;
uniform vec4 Ls;
uniform vec3 eye_pos;
uniform float Shininess;
uniform bool enable_texture; 


uniform vec4 Ka,Kd,Ks;

out vec4 fragcolor; 

in vec2 tex_coord;
in vec4 position_ws;
in vec3 nw_nn;
in vec3 pass_xyz_position;
//in vec3 lp_ws;

#define PI 3.141592653589793238462643383279

void main(void)
{   
	if(pass_xyz_position.x==0.0 && pass_xyz_position.y==0 && pass_xyz_position.z==0.0) discard;
	vec2 tc = tex_coord;
	tc.x = atan(pass_xyz_position.x, pass_xyz_position.z) / (2 * PI)+0.5;
	tc.y = 0.5 + atan(pass_xyz_position.y,length(pass_xyz_position.xz))/PI ; 
	//ambient lighting
    vec4 ambient = La * Ka; //ambient


	vec4 lw_nn = lightPosition_ws-position_ws; //light direction in world space not normalize
	float distance = length(lw_nn);

	vec3 lw = normalize(vec3(lw_nn));
	vec3 nw = normalize(nw_nn);
	
	float cos_angle = clamp(dot(nw,lw),0,1);
	vec4 diffuse = (cos_angle*Ld*Kd)/(distance*distance); //diffuse 


	//specular
	vec3 vw_nn = eye_pos.xyz - position_ws.xyz;
	vec3 vw = normalize(vw_nn);
	vec3 rw_nn = reflect(-lw, nw);
	vec3 rw = normalize(rw_nn);

	float cosAlpha = clamp( dot( vw,rw ), 0,1 );

	vec4 specular = Ks*Ls*pow(cosAlpha,Shininess)/(distance*distance);

	// discard the specular highlight if the light’s behind the vertex
	if (dot(nw,lw)<0.0)
	{
		specular = vec4(0.0,0.0,0.0,1.0);
	}
	
	vec4 objectcolor = vec4(0.0,0.7,0.0,1.0);
	//fragcolor = vec4((ambient+diffuse+specular).rgb,1.0);

	/*if (enable_texture == true)
	{
		fragcolor = vec4(((objectcolor * La) + (objectcolor * Ld * cos_angle / (distance*distance)) +  specular).rgb, 1.0);
	}
	else {

		fragcolor = vec4((ambient+diffuse+specular).rgb,1.0);
	}*/
	fragcolor = vec4(((objectcolor * La) + (objectcolor * Ld * cos_angle / (distance*distance)) +  specular).rgb, 1.0);
}



















