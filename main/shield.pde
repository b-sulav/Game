void shieldCheck() {
  // Usage
  if ((shield == true) && (shieldPower > 0)) {
    shieldPower = shieldPower - 1.5;
  }
  
  // Empty
  if (shieldPower <= 0) {
    shieldPower = 0;
    if (shield) shield1.stop();
    shield = false;
    shieldUsable = false;
  }
  
  // Charging
  if ((shield == false) && (shieldPower < 100)) {
    shieldPower = shieldPower + 0.5;
  }
  
  // Full
  if (shieldPower >= 100) {
    shieldPower = 100;
    shieldUsable = true;
  }
}

void drawShieldBar() {
  float barWidth = width * 0.15;
  float barHeight = height * 0.025;
  float barX = width - barWidth - 30; // Nudged left for label
  float barY = 20;
  
  drawBatteryBar(barX, barY, barWidth, barHeight, shieldPower, "SHIELD", accent ? color(0, 255, 150) : color(255, 80, 80), shieldUsable);
}

void drawLaserBar() {
  float barWidth = width * 0.15;
  float barHeight = height * 0.025;
  float barX = width - barWidth - 30;
  float barY = 20 + barHeight + 20;
  
  drawBatteryBar(barX, barY, barWidth, barHeight, laserPower, "LASER", accent ? color(100, 200, 255) : color(255, 200, 0), laserUsable);
}

void drawSpeedBar() {
  float barWidth = width * 0.15;
  float barHeight = height * 0.025;
  float barX = width - barWidth - 30;
  float barY = 20 + (barHeight + 20) * 2;
  
  drawBatteryBar(barX, barY, barWidth, barHeight, speedupPower, "TIME", accent ? color(255, 255, 0) : color(200, 100, 255), speedupUsable);
}
