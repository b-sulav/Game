//global variable declaration
float[] asteriodX;
float[] asteriodY;
float[] originalY;
float speed = 10;
int score = 0;
boolean shield;

void setup(){
  size(1000,1000);
  asteriodX = new float[8];
  asteriodY = new float[8];
  originalY = new float[8];
  for(int i=0; i < asteriodX.length; i++){
    asteriodX[i] = random(0,width);
    asteriodY[i] = random(-height,0);
    originalY[i] = asteriodY[i];
  }
}

void draw(){
  background(0);
  fill(255);
  textSize(50);
  text("Score: " + score, width*0.01,height*0.05);
  stars();
  asteriod();
  check();
  spaceShip();
  
}

//function to create asteriods
void asteriod(){
  for(int i=0; i < asteriodX.length; i++){
    fill(135);
    circle(asteriodX[i],asteriodY[i],60);
    if(asteriodY[i] > height){
      asteriodY[i] = originalY[i];
      asteriodX[i] = random(0,width);
      score = score + 1;
      
    }
    else{
      asteriodY[i] = asteriodY[i] + speed;
    }
  }
}

//function to create background stars
void stars() {
  for (int i = 0; i < (height+width)/50; i++) {
    stroke(255);
    point(random(0,width), random(0,height));
  }
}

//function to create spaceship
void spaceShip(){
  translate(mouseX, height-height/10);
  fill(255,255,255);
  beginShape();
    vertex(0, -50); 
    vertex(10, -15);  
    vertex(30, 15);  
    vertex(10, 15);  
    vertex(5, 35);  
    vertex(-5, 35);  
    vertex(-10, 15);  
    vertex(-30, 15);  
    vertex(-10, -15); 
    endShape(CLOSE);
    fill(135);
    ellipse(0,-5,10,15);
    if ((mousePressed) || (keyPressed) && (key == ' ')) {
      shield = true;
      push();
      noFill();
      stroke(135);
      strokeWeight(random(1,4));
      ellipse(0,0,120,130);
      pop();
      fill(255, 100, 0);
      triangle(-5, 40, 5, 40, 0, 60);
      speed =  20;
    }
    else {
      shield = false;
      speed = 10;
    }
}

//function to check for collision
void check(){
  for(int i=0; i < asteriodX.length; i++){
    float distance = dist(mouseX, height-height/10, asteriodX[i], asteriodY[i]);
    if( (distance < 62) && (shield == false)){
      gameOver();
    }
  }
}

//function to end game when collision occurs
void gameOver(){
background(136,8,8);
push();
fill(255);
textSize((height+width)/15);
textAlign(CENTER);
text("Game Over", width/2, height*0.2);
pop();
push();
fill(255);
textSize((height+width)/25);
textAlign(CENTER);
text("Your Score: "+score, width/2, height/2);
pop();
push();
fill(0);
textSize((height+width)/40);
textAlign(CENTER);
text("Press 'Enter' to play again", width/2, height/1.8);
pop();
score = 0;
noLoop();
}

void keyPressed(){
  if ((key == ENTER)|| (key == RETURN)){
    loop();
    for(int i=0; i < asteriodX.length; i++){
    asteriodY[i] = originalY[i];
    asteriodX[i] = random(0,width);
    }
  }
}
