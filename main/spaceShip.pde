void spaceShip() {
  boolean shouldFireLaser = (keyPressed) && ((key == 'a') || (key == 'A')) && (laserUsable == true);

  translate(mouseX, height - (height * 0.1));
  noStroke();

  if (shouldFireLaser) {
    if (!laser && !globalMute) laser1.loop(); 
    laser = true;
    push();
    if (accent) stroke(100, 200, 255); 
    else stroke(255, 80, 80); 
    strokeWeight(3);
    line(0, -50, 0, -height); 
    pop();
  } else {
    if (laser) laser1.stop();
    laser = false;
  }

  float targetTilt = (mouseX - pmouseX) * 0.04;
  rotate(lerp(0, targetTilt, 0.35)); 
  float flicker = sin(frameCount * 0.3) * 5;

  color mainPart;
  color wingPart;
  color detailPart;
  color flameOuter;
  color flameInner;

  if (skin) {
    // Skin 1: 
    mainPart = color(235, 235, 240); 
    wingPart = color(235, 235, 240);   
    detailPart = color(45, 50, 70);
    flameOuter = color(255, 150, 0, 180);
    flameInner = color(255, 220, 50, 220);
  } else {
    // Skin 2: 
    mainPart = color(235, 235, 240); 
    wingPart = color(235, 235, 240);
    detailPart = color(45, 50, 70); 
    flameOuter = color(255, 150, 0, 180); 
    flameInner = color(255, 220, 50, 220);
  }

  fill(flameOuter);
  triangle(-10, 28, 10, 28, 0, 60 + flicker * 1.5);
  fill(flameInner);
  triangle(-5, 28, 5, 28, 0, 45 + flicker);

  fill(mainPart);
  if (skin) {
    //(Skin 1)
    beginShape();
    vertex(0, -50); 
    vertex(12, -10);
    vertex(12, 30); 
    vertex(-12, 30); 
    vertex(-12, -10); 
    endShape(CLOSE);
  } else {
    //(Skin 2)
    beginShape();
    vertex(0, -55); 
    vertex(15, -45);
    vertex(15, 30); 
    vertex(-15, 30); 
    vertex(-15, -45); 
    endShape(CLOSE);
  }

  fill(wingPart);
  if (skin) {
    // Interceptor Wings
    beginShape();
    vertex(-12, -5); 
    vertex(-40, 25); 
    vertex(-40, 35); 
    vertex(-12, 25); 
    endShape(CLOSE);
    
    beginShape();
    vertex(12, -5); 
    vertex(40, 25); 
    vertex(40, 35); 
    vertex(12, 25); 
    endShape(CLOSE);
  } else {
  
    beginShape();
    vertex(-15, 0); 
    vertex(-45, 10); 
    vertex(-45, 35); 
    vertex(-15, 35); 
    endShape(CLOSE);
    
    beginShape();
    vertex(15, 0); 
    vertex(45, 10); 
    vertex(45, 35); 
    vertex(15, 35); 
    endShape(CLOSE);
  }

  fill(flameInner); // Back to fire color
  rect(-38, 30, 4, 15, 2);
  rect(38, 30, 4, 15, 2);

  fill(detailPart); 
  if (skin) {

    beginShape();
    vertex(0, -30);
    vertex(8, -15);
    vertex(5, -5);
    vertex(-5, -5);
    vertex(-8, -15);
    endShape(CLOSE);
  } else {
  
    rect(-5, -42, 20, 10, 2);
  }

  if ((((mousePressed) || ((keyPressed) && ((key == 's') || (key == 'S')))) && (shieldUsable == true))) {
    if (!shield && !globalMute) shield1.loop();
    shield = true;
    push();
    noFill();
    stroke(accent ? color(100, 200, 255) : color(255, 80, 80), 150); 
    strokeWeight(2);
    ellipse(0, 0, 125 + sin(frameCount * 0.1) * 10, 135 + sin(frameCount * 0.1) * 10);
    pop();
  } else {
    if (shield) shield1.stop();
    shield = false;
  }

  if ((keyPressed) && ((key == 'd') || (key == 'D')) && (speedupUsable == true)) {
    if (!speedup && !globalMute) time1.loop();
    speedup = true;
    speed = 5; 
  } else {
    if (speedup) time1.stop();
    speedup = false;
    speed = baseSpeed;
  }
}
