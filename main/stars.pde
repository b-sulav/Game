float shootX, shootY, shootAngle;
boolean shooting = false;

void stars() {
  if (currentState == GameState.PLAYING || currentState == GameState.DYING || currentState == GameState.HOME) {
    nebula();
  }
  // Loop
  for (int i = 0; i < starX.length; i++) {
    // Parallax logic
    float speed;
    float baseSize;
    color starColor;
    
    if (i % 25 == 0) { 
      speed = 6 + (i % 3);
      baseSize = 2.5;
      starColor = color(255, 255, 230);
    } else if (i % 3 == 0) {
      speed = 2.5 + (i % 2);
      baseSize = 1.5;
      starColor = (i % 2 == 0) ? color(220, 230, 255) : color(255); 
    } else { 
      speed = 0.5 + (i % 2) * 0.5;
      baseSize = 0.8;
      starColor = color(200, 200, 220, 150); 
    }

    float twinkle = sin(frameCount * 0.04 + i * 0.5) * 40 + 215;
    
    if (i % 25 == 0) {
      stroke(starColor, 60);
      strokeWeight(baseSize * 1.5);
      line(starX[i], starY[i], starX[i], starY[i] - speed * 4);
    }
    
    stroke(starColor, twinkle);
    strokeWeight(baseSize * 0.8);
    line(starX[i], starY[i], starX[i], starY[i] - speed * 2);
    
    starY[i] += speed;
    
    // Wrap around
    if (starY[i] > height) {
      starY[i] = random(-10, 0);
      starX[i] = random(0, width);
    }
  }

  if (frameCount % 300 == 0 && !shooting) {
    shootX = random(width * 0.1, width * 0.9);
    shootY = random(-50, height * 0.2);
    shootAngle = random(QUARTER_PI, HALF_PI + QUARTER_PI);
    shooting = true;
  }
  
  if (shooting) {
    for (int t = 0; t < 15; t++) {
      float alpha = map(t, 0, 15, 200, 0);
      float tx = shootX - cos(shootAngle) * t * 8;
      float ty = shootY - sin(shootAngle) * t * 8;
      
      // Render trail with cyan tint
      stroke(180, 230, 255, alpha);
      strokeWeight(map(t, 0, 15, 2.5, 0.5));
      point(tx, ty);
    }

    shootX += cos(shootAngle) * 12;
    shootY += sin(shootAngle) * 12;
    if (shootX < -100 || shootX > width + 100 || shootY > height + 100) shooting = false;
  }
}

void nebula() {
  pushStyle();
  pushMatrix();
  noStroke();
  blendMode(ADD); // Makes colors pop
  
  for (int i = 0; i < 3; i++) {
    float x = noise(frameCount * 0.005 + i * 100) * width;
    float y = noise(frameCount * 0.003 + i * 500) * height;
    float size = 400 + noise(frameCount * 0.01 + i) * 300;

    fill(255, i == 0 ? 7 : 4);
    
    ellipse(x, y, size * 2, size);
  }
  blendMode(BLEND);
  popMatrix();
  popStyle();
}
