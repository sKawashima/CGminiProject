void setup() {
	gameover();
	size(1024,576,P3D);
	reset();
}

int roadLength;
int roadWidth;
int gateHeight = 200;
float ball_x = 0;
float ball_y = 70;
float ball_z = 0;
float ball_x_acc = 0;
float ball_y_acc = 0;
float ball_z_acc = 0;
float ball_speed = 0.2;
int stage = 1;
boolean stageclear = false;

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
	}

	background(240);
	pushMatrix();//--------------------------------------------------------
	translate(width/2,height/2,0);
	camera(ball_x, ball_y - 70, 300 + ball_z, // カメラの位置
	ball_x - ball_x_acc*3, 0.0, ball_z - ball_z_acc*3, // カメラが向く座標
	0.0, 1.0, 0.0); // カメラの回転

	setStage(stage);

	//ボールの描写
	pushMatrix();
	fill(255);
	translate(ball_x, ball_y, ball_z);
	rotateX(-ball_z/50);
	rotateZ(ball_x/50);
	if(stageclear == false) sphere(20);
	/*
	println("ball_x: "+ball_x);
	println("ball_y: "+ball_y);
	println("ball_z: "+ball_z);
	*/
	popMatrix();
	popMatrix();//--------------------------------------------------------
	checkBall(stage);
	calcBallPosition();
}

void keyPressed(){
	if(key == 'r'){
		stage = 1;
		reset();
	}
	if(key == 'n'){
		stage++;
		println("stage: "+stage);
		reset();
	}
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
			setStageBase(3000,250);
			break;
		case 2:
			setStageBase(3000,500);
			fill(240);
			setblock(-150, -1300, 300, 1100, 1);
			break;
		case 3:
		setStageBase(3000,500);
			fill(240);
			setblock(-250, -1100, 300, 900, 1);
			setblock(-50, -2300, 300, 900, 1);
			setblock(-250, -2900, 300, 200, 1);
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
			break;
		case 2:
			chkblock(-180, -1300, 360, 1100, 1);
			break;
		case 3:
			chkblock(-250, -1100, 300, 900, 1);
			chkblock(-50, -2300, 300, 900, 1);
			chkblock(-250, -2900, 300, 200, 1);
			break;
		default :
			break;
	}
	if(abs(ball_x) > roadWidth / 2 || ball_z > 100 || ball_y != 70) gameover();
	else if(ball_z < -roadLength +101 && ball_y == 70) gameclear();
}

void setStageBase(int thisRoadLength, int thisRoadWidth){
	roadLength = thisRoadLength;
	roadWidth = thisRoadWidth;
	pushMatrix();
	translate(0, 100, -roadLength/2+100);
	box(roadWidth,20,roadLength);
	popMatrix();
	pushMatrix();
	fill(0);
	translate(0, 0, -roadLength + 100);
	box(roadWidth,gateHeight,50);
	popMatrix();
}

void setblock(int x, int z, int thisWidth, int thisLength, int height){
	pushMatrix();
	translate(x + thisWidth / 2, -height / 2 + 90, z + thisLength / 2);
	box(thisWidth, height, thisLength);
	popMatrix();
}

void chkblock(int x, int z, int thisWidth, int thisLength, int dec){
	//dec
	//1: 落下
	switch (dec) {
		case 1:
			if(ball_x > x + 40 && ball_x < x + thisWidth - 40 && ball_z > z && ball_z < z + thisLength){
				gameover();
				ball_y_acc += 3;
			}
			break;
		default :
			break;
	}
}

void gameclear(){
	stageclear = true;
	ball_z = -roadLength+100;
	ball_x_acc /= 5;
	ball_x -= ball_x / 10;
	gateHeight /= 1.1;
	fill(0);
	textSize(48);
	textAlign(CENTER);
	pushMatrix();
	translate(0, 0, 100);
	if(stage == 3){
		text("Game All Clear!", width / 2, height / 2, 0);
	}else{
		text("Game Clear!", width / 2, height / 2, 0);
	}
	textSize(32);
	if(stage == 3){
		text("push R key to Reset.", width / 2, height / 2 + 100, 0);
	}else{
		text("push N key to next Stage!!", width / 2, height / 2 + 100, 0);
	}
	popMatrix();
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
	stageclear = false;
	gateHeight = 200;
	ball_x = 0;
	ball_y = 70;
	ball_z = 0;
	ball_x_acc = 0;
	ball_y_acc = 0;
	ball_z_acc = 0;
}