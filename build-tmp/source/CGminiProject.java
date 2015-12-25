import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CGminiProject extends PApplet {

public void setup() {
	
}

int roadLength = 3000;
float ball_x = 0;
float ball_x_acc = 0;
float ball_z = 0;
float ball_z_acc = 0;
float ball_speed = 0.2f;

public void draw() {
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
	/*camera(0.0, 0.0, 300, // \u8996\u70b9X, \u8996\u70b9Y, \u8996\u70b9Z
	ball_x, 0.0, ball_z, // \u4e2d\u5fc3\u70b9X, \u4e2d\u5fc3\u70b9Y, \u4e2d\u5fc3\u70b9Z
	0.0, 1.0, 0.0); // \u5929\u5730X, \u5929\u5730Y, \u5929\u5730Z*/

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

public void calcBallPosition(){
	ball_x += ball_x_acc;
	ball_z += ball_z_acc;
}

  public void settings() { 	size(1024,576,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CGminiProject" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
