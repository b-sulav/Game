void home() {
  background(8, 8, 15);
  stars();

  textAlign(CENTER, CENTER);
  float tagX = width * 0.5;
  float tagY = height * 0.35;
  
  float pulse = sin(frameCount * 0.02) * 0.5;
  for (int g = 4; g > 0; g--) {
    if (accent) fill(80, 100, 255, 10 - g * 2);
    else fill(255, 80, 80, 10 - g * 2);
    textSize(width * 0.08 + g * 3);
    text("ASTRO-DODGE", tagX, tagY + g);
  }

  // Main Title
  textSize(width * 0.08 + pulse);
  fill(255);
  text("ASTRO-DODGE", tagX, tagY);

  // Subtitle
  textSize(width * 0.015);
  if (accent) fill(150, 180, 255, 200);
  else fill(255, 150, 150, 200);
  text("Dodge the Asteroids and Survive!", tagX, tagY + height * 0.08);

  cursor();
  String[] labels  = { "START MISSION", "SETTINGS", "EXIT SECTOR" };
  float bW = width * 0.25;
  float bH = height * 0.08;
  float bX = width * 0.5;
  float bStartY = height * 0.60;
  float bGap = bH + 20;

  for (int i = 0; i < 3; i++) {
    float by = bStartY + i * bGap;
    boolean hov = abs(mouseX - bX) < bW/2 && abs(mouseY - by) < bH/2;

    push();
    rectMode(CENTER);

    // Button body
    fill(hov ? color(255, 15) : color(255, 5));
    if (accent) stroke(100, 150, 255, hov ? 200 : 50);
    else stroke(255, 100, 100, hov ? 200 : 50);
    strokeWeight(1);
    rect(bX, by, bW, bH, 5);

    if (hov) {
      if (accent) fill(100, 150, 255);
      else fill(255, 100, 100);
      noStroke();
      rect(bX - bW/2 + 2, by, 4, bH * 0.5);
      rect(bX + bW/2 - 2, by, 4, bH * 0.5);
    }

    // Button text
    if (accent) fill(hov ? 255 : color(180, 200, 255));
    else fill(hov ? 255 : color(255, 180, 180));
    textSize(bH * 0.35);
    textAlign(CENTER, CENTER);
    text(labels[i], bX, by - 2);
    pop();
  }
}
