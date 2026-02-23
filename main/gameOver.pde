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

//function to check for collision
void collisionCheck(){
for(int i=0; i < asteriodX.length; i++){
float distance = dist(mouseX, height-height/10, asteriodX[i], asteriodY[i]);
if( (distance < 62) && (shield == false)){
gameOver();
}
}
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
