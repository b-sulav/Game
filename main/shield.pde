//function to check shield cooldown
void shieldCheck(){
if((shield==true)&&(shieldPower>0)){
shieldPower=shieldPower-1;
}
else if((shield==false)&&(shieldPower<100)){
shieldPower=shieldPower+1;
}
else if(shieldPower==0){
shieldUsable=false;
}
else if(shieldPower==100){
shieldUsable=true;
}
}
