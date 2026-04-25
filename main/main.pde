 import processing.sound.*;

SoundFile music1, laser1, shield1, time1, gameover;
PImage bg1, bg2;

// Settings
boolean bg = true;
boolean accent = true;
boolean skin = true;
boolean music = true;
boolean globalMute = false;

// Arrays
float[] asteroidX;
float[] asteroidY;
float[] asteroidR;
float[] asteroidRot;
float[] asteroidRotSpeed;
float[] starX;
float[] starY;

// Game
float speed = 10;
float baseSpeed = 10;
float shake = 0;
float camX = 0;
int score;
int highscore;
String fileName = "data/save.json";

// Particle System
float[] px = new float[100];
float[] py = new float[100];
float[] pvx = new float[100];
float[] pvy = new float[100];
float[] plife = new float[100];
color[] pcol = new color[100];

// Shield
float shieldPower = 100;
boolean shieldUsable = true;
boolean shield;

// Speed
boolean speedupUsable = true;
boolean speedup;
float speedupPower = 100;

// Laser
boolean laser;
float laserPower = 100;
boolean laserUsable = true;

// States
enum GameState {
  HOME,
  SETTINGS,
  PLAYING,
  GAMEOVER,
  PAUSED,
  DYING
}

GameState currentState = GameState.HOME;
int deathTimer = 0;
boolean dataSaved = false;

void settings(){
  fullScreen(); 
}
void setup() {
  surface.setResizable(false);
  surface.setTitle("Astro-Dodge");
  textFont(createFont("horizon.otf", 128));
  loadGameData();
  
  // Backgrounds
  bg1 = loadImage("background.jpg");
  bg1.resize(width, height);
  bg2 = loadImage("background2.jpg");
  bg2.resize(width, height);

  // Audio
  music1 = new SoundFile(this, "bgSound1.mp3");
  laser1 = new SoundFile(this, "lasersound.mp3");
  shield1 = new SoundFile(this, "shieldsound.mp3");
  time1 = new SoundFile(this, "timesound.mp3");
  gameover = new SoundFile(this, "gameover.mp3");
  if (music && !globalMute) music1.loop();

  // Initialization
  asteroidX = new float[8];
  asteroidY = new float[8];
  asteroidR = new float[8];
  asteroidRot = new float[8];
  asteroidRotSpeed = new float[8];
  starX = new float[190];
  starY = new float[190];

  // Asteroids
  for (int i = 0; i < asteroidX.length; i++) {
    asteroidX[i] = random(0, width);
    asteroidY[i] = random(-height, 0);
    asteroidR[i] = random(30, 60);
    asteroidRot[i] = random(TWO_PI);
    asteroidRotSpeed[i] = random(-0.05, 0.05);
  }
  
  // Stars
  for (int i = 0; i < starX.length; i++) {
    starX[i] = random(0, width);
    starY[i] = random(0, height);
  }
}

// Loop
void draw() {
  background(10);
  
  // Apply Screen Shake (Mostly Horizontal)
  if (shake > 0.1) {
    translate(random(-shake, shake), random(-shake * 0.3, shake * 0.3));
    shake *= 0.85;
  }
  
  // Apply Camera Lean
  if (currentState == GameState.PLAYING || currentState == GameState.DYING) {
    float targetCamX = map(mouseX, 0, width, 40, -40); 
    camX = lerp(camX, targetCamX, 0.05);
    translate(camX, 0);
  }
  
  // Volume
  music1.amp(0.4);
  laser1.amp(1.0);
  time1.amp(1.2);
  shield1.amp(1.2);
  
  // Screen
  switch (currentState) {
    case HOME:
      home();
      break;
      
    case PLAYING:
      noCursor();
      asteroid();
      
      // Score
      push();
      fill(255); // Always white
      textSize(48);
      textAlign(LEFT, CENTER);
      text("Score: " + score, 20, height * 0.05);
      pop();
      
      // Highscore
      push();
      if (accent) fill(100, 200, 255);
      else fill(255, 80, 80); // Consistent bright red
      textSize(28);
      textAlign(LEFT, CENTER);
      text("High Score : " + highscore, 20, height * 0.1);
      pop();
      
      // HUD
      drawShieldBar();
      drawLaserBar();
      drawSpeedBar();
      
      // Mechanics
      stars();
      collisionCheck();
      spaceShip();
      shieldCheck();
      laserCheck();
      speedCheck();
      score = score + 1;
      
      // Dynamic BGM Speed
      if (music) {
        float musicRate = 1.0 + (score / 10000.0);
        music1.rate(min(musicRate, 2.0));
      }
      
      // Particles
      updateAndDrawParticles();
      break;

    case DYING:
      asteroid();
      stars();
      updateAndDrawParticles();
      deathTimer--;
      if (deathTimer <= 0) {
        currentState = GameState.GAMEOVER;
      }
      break;

    case GAMEOVER:
      gameOver();
      break;

    case SETTINGS:
      setting();
      break;
    case PAUSED:
      pauseScreen();
      break;
  }
}

