void laserCheck() {
  // Usage
  if ((laser == true) && (laserPower > 0)) {
    laserPower = laserPower - 2;
  }
  
  // Empty
  if (laserPower <= 0) {
    laserPower = 0;
    if (laser) laser1.stop();
    laser = false;
    laserUsable = false;
  }
  
  // Charging
  if ((laser == false) && (laserPower < 100)) {
    laserPower = laserPower + 0.5;
  }
  
  // Full
  if (laserPower >= 100) {
    laserPower = 100;
    laserUsable = true;
  }
}
