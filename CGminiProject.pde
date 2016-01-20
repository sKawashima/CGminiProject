void setup() {
	gameover();
	size(1024,576,P3D);
	reset();
}

int roadLength;
int roadWidth;
float ball_x = 0;
float ball_y = 70;
float ball_z = 0;
float ball_x_acc = 0;
float ball_y_acc = 0;
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
			reset();
		}
	}

	background(240);
	pushMatrix();//--------------------------------------------------------
	translate(width/2,height/2,0);
	camera(ball_x, ball_y - 70, 300 + ball_z, // カメラの位置
	ball_x - ball_x_acc*3, 0.0, ball_z - ball_z_acc*3, // カメラが向く座標
	0.0, 1.0, 0.0); // カメラの回転

	calcBallPosition();

	setStage(1);

	//ボールの描写
	pushMatrix();
		fill(255);
		translate(ball_x, ball_y, ball_z);
		rotateX(-ball_z/50);
		rotateZ(ball_x/50);
		sphere(20);
		/*
		println("ball_x: "+ball_x);
		println("ball_y: "+ball_y);
		println("ball_z: "+ball_z);
		*/
	popMatrix();
	popMatrix();//--------------------------------------------------------
	checkBall(1);
}

void calcBallPosition(){
	ball_x += ball_x_acc;
	ball_y += ball_y_acc;
	ball_z += ball_z_acc;
}

void setStage(int stage_Num){
	fill(255);
	pushMatrix();
	switch (stage_Num) {
		case 1:
			roadLength = 3000;
			roadWidth = 250;
			pushMatrix();
			translate(0, 100, -roadLength/2+100);
			box(roadWidth,20,roadLength);
			popMatrix();
			fill(0);
			translate(0, 0, -roadLength + 100);
			box(roadWidth,200,50);
			break;
		default :
			break;
	}
	popMatrix();
	noFill();
}

void checkBall(int stage_Num){
	switch (stage_Num) {
		case 1:
			if(abs(ball_x) > roadWidth / 2) gameover();
			else if(ball_z > 100) gameover();
			break;
		default :
			break;
	}
}

void gameover(){
	ball_y_acc += ball_speed;
	fill(0);
	textSize(48);
	textAlign(CENTER);
	text("Game Over", width / 2, height / 2, 0);
	textSize(32);
	text("push R key", width / 2, height / 2 + 100, 0);
	noFill();
}

void reset(){
	ball_x = 0;
	ball_y = 70;
	ball_z = 0;
	ball_x_acc = 0;
	ball_y_acc = 0;
	ball_z_acc = 0;
}