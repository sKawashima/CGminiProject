void setup() {
	size(1024,576,P3D);
}

int roadLength = 3000;
float ball_x = 0;
float ball_x_acc = 0;
float ball_z = 0;
float ball_z_acc = 0;
float ball_speed = 0.2;

void draw() {
	calcBallPosition();

	if(keyPressed == true){
		if(key == 's'){
			ball_z_acc += ball_speed;
		}
		if(key == 'w'){
			ball_z_acc -= ball_speed;
		}
		if(key == 'd'){
			ball_x_acc += ball_speed;
		}
		if(key == 'a'){
			ball_x_acc -= ball_speed;
		}
	}

	background(240);
	translate(width/2,height/2,0);
	/*camera(0.0, 0.0, 300, // 視点X, 視点Y, 視点Z
	ball_x, 0.0, ball_z, // 中心点X, 中心点Y, 中心点Z
	0.0, 1.0, 0.0); // 天地X, 天地Y, 天地Z*/

	println("ball_z: "+ball_z);

	pushMatrix();
		translate(0, 100, /*-roadLength/2*/0);
		box(250,20,roadLength);
	popMatrix();
	pushMatrix();
		translate(ball_x, 70, ball_z);
		sphere(20);
	popMatrix();
}

void calcBallPosition(){
	ball_x += ball_x_acc;
	ball_z += ball_z_acc;
}

