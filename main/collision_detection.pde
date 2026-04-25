void collisionCheck() {
  for (int i = 0; i < asteroidX.length; i++) {
    // Use cached radius for performance (avg radius is roughly 0.9 * base size)
    float avgR = asteroidR[i] * 0.9;
    float distance = dist(mouseX, height - height / 10, asteroidX[i], asteroidY[i]);
    float distanceX = abs(mouseX - asteroidX[i]);
    
    // Shield Collision 
    if (shield && (distance < avgR + 65)) {
      shake = 12;
      spawnParticles(asteroidX[i], asteroidY[i], accent ? color(100, 200, 255) : color(255, 80, 80));
      asteroidX[i] = random(0, width);
      asteroidY[i] = random(-height, -50);
      asteroidR[i] = random(30, 60);
      asteroidRotSpeed[i] = random(-0.05, 0.05);
      score += 50;
    } 
    // Laser Collision
    else if (laser && (distanceX < avgR * 0.8) && (asteroidY[i] < height - height / 10) && (asteroidY[i] > 0)) {
      spawnParticles(asteroidX[i], asteroidY[i], accent ? color(100, 200, 255) : color(255, 80, 80));
      asteroidX[i] = random(0, width);
      asteroidY[i] = random(-height, -50);
      asteroidR[i] = random(30, 60);
      asteroidRotSpeed[i] = random(-0.05, 0.05);
      score += 50;
    } 
    // Player Collision
    else if (!shield && (distance < avgR + 15)) {
      if (!globalMute) gameover.play();
      music1.stop();
      shield1.stop();
      time1.stop();
      laser1.stop();
      music1.rate(1.0);
      shake = 25;
      spawnParticles(mouseX, height - height / 10, accent ? color(100, 200, 255) : color(255, 80, 80));
      currentState = GameState.DYING;
      deathTimer = 60;
    }
  }
}