void mousePressed() {
  if (mouseX > width - 70 && mouseX < width - 10 && mouseY > height - 50 && mouseY < height - 10) {
  }
  
  if (currentState == GameState.HOME) {
    float bW = width * 0.25;
    float bH = height * 0.08;
    float bX = width * 0.5;
    float bStartY = height * 0.60;
    float bGap = bH + 20;

    // Start Mission
    float b0y = bStartY;
    if (abs(mouseX - bX) < bW/2 && abs(mouseY - b0y) < bH/2) {
      currentState = GameState.PLAYING;
      if (music && !globalMute && !music1.isPlaying()) music1.loop();
    }

    // Settings
    float b1y = bStartY + bGap;
    if (abs(mouseX - bX) < bW/2 && abs(mouseY - b1y) < bH/2) {
      currentState = GameState.SETTINGS;
    }

    // Exit
    float b2y = bStartY + bGap * 2;
    if (abs(mouseX - bX) < bW/2 && abs(mouseY - b2y) < bH/2) {
      exit();
    }
  }
 else if (currentState == GameState.SETTINGS) {
    settingsMousePressed();
  } else if (currentState == GameState.PAUSED) {
    float panelW = width * 0.5;
    float panelH = height * 0.4;
    float pX = width / 2;
    float pY = height / 2;
    
    float bY_p = pY + panelH * 0.2;
    float bW_p = panelW * 0.35;
    float bH_p = height * 0.07;
    
    float rX = pX - panelW * 0.22; // Resume
    float mmX = pX + panelW * 0.22; // Main Menu
    
    // Resume
    if (abs(mouseX - rX) < bW_p/2 && abs(mouseY - bY_p) < bH_p/2) {
      currentState = GameState.PLAYING;
      if (music) music1.loop();
    }
    
    // Main Menu
    if (abs(mouseX - mmX) < bW_p/2 && abs(mouseY - bY_p) < bH_p/2) {
      currentState = GameState.HOME;
      music1.stop();
      resetGameSession();
    }
  } else if (currentState == GameState.GAMEOVER) {
    float panelW = width * 0.6;
    float panelH = height * 0.6;
    float pX = width / 2;
    float pY = height / 2;
    
    float bY_go = pY + panelH * 0.32;
    float bW_go = panelW * 0.3;
    float bH_go = height * 0.07;
    
    float paX = pX - panelW * 0.2; // Play Again
    float mmX = pX + panelW * 0.2; // Main Menu
    
    if (abs(mouseX - paX) < bW_go/2 && abs(mouseY - bY_go) < bH_go/2) {
      currentState = GameState.PLAYING;
      shake = 0;
      dataSaved = false;
      if (music) music1.loop();
      resetGameSession();
    }
    
    if (abs(mouseX - mmX) < bW_go/2 && abs(mouseY - bY_go) < bH_go/2) {
      currentState = GameState.HOME;
      dataSaved = false;
      music1.stop();
      resetGameSession();
    }
  }
}

