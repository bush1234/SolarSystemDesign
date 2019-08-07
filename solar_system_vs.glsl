#version 400            
uniform mat4 PVM;
uniform float time;

uniform mat4 M;
uniform mat4 V;
uniform mat4 P;

in vec3 pos_attrib;
in vec2 tex_coord_attrib;
in vec3 normal_attrib;

out vec2 tex_coord;
out vec4 position_ws;
out vec3 nw_nn;
out vec3 pass_xyz_position;
//out vec3 lp_ws;

//animate sun
uniform float slider_anim; 

void main(void)
{
   vec3 anim = vec3( slider_anim*sin(pos_attrib.x + time),0.0, 0.0);
   //gl_Position = PVM * vec4(pos_attrib, 1.0); 
   gl_Position = PVM*vec4(pos_attrib + anim, 1.0);
   position_ws = M*vec4(pos_attrib,1.0);
   pass_xyz_position = (pos_attrib).xyz;

   nw_nn = mat3(M)*normal_attrib; // normal in world space not normalized
   
   //vec4 texCoords = vec4(pos_attrib, 1.0);
   tex_coord = tex_coord_attrib;
   //tex_coord.x = atan(normal_attrib.z/normal_attrib.x) / (2.0 * 3.1415926) + 0.5;
   //tex_coord.y = 0.5 - asin(normal_attrib.y) / 3.1415926;
	//tex_coord.x = asin(normal_attrib.x)/3.1415926 + 0.5;
	//tex_coord.y = asin(normal_attrib.y)/3.1415926 + 0.5;
   //if(tex_coord.x < 0.1) tex_coord.x = 1.0;
    //tex_coord = vec2((atan(texCoords.y, texCoords.x) / 3.1415926 + 1.0) * 0.5,
   //                               (asin(texCoords.z) / 3.1415926 + 0.5));
   

   //animate sun 
    //test 
   //vec3 anim = vec3( slider_anim*sin(pos_attrib.x + time),0.0, 0.0);
   //gl_Position = PVM*vec4(pos_attrib + anim, 1.0);
   //tex_coord = tex_coord_attrib;

   
   //lp_ws = lightPosition_ws;
   //distance = length(lightposition_ws-position_ws.xyz);

	//float x = pos_attrib.x;
	//float y = pos_attrib.y;

	//float r = sqrt(x * x + y * y );

	//float d = r ? asin(r) / r : 0.0;
	//float d;
	//if(r>0)
		//d = asin(r)/r;
	//else 
		//d = 0.0;
	//float x2 = d * x;
	//float y2 = d * y;

	
	//float PI = 3.1415926;
	//tex_coord.x = x2/(4.0*pi)+0.5;
	//tex_coord.y = y2/(2*pi)+0.5;
	//tex_coord.x = mod(x2 / (4.0 * pi) + 0.5, 1.0f);
	//tex_coord.y = y2 / (2.0 * pi) + 0.5;

	//float r = length(pos_attrib);
    //float theta = acos(pos_attrib.z/r);
	//float theta = atan(length(pos_attrib.xy), pos_attrib.z);
    //float phi   = atan(pos_attrib.y/pos_attrib.x);
 
    //tex_coord.x = clamp(0.5 + phi/(2.0*PI), 0.0, 1.0);
    //tex_coord.y = clamp(theta/PI, 0.0, 1.0);
}