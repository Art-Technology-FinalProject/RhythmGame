// 공이 지나가는 속도 노트가 생겨나는  rad와 적합하게 만들 수 있는지
// labeling

PImage noteBreaker, blueNote, greenNote, yellowNote, whiteNote;

ArrayList<Note> notes = new ArrayList<Note>();

int[] noteTime;
float[] notePos; // rad로 position표현할 수 잇는 법 찾기
int[] noteColor;
int start;

float circleRad = 300;
float rotPos = 0.0;
float rotVel = PI/72;
float x = 0;
int s = second();


import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer bgm;


void setup(){
  size(800, 600);
  
  fill(0);
  rect(0, 0, width, height);

  noteBreaker = loadImage("noteBreaker.png");
  blueNote = loadImage("blue.png");
  greenNote = loadImage("green.png");
  yellowNote = loadImage("yellow.png");
  whiteNote = loadImage("white.png");
  
  minim = new Minim(this);
  bgm = minim.loadFile("bgm.mp3");
  bgm.loop();
  
  String[] lines = loadStrings("bgm.txt");
  
  noteTime = new int[lines.length / 3];
  notePos = new float[lines.length / 3];
  noteColor = new int[lines.length / 3];
  int j = 0;

  for(int i = 0; i < lines.length; i++){
    if(i % 3 == 0){
      noteTime[j] = parseInt(lines[i]);
    }
    else if(i % 3 == 1){
      notePos[j] = parseFloat(lines[i]);
    }
    else{
      noteColor[j] = parseInt(lines[i]);
      j++;
    }
    
    start = millis();
  }
}

int k = 0;

void draw(){

  fill(0, 30);
  rect(0, 0, width, height);
 
  if(noteTime[k] - 500 <= millis()){
    
    notes.add(new Note(notePos[k], noteColor[k]));
    k += 1;
  }
  for(Note note : notes){
      note.appear();
  }
  // // 대충 노트 시간을 지나면 class에 넣고 track에 맞춰서 나오게끔 하는 방식이구나
  

  pushMatrix();
    translate(width/2, height/2);
    rotate(rotPos);
    noFill();
    //stroke(255 - x);
    stroke(255);
    strokeWeight(0.2);
    ellipse(0, 0, circleRad, circleRad);
  
    imageMode(CENTER);
    image(noteBreaker, - circleRad/2, 0, 80, 80);
    popMatrix();

  rotPos += rotVel;
  //x += 1;

}

void keyPressed() {
  rotVel *= -1;
}
