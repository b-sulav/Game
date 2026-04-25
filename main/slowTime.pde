void speedCheck() {
  // Usage
  if ((speedup == true) && (speedupPower > 0)) {
    speedupPower = speedupPower - 2;
  }
  
  // Empty
  if (speedupPower <= 0) {
    speedupPower = 0;
    if (speedup) time1.stop();
    speedup = false;
    speedupUsable = false;
  }
  
  // Charging
  if ((speedup == false) && (speedupPower < 100)) {
    speedupPower = speedupPower + 0.5;
  }
  
  // Full
  if (speedupPower >= 100) {
    speedupPower = 100;
    speedupUsable = true;
  }
}

