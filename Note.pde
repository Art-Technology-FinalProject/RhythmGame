public class Note {
  float pos;
  int color_;
  int size;
  
  //Note(float nPos, int nColor){
  //  pos = nPos;
  //  color_ = nColor;
  //}
  
  public void appear(){ 
    pushMatrix();
      translate(width/2, height/2);
      rotate(pos);
      switch(color_){
        case BLUE:
          image(blueNote, - circleRad/2, 0, size, size);
        break;
        case GREEN:
          image(greenNote, - circleRad/2, 0, size, size);
        break;
        case YELLOW:
          image(yellowNote, - circleRad/2, 0, size, size);
        break;
        case WHITE:
          image(whiteNote, - circleRad/2, 0, size, size);
        break;
      }
    popMatrix();
  }

  //public void impact() { } 
}

//1 blue_note - BoooooooM!!! / slower
//2 green_note - / normal
//3 yellow_note - big size / display quake / faster
//4 white-note - / reverse

public class BlueNote extends Note {
  public BlueNote(float nPos) {
   this.pos = nPos;
   this.color_ = BLUE;
   this.size = 40;
  }
  
  //public void apper() {
  //  pushMatrix();
  //    translate(width/2, height/2);
  //    rotate(pos);
  //    image(blueNote, - circleRad/2, 0, size, size);
  //  popMatrix();
  //}
  
  public void impact() {
    rotVel /= 2; 
  }
}

public class GreenNote extends Note {
  public GreenNote(float nPos) {
   this.pos = nPos;
   this.color_ = GREEN;
   this.size = 40;
  }
  
  //public void apper() {
  //  pushMatrix();
  //    translate(width/2, height/2);
  //    rotate(pos);
  //    image(greenNote, - circleRad/2, 0, size, size);
  //  popMatrix();
  //}
  
  public void impact() {
     
  }
}

public class YellowNote extends Note {
  public YellowNote(float nPos) {
   this.pos = nPos;
   this.color_ = YELLOW;
   this.size = 40;
  }
  
  //public void apper() {
  //  pushMatrix();
  //    translate(width/2, height/2);
  //    rotate(pos);
  //    image(yellowNote, - circleRad/2, 0, size, size);
  //  popMatrix();
  //}
  
  public void impact() {
    rotVel *= 2; 
  }
}

public class WhiteNote extends Note {
  public WhiteNote(float nPos) {
   this.pos = nPos;
   this.color_ = WHITE;
   this.size = 40;
  }
  
  //public void apper() {
  //  pushMatrix();
  //    translate(width/2, height/2);
  //    rotate(pos);
  //    image(whiteNote, - circleRad/2, 0, size, size);
  //  popMatrix();
  //}
  
  public void impact() {
    rotVel *= -1; 
  }
}
