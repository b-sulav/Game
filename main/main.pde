float[] asteriodX;
float[] asteriodY;
float[] originalY;
float speed = 10;

void setup(){
  size(1000,1000);

  asteriodX = new float[6];
  asteriodY = new float[6];
  originalY = new float[6];

 for(int i=0; i < asteriodX.length; i++){
  asteriodX[i] = random(0,width);
  asteriodY[i] = random(-height,0);
  originalY[i] = asteriodY[i];
  }
}

void draw(){
  background(0);
  asteriod();
}

//function to create asteriods
void asteriod(){
  for(int i=0; i < asteriodX.length; i++){
    circle(asteriodX[i],asteriodY[i],80);
    if(asteriodY[i] > height){
      asteriodY[i] = originalY[i];
    }
    else{
      asteriodY[i] = asteriodY[i] + speed;
    }
  }
}
