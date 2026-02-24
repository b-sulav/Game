//function to create asteriods
void asteriod(){
background(0);
for(int i=0;i<asteriodX.length;i++){
fill(135);
circle(asteriodX[i],asteriodY[i],60);
if(asteriodY[i]>height){
asteriodY[i]=random(-height/2,0);
asteriodX[i]=random(0,width);
speed=speed+0.05;
}
else{
asteriodY[i]=asteriodY[i]+speed;
}
}
}
