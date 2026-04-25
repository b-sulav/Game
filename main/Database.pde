void loadGameData() {
  File f = new File(sketchPath(fileName));
  
  if (f.exists()) {
    JSONObject json = loadJSONObject(fileName);
    highscore = json.getInt("highScore");
  } else {
    highscore = 0; 
  }
}

void saveGameData(int currentScore) {
  if (currentScore > highscore) {
    highscore = currentScore;
    
    JSONObject json = new JSONObject();
    json.setInt("highScore", highscore);
    saveJSONObject(json, fileName);
    println("New high score saved!");
  }
}
