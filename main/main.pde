//global variable declaration
float[] asteriodX;
float[] asteriodY;
float[] starX;
float[] starY;
float speed = 12;
int score = 0;
boolean shield;
int shieldPower = 100;
boolean shieldUsable = true;
boolean play = false;
boolean clicked = false;

void setup(){
fullScreen();
asteriodX = new float[8];
asteriodY = new float[8];
starX = new float[200];
starY = new float[200];
for(int i=0; i < asteriodX.length; i++){
asteriodX[i] = random(0,width);
asteriodY[i] = random(-height,0);
}
for(int i=0; i < starX.length; i++){
starX[i] = random(0,width);
starY[i] = random(0,height);
}
}

void draw(){
home();
stars();
if(play) {
asteriod();
fill(255,0,0);
textSize(50);
textAlign(LEFT);
text("Current Score: " + score, 0,height*0.05);
fill(0,255,0);
textAlign(RIGHT);
text("Shield: " + shieldPower, width,height*0.05);
stars();
collisionCheck();
spaceShip();
shieldCheck();
score = score + 1;
}
}
