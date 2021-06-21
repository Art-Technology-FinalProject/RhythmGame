// 공이 지나가는 속도 노트가 생겨나는  rad와 적합하게 만들 수 있는지
// labeling

final int BLUE = 1;
final int GREEN = 2;
final int YELLOW = 3;
final int WHITE = 4;

final int NUM_NOTE = 131;
final int LIFE_MS = 700;
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
int CUR_TIME;
void draw(){
  CUR_TIME = millis();
  fill(0, 30);
  rect(0, 0, width, height);
  
  int appear_time = noteTime[k] - LIFE_MS >= 0? noteTime[k] - LIFE_MS : 0;
  if(appear_time <= CUR_TIME){
    //print(appear_time+"\n");
    Note note;
    switch (noteColor[k]){
     case BLUE:
       note = new BlueNote(notePos[k], noteTime[k]);
       break;
     case GREEN:
       note = new GreenNote(notePos[k], noteTime[k]);
       break;
     case YELLOW:
       note = new YellowNote(notePos[k], noteTime[k]);
       break;
     case WHITE:
       note = new WhiteNote(notePos[k], noteTime[k]);
       break;
     default:
       note = null;
       break;
    }
    notes.add(note);
    //println(rotPos);
    if (k<NUM_NOTE-1)
      k += 1;
  }
  
  ArrayList<Note> cp_notes = new ArrayList<Note>(notes);
  for(Note note : cp_notes){
      note.appear();
      if (note.time <= CUR_TIME) {
        //print(note.time+"/"+CUR_TIME+"\n");
        
        switch (note.color_){
         case BLUE:
           ((BlueNote)note).impact();
           break;
         case GREEN:
           ((GreenNote)note).impact();
           break;
         case YELLOW:
           ((YellowNote)note).impact();
           break;
         case WHITE:
           ((WhiteNote)note).impact();
           break;
        }
        
        notes.remove(note);
      }
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

  //println(k);
  //if (noteTime[k] - millis() < 500) {
  //   println(noteTime[k]);
  //  println(rotPos); 
  //  println(noteColor[k]);
  //}


}

void keyPressed() {
  println(rotPos);
  
}
