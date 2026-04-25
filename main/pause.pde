void pauseScreen() {
  background(10);
  stars();
  
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  
  float panelW = width * 0.5;
  float panelH = height * 0.4;
  float pX = width / 2;
  float pY = height / 2;
  
  push();
  noFill();
  for (int i = 0; i < 8; i++) {
    if (accent) stroke(80, 80, 255, 15 - i*2);
    else stroke(255, 80, 80, 15 - i*2);
    strokeWeight(i * 2);
    rect(pX, pY, panelW + i, panelH + i, 20);
  }
  pop();
  
  // Panel Background
  fill(20, 20, 30, 220);
  if (accent) stroke(100, 100, 255, 150);
  else stroke(255, 100, 100, 150);
  strokeWeight(2);
  rect(pX, pY, panelW, panelH, 20);
  
  // 2. Animated Heading
  float pulse = sin(frameCount * 0.05) * 3;
  textSize((width + height) / 25 + pulse);
  if (accent) {
    fill(100, 100, 255, 100);
    text("PAUSED", pX + 3, pY - panelH * 0.2 + 3);
    fill(200, 200, 255);
  } else {
    fill(255, 100, 100, 100);
    text("PAUSED", pX + 3, pY - panelH * 0.2 + 3);
    fill(255, 200, 200);
  }
  text("PAUSED", pX, pY - panelH * 0.2);
  
  cursor();
  float bY = pY + panelH * 0.2;
  float bW = panelW * 0.35;
  float bH = height * 0.07;
  
  // Resume Button
  float rX = pX - panelW * 0.22;
  boolean rHover = abs(mouseX - rX) < bW/2 && abs(mouseY - bY) < bH/2;
  drawGOButton(rX, bY, bW, bH, "Resume", rHover); // Using the helper from gameOver.pde if accessible
  
  // Main Menu Button
  float mmX = pX + panelW * 0.22;
  boolean mmHover = abs(mouseX - mmX) < bW/2 && abs(mouseY - bY) < bH/2;
  drawGOButton(mmX, bY, bW, bH, "Main Menu", mmHover);
}
