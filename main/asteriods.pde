void asteroid() {
  if (bg) background(bg1);
  else background(bg2);
  
  for (int i = 0; i < asteroidX.length; i++) {
    noStroke();
    pushMatrix();
    translate(asteroidX[i], asteroidY[i]);
    asteroidRot[i] += asteroidRotSpeed[i];
    rotate(asteroidRot[i]);
    randomSeed(i * 100);
    
    // Properties
    float s = asteroidR[i];
    int sides = (int)random(6, 12);
    
    // Shadow
    fill(80);
    beginShape();
    for (int j = 0; j < sides; j++) {
      float angle = TWO_PI / sides * j + random(-0.4, 0.4);
      float r = s * random(0.5, 1.4);
      vertex(cos(angle) * r + 2, sin(angle) * r + 2);
    }
    endShape(CLOSE);
    
    // Body
    fill(135);
    beginShape();
    for (int j = 0; j < sides; j++) {
      float angle = TWO_PI / sides * j + random(-0.4, 0.4);
      float r = s * random(0.5, 1.4);
      vertex(cos(angle) * r, sin(angle) * r);
    }
    endShape(CLOSE);
    
    // Craters
    fill(100);
    circle(s * 0.2, -s * 0.2, s * 0.3);
    circle(-s * 0.3, s * 0.2, s * 0.2);
    circle(s * 0.1, s * 0.4, s * 0.15);
    
    popMatrix();
    
    // Respawn Logic - Reset seed to ensure random respawn positions
    randomSeed(millis() + i); 
    
    if (asteroidY[i] > height + height * 0.1) {
      asteroidY[i] = random(-height / 2, 0);
      asteroidX[i] = random(0, width);
      asteroidR[i] = random(30, 60);
      asteroidRotSpeed[i] = random(-0.05, 0.05);
      baseSpeed = min(baseSpeed + 0.1, 30.0);
    } else {
      asteroidY[i] = asteroidY[i] + speed;
    }
  }
}
