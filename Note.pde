class Note {
  float pos;
  int color_;
  int size = 40;
  
  Note(float nPos, int nColor){
    pos = nPos;
    color_ = nColor;
  }
  
  void appear(){
    pushMatrix();
      translate(width/2, height/2);
      rotate(pos);
      switch(color_){
        case 1:
          image(blueNote, - circleRad/2, 0, size, size);
        break;
        case 2:
          image(greenNote, - circleRad/2, 0, size, size);
        break;
        case 3:
          image(yellowNote, - circleRad/2, 0, size, size);
        break;
        case 4:
          image(whiteNote, - circleRad/2, 0, size, size);
        break;
      }
    popMatrix();
  }
  
  void impact() {
    //disapear
  }
}

//blue_note - BoooooooM!!!
//yellow_note - big size / display quake
//green_note - 
