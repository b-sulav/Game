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

void setup(){
size(100,100);
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
background(0);
fill(255,0,0);
textSize(50);
text("Current Score: " + score, width*0.01,height*0.05);
fill(0,255,0);
text("Shield: " + shieldPower, width*0.01,height*0.98);
stars();
asteriod();
collisionCheck();
spaceShip();
shieldCheck();
score = score + 1;
}

//function to create background stars
void stars() {
for (int i = 0; i < starX.length; i++) {
stroke(255);
point(starX[i],starY[i]);
if(starY[i] > height){
starY[i] = random(-height/2,0);
starX[i] = random(0,width);
}
else{
starY[i] = starY[i] + speed/10;
}
}
}

//function to create spaceship
void spaceShip(){
if(keyPressed){
translate(mouseX,height-height/10);
}
else{
translate(mouseX, height-height/10);
}
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
if (((mousePressed) || (keyPressed) && (key == ' ')) && (shieldUsable == true)){
shield = true;
push();
noFill();
stroke(135);
strokeWeight(random(1,4));
ellipse(0,0,120,130);
pop();
fill(255, 100, 0);
triangle(-5, 40, 5, 40, 0, 60);
}
else {
shield = false;
}
}

//function to create asteriods
void asteriod(){
for(int i=0; i < asteriodX.length; i++){
fill(135);
circle(asteriodX[i],asteriodY[i],60);
if(asteriodY[i] > height){
asteriodY[i] = random(-height/2, 0);
asteriodX[i] = random(0,width);
speed = speed + 0.001;
}
else{
asteriodY[i] = asteriodY[i] + speed;
}
}
}

//function to check for collision
void collisionCheck(){
for(int i=0; i < asteriodX.length; i++){
float distance = dist(mouseX, height-height/10, asteriodX[i], asteriodY[i]);
if( (distance < 62) && (shield == false)){
//gameover();//
}
}
}
//function to check shield cooldown
void shieldCheck(){
if((shield == true) && (shieldPower > 0)){
shieldPower = shieldPower - 1;
}
else if((shield == false) && (shieldPower < 100)) {
shieldPower = shieldPower + 1;
}
else if(shieldPower == 0){
shieldUsable = false;
}
else if (shieldPower == 100){
shieldUsable = true;
}
}

//function to end game when collision occurs
void gameOver(){
background(136,8,8);
push();
fill(255);
textSize((height+width)/15);
textAlign(CENTER);
text("Your Score: "+score, width/2, height/2);
pop();
push();
fill(0);
textSize((height+width)/40);
textAlign(CENTER);
text("Press 'Enter' to play again", width/2, height*0.95);
pop();
score = 0;
shieldPower = 100;
speed = 10;
noLoop();
}

void keyPressed(){
if ((key == ENTER)|| (key == RETURN)){
loop();
for(int i=0; i < asteriodX.length; i++){
asteriodY[i] = random(-height/2,0);
asteriodX[i] = random(0,width);
}
}
}
