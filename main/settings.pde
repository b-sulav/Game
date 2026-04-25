void setting() {
  background(0);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  // Title
  if (accent) fill(200, 200, 255); 
  else fill(255, 200, 200);
  textSize(width * 0.08);
  text("Settings", width * 0.5, height * 0.10);
  
  // Shadow
  if (accent) fill(150, 150, 255, 60);
  else fill(255, 150, 150, 60);
  textSize(width * 0.082);
  text("Settings", width * 0.5, height * 0.10);

  // Categories
  if (accent) fill(120, 120, 160);
  else fill(160, 120, 120);
  textSize(width * 0.02);
  text("Ship Skin", width * 0.28, height * 0.34);
  text("Background", width * 0.72, height * 0.34);
  text("Music", width * 0.28, height * 0.56);
  text("Accent Color", width * 0.72, height * 0.56);

  // Arrays
  String[] labels = { "Skin 1", "Skin 2", "BG 1", "BG 2", "On", "Off", "Blue", "Red", "Back" };
  float[] bX = { width * 0.19, width * 0.37, width * 0.63, width * 0.81, width * 0.19, width * 0.37, width * 0.63, width * 0.81, width * 0.5 };
  float[] bY = { height * 0.43, height * 0.43, height * 0.43, height * 0.43, height * 0.65, height * 0.65, height * 0.65, height * 0.65, height * 0.84 };

  for (int i = 0; i < 9; i++) {
    // Hovering
    boolean hover = (abs(mouseX - bX[i]) < width * 0.08 && abs(mouseY - bY[i]) < height * 0.055) ||
                    (i == 0 && skin) || (i == 1 && !skin) || 
                    (i == 2 && bg) || (i == 3 && !bg) || 
                    (i == 4 && music) || (i == 5 && !music) ||
                    (i == 6 && accent) || (i == 7 && !accent);
    
    // Background
    if (accent) fill(hover ? color(30, 30, 60) : color(10, 10, 30));
    else fill(hover ? color(60, 30, 30) : color(30, 10, 10));
    
    // Border
    if (accent) stroke(hover ? color(180, 180, 255) : color(100, 100, 180));
    else stroke(hover ? color(255, 180, 180) : color(180, 100, 100));
    strokeWeight(hover ? 2 : 1);
    rect(bX[i], bY[i], width * 0.16, height * 0.10, 5);
    
    // Text
    noStroke();
    if (accent) fill(hover ? color(220, 220, 255) : color(150, 150, 200));
    else fill(hover ? color(255, 220, 220) : color(200, 150, 150));
    textSize(height * 0.025);
    text(labels[i], bX[i], bY[i]);
  }

  // Effect
  stars();
}

void settingsMousePressed() {
  // Skin
  if (mouseX > width * 0.11 && mouseX < width * 0.27 && mouseY > height * 0.375 && mouseY < height * 0.485) skin = true;
  if (mouseX > width * 0.29 && mouseX < width * 0.45 && mouseY > height * 0.375 && mouseY < height * 0.485) skin = false;
  
  // Environment
  if (mouseX > width * 0.55 && mouseX < width * 0.71 && mouseY > height * 0.375 && mouseY < height * 0.485) bg = true;
  if (mouseX > width * 0.73 && mouseX < width * 0.89 && mouseY > height * 0.375 && mouseY < height * 0.485) bg = false;
  
  // Audio
  if (mouseX > width * 0.11 && mouseX < width * 0.27 && mouseY > height * 0.595 && mouseY < height * 0.705) { 
    music = true;
    if (!globalMute && !music1.isPlaying()) music1.loop(); 
  }
  if (mouseX > width * 0.29 && mouseX < width * 0.45 && mouseY > height * 0.595 && mouseY < height * 0.705) { 
    music = false;
    music1.stop(); 
  }
  
  // Theme
  if (mouseX > width * 0.55 && mouseX < width * 0.71 && mouseY > height * 0.595 && mouseY < height * 0.705) accent = true;
  if (mouseX > width * 0.73 && mouseX < width * 0.89 && mouseY > height * 0.595 && mouseY < height * 0.705) accent = false;
  
  // Exit
  if (mouseX > width * 0.42 && mouseX < width * 0.58 && mouseY > height * 0.785 && mouseY < height * 0.895) { currentState = GameState.HOME; }
}
