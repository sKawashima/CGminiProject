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
		if(key == 'r'){
			//リセットの処理を追加する
			ball_x = 0;
			ball_z = 0;
			ball_x_acc = 0;
			ball_z_acc = 0;
		}
	}

	background(240);
	translate(width/2,height/2,0);
	camera(ball_x, 0, 300 + ball_z, // カメラの位置
	ball_x - ball_x_acc*3, 0.0, ball_z - ball_z_acc*3, // カメラが向く座標
	0.0, 1.0, 0.0); // カメラの回転

	calcBallPosition();

	setStage(1);

	//ボールの描写
	pushMatrix();
		translate(ball_x, 70, ball_z);
		rotateX(-ball_z/50);
		rotateZ(ball_x/50);
		sphere(20);
		println("ball_x: "+ball_x);
		println("ball_z: "+ball_z);
	popMatrix();
}

void calcBallPosition(){
	ball_x += ball_x_acc;
	ball_z += ball_z_acc;
}

void setStage(int stage_Num){
	pushMatrix();
	switch (stage_Num) {
		case 1:
			translate(0, 100, -roadLength/2+100);
			box(250,20,roadLength);
			break;
		default :
			break;
	}
	popMatrix();
}