void keyPressed() {
  if ((key == ' ') && (currentState == GameState.GAMEOVER)) {
    currentState = GameState.PLAYING;
    shake = 0;
    dataSaved = false;
    if (music) music1.loop();
    resetGameSession();
  }
  
  // Mute
  if (((key == 'm') || (key == 'M')) && (currentState != GameState.GAMEOVER)) {
    music = !music;
    if (!music) {
      music1.stop();
    } else {
      if (!globalMute) {
        if (!music1.isPlaying()) music1.loop();
      }
    }
  }
  
  // Pause
  if ((key == 'p') || (key == 'P')) {
    if (currentState == GameState.PLAYING) {
      currentState = GameState.PAUSED;
    } else if (currentState == GameState.PAUSED) {
      currentState = GameState.PLAYING;
    }
  }
}

// UX Utilities
void spawnParticles(float x, float y, color c) {
  int spawned = 0;
  for (int i = 0; i < px.length && spawned < 15; i++) {
    if (plife[i] <= 0) {
      px[i] = x;
      py[i] = y;
      float angle = random(TWO_PI);
      float speed = random(2, 6);
      pvx[i] = cos(angle) * speed;
      pvy[i] = sin(angle) * speed;
      plife[i] = random(20, 50);
      pcol[i] = c;
      spawned++;
    }
  }
}

void updateAndDrawParticles() {
  for (int i = 0; i < px.length; i++) {
    if (plife[i] > 0) {
      px[i] += pvx[i];
      py[i] += pvy[i];
      plife[i] -= 1.0;
      
      noStroke();
      fill(pcol[i], map(plife[i], 0, 50, 0, 255));
      circle(px[i], py[i], map(plife[i], 0, 50, 1, 6));
    }
  }
}

void drawBatteryBar(float x, float y, float w, float h, float val, String label, color c, boolean usable) {
  push();
  rectMode(CORNER);
  
  // 1. Label 
  fill(255);
  textAlign(RIGHT, CENTER);
  textSize(h * 0.8);
  text(label, x - 15, y + h * 0.45);
  
  // 2. Battery Outer Shell
  fill(15, 15, 25, 220);
  stroke(200, 200, 255, 60);
  strokeWeight(2);
  rect(x, y, w, h, 4);
  
  // 3. Battery Positive Terminal (Cap)
  noStroke();
  fill(200, 200, 255, 80);
  rect(x + w, y + h * 0.25, 5, h * 0.5, 0, 3, 3, 0);
  
  // 4. Energy Cells (Segmented blocks)
  int segments = 8;
  float spacing = 3;
  float segW = (w - (segments + 1) * spacing) / segments;
  int filledSegments = floor((val / 100.0) * segments);
  
  for (int i = 0; i < segments; i++) {
    float sx = x + spacing + i * (segW + spacing);
    if (i < filledSegments) {
      // Dynamic coloring logic
      color cellColor = c;
      if (!usable) {
        // Red warning if charging and low
        cellColor = color(150, 40, 40);
      }
      
      fill(cellColor);
      noStroke();
      rect(sx, y + spacing, segW, h - (spacing * 2), 1);
      
      // Glossy Glare
      fill(255, 60);
      rect(sx, y + spacing, segW, (h - (spacing * 2)) * 0.4, 1);
      
      // Outer Glow for usable batteries
      if (usable) {
        fill(cellColor, 30);
        rect(sx - 1, y + spacing - 1, segW + 2, h - (spacing * 2) + 2, 2);
      }
    } else {
      // Empty Cell Slot
      fill(40, 40, 50, 150);
      noStroke();
      rect(sx, y + spacing, segW, h - (spacing * 2), 1);
    }
  }
  pop();
}

void resetGameSession() {
  laserPower = 100;
  laserUsable = true;
  shieldPower = 100;
  shieldUsable = true;
  speedupUsable = true;
  speedupPower = 100;
  score = 0;
  speed = 10;
  baseSpeed = 10;
  music1.rate(1.0);
  
  // Reset Asteroids
  for (int i = 0; i < asteroidX.length; i++) {
    asteroidY[i] = random(-height / 2, 0);
    asteroidX[i] = random(0, width);
    asteroidR[i] = random(30, 60);
    asteroidRot[i] = random(TWO_PI);
    asteroidRotSpeed[i] = random(-0.05, 0.05);
  }
}
