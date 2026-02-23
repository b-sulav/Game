void home(){
background(0);
rectMode(CENTER);
textAlign(CENTER, CENTER);
fill(255);
textSize(width * 0.14);
text("Astro Dodge",width*0.5,height*0.15);
fill(255);
rect(width * 0.5, height * 0.45, width * 0.25, height * 0.12);
fill(0);
textSize(height * 0.06);
text("Play", width * 0.5, height * 0.45);
fill(255);
rect(width * 0.5, height * 0.59, width * 0.25, height * 0.12);
fill(0);
text("Mode", width * 0.5, height * 0.59);
fill(255);
rect(width * 0.5, height * 0.73, width * 0.25, height * 0.12);
fill(0);
text("Settings", width * 0.5, height * 0.73);
fill(255);
rect(width * 0.5, height * 0.87, width * 0.25, height * 0.12);
fill(0);
text("Exit", width * 0.5, height * 0.87);
}
void mousePressed() {
if(!play){
if (mouseX > width*0.375 && mouseX < width*0.625 && mouseY > height*0.39 && mouseY < height*0.51) {
  click(0);
}
 
if (mouseX > width*0.375 && mouseX < width*0.625 && mouseY > height*0.53 && mouseY < height*0.65) {
  click(1);
}

if (mouseX > width*0.375 && mouseX < width*0.625 && mouseY > height*0.67 && mouseY < height*0.79) {
  click(2);
}

if (mouseX > width*0.375 && mouseX < width*0.625 && mouseY > height*0.81 && mouseY < height*0.93) {
  click(3);
}
}
}


void click(int id) {
clicked = true;
if (id == 0) play = true;
if (id == 1) background(0,255,0);
if (id == 2) background(0,0,255);
if (id == 3) exit();
}
