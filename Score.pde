class Score{
  int score;
  
  Score(int s){
    score = s;
  }
  
  void display() {
    fill(255);
    textSize(32);
    text("Score: " + str(score), 10, 30);
  }
}
