import processing.sound.*;

SoundFile music;
float[]asteriodX;
float[]asteriodY;
float[]starX;
float[]starY;
float speed=15;
int score=0;
boolean shield;
int shieldPower=100;
boolean shieldUsable=true;
boolean play=false;
boolean clicked=false;
boolean sound=false;
boolean isMuted=false;

void setup(){
fullScreen();
textFont(createFont("horizon.otf",128));
music=new SoundFile(this,"bgSound.mp3");
music.loop();
music.amp(0.1);
music.rate(speed/25);
asteriodX=new float[8];
asteriodY=new float[8];
starX=new float[200];
starY=new float[200];
for(int i=0;i<asteriodX.length;i++){
asteriodX[i]=random(0,width);
asteriodY[i]=random(-height,0);
}
for(int i=0;i<starX.length;i++){
starX[i]=random(0,width);
starY[i]=random(0,height);
}
}

void draw(){
home();
stars();
if(play){
asteriod();
fill(255);
textSize(50);
textAlign(LEFT);
text(score,0,height*0.05);
fill(255);
textAlign(RIGHT);
text("Shield:"+shieldPower,width,height*0.05);
stars();
collisionCheck();
spaceShip();
shieldCheck();
score=score+1;
}
}
