void gameOver() {
  background(10);
  stars(); 
  
  if (!dataSaved) {
    saveGameData(score);
    dataSaved = true;
  }
  
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  
  float panelW = width * 0.6;
  float panelH = height * 0.6;
  float pX = width / 2;
  float pY = height / 2;

  push();
  noFill();
  for (int i = 0; i < 10; i++) {
    if (accent) stroke(80, 80, 255, 20 - i*2);
    else stroke(255, 80, 80, 20 - i*2);
    strokeWeight(i * 2);
    rect(pX, pY, panelW + i, panelH + i, 20);
  }
  pop();

  fill(20, 20, 30, 200);
  if (accent) stroke(100, 100, 255, 150);
  else stroke(255, 100, 100, 150);
  strokeWeight(2);
  rect(pX, pY, panelW, panelH, 20);
  
  float pulse = sin(frameCount * 0.05) * 5;
  textSize((width + height) / 22 + pulse);
  if (accent) {
    fill(100, 100, 255, 100);
    text("GAME OVER", pX + 3, pY - panelH * 0.3 + 3);
    fill(200, 200, 255);
  } else {
    fill(255, 100, 100, 100);
    text("GAME OVER", pX + 3, pY - panelH * 0.3 + 3);
    fill(255, 200, 200);
  }
  text("GAME OVER", pX, pY - panelH * 0.3);

  push();
  if (accent) stroke(100, 100, 255, 80);
  else stroke(255, 100, 100, 80);
  line(pX, pY - panelH * 0.1, pX, pY + panelH * 0.15);
  pop();
  
  // Your Score
  textSize(width * 0.015);
  fill(180);
  text("YOUR SCORE", pX - panelW * 0.25, pY - panelH * 0.05);
  textSize(width * 0.035);
  fill(255);
  text(score, pX - panelW * 0.25, pY + panelH * 0.08);
  
  // High Score
  textSize(width * 0.015);
  fill(180);
  text("HIGH SCORE", pX + panelW * 0.25, pY - panelH * 0.05);
  textSize(width * 0.035);
  if (accent) fill(100, 200, 255);
  else fill(255, 80, 80);
  text(highscore, pX + panelW * 0.25, pY + panelH * 0.08);
  
  cursor();
  float bY = pY + panelH * 0.32;
  float bW = panelW * 0.3;
  float bH = height * 0.07;
  
  // Play Again Button
  float baX = pX - panelW * 0.2;
  boolean baHover = abs(mouseX - baX) < bW/2 && abs(mouseY - bY) < bH/2;
  drawGOButton(baX, bY, bW, bH, "Play Again", baHover);
  
  // Main Menu Button
  float mmX = pX + panelW * 0.2;
  boolean mmHover = abs(mouseX - mmX) < bW/2 && abs(mouseY - bY) < bH/2;
  drawGOButton(mmX, bY, bW, bH, "Main Menu", mmHover);

  speed = 10;
  baseSpeed = 10;
  music1.rate(1.0);
}

void drawGOButton(float x, float y, float w, float h, String txt, boolean hover) {
  push();
  if (accent) {
    fill(hover ? color(40, 40, 80) : color(15, 15, 40));
    stroke(hover ? color(180, 180, 255) : color(100, 100, 180));
  } else {
    fill(hover ? color(80, 40, 40) : color(40, 15, 15));
    stroke(hover ? color(255, 180, 180) : color(180, 100, 100));
  }
  strokeWeight(hover ? 2.5 : 1.5);
  rect(x, y, w, h, 10);
  
  noStroke();
  if (accent) fill(hover ? 255 : 200);
  else fill(hover ? 255 : 200);
  textSize(h * 0.4);
  text(txt, x, y - 2);
  pop();
}
