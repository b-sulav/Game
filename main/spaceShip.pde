//function to create spaceship
void spaceShip(){
if(keyPressed){
translate(mouseX,height-height/10);
}
else{
translate(mouseX,height-height/10);
}
fill(255,255,255);
beginShape();
vertex(0,-50);
vertex(10,-15);
vertex(30,15);
vertex(10,15);
vertex(5,35);
vertex(-5,35);
vertex(-10,15);
vertex(-30,15);
vertex(-10,-15);
endShape(CLOSE);
fill(135);
ellipse(0,-5,10,15);
if (((mousePressed)||(keyPressed)&&(key==' '))&&(shieldUsable==true)){
shield=true;
push();
noFill();
stroke(135);
strokeWeight(random(1,4));
ellipse(0,0,120,130);
pop();
fill(255,100,0);
triangle(-5,40,5,40,0,60);
}
else{
shield=false;
}
}
