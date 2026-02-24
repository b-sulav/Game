//function to create background stars
void stars(){
for(int i=0;i<starX.length;i++){
stroke(255);
point(starX[i],starY[i]);
if(starY[i]>height){
starY[i]=random(-height/2,0);
starX[i]=random(0,width);
}
else{
starY[i]=starY[i]+speed/10;
}
}
}
