float[] asteriodX;
float[] asteriodY;
float[] originalY;
float speed = 10;

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
  stars();
  asteriod();
}

//function to create asteriods
void asteriod(){
  for(int i=0; i < asteriodX.length; i++){
    fill(135);
    circle(asteriodX[i],asteriodY[i],80);
    if(asteriodY[i] > height){
      asteriodY[i] = originalY[i];
      asteriodX[i] = random(0,width);
    }
    else{
      asteriodY[i] = asteriodY[i] + speed;
    }
  }
}

void stars(){
  float x = width;
  float n = x;
  float y = height;
  for(int j = 0; j < height/5; j++){
  for(int i = 0; i < width/5; i++) {
  fill(255);
  circle(x, y, 4);
  x = x - 40;
  }
  x = n;
  y = y - 40;
  }
}
