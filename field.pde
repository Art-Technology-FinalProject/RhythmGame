class field{
  float w;
  float h;
  
  field(float wid, float hig){
    this.w = wid;
    this.h = hig;
  }
  
  void update(){
    beat.detect(bgm.mix);
    if ( beat.isOnset() ) {
      w = width;
      h = height;
    }
    //float ab = map(w, 20, 80, 60, 255);
  
    //rectMode(CENTER);
    noFill();
    strokeWeight(3);
    stroke(255);
    rect(0, 0, w, h);
    w *= 0.95;
    h *= 0.95;
    if ( w > 10 ) {
      w = width;
      h = height;
    }
  }
}
