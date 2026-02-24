//function to create home page
void home(){
background(0);
mute();
rectMode(CENTER);
textAlign(CENTER,CENTER);
push();
fill(255);
textSize(width*0.08);
text("Astro-Dodge",width*0.5,height*0.2);
pop();
push();
rect(width*0.5,height*0.50,width*0.25,height*0.12);
fill(0);
textSize(height*0.05);
text("Play",width*0.5,height*0.50);
fill(255);
rect(width*0.5,height*0.64,width*0.25,height*0.12);
fill(0);
text("Settings",width*0.5,height*0.64);
fill(255);
rect(width*0.5,height*0.78,width*0.25,height*0.12);
fill(0);
text("Exit",width*0.5,height*0.78);
fill(255);
pop();
}

void mousePressed(){
if(mouseX>width-70&&mouseX<width-10&&mouseY>height-50&&mouseY<height-10){
toggleMute();
}
if(!play){
if(mouseX>width*0.375&&mouseX<width*0.625&&mouseY>height*0.44&&mouseY<height*0.56){
click(0);
}
if(mouseX>width*0.375&&mouseX<width*0.625&&mouseY>height*0.58&&mouseY<height*0.70){
click(1);
}
if(mouseX>width*0.375&&mouseX<width*0.625&&mouseY>height*0.72&&mouseY<height*0.84){
click(2);
}
}
}

void click(int id){
clicked=true;
if(id==0)play=true;
if(id==1)background(0,255,0);
if(id==2)exit();
}
