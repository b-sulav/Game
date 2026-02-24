//function to control music mute and unmute
void mute(){
rectMode(CORNER);
noStroke();
textSize(10);
if(isMuted){
fill(255,0,0);
rect(width-70,height-50,60,40,10);
}
else {
fill(255,255,255,50);
rect(width-70,height-50,60,40,10);
}
fill(255);
text("Mute",width-40,height-30);
}


void toggleMute(){
isMuted=!isMuted;
if(isMuted){
music.amp(0);
}else{
music.amp(0.5);
}
}
