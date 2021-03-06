// 공이 지나가는 속도 노트가 생겨나는  rad와 적합하게 만들 수 있는지
// labeling

final int BLUE = 1;
final int GREEN = 2;
final int YELLOW = 3;
final int WHITE = 4;

final int NUM_NOTE = 129;
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

Score scr;
int score_point = 0;

field f;

import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer bgm;
BeatDetect beat;

PFont myfont;

void setup(){
  size(800, 600);
  
  fill(0);
  rect(0, 0, width, height);

  //myfont = createFont("한컴돋움",32);
  //textFont(myfont);
  
  noteBreaker = loadImage("noteBreaker.png");
  blueNote = loadImage("blue.png");
  greenNote = loadImage("green.png");
  yellowNote = loadImage("yellow.png");
  whiteNote = loadImage("white.png");
  
  minim = new Minim(this);
  bgm = minim.loadFile("bgm.mp3");
  bgm.loop();
  
  String[] lines = loadStrings("break_point.txt");
  
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
  beat = new BeatDetect();
  f = new field(width, height);
}

int k = 0;
int CUR_TIME;

ArrayList<Note> cccc = new ArrayList<Note>();
boolean flag = false;


float x1 = 80;  float x2 = width - 80;
float y1 = 60; float y2 = height - 60;

int pressedTime = -9000;


import java.util.LinkedList; //import
import java.util.Queue; //import
import java.util.Iterator;

Queue<String> queue = new LinkedList<String>();
Iterator<String> iter = null;

void draw(){
  
    beat.detect(bgm.mix);
    if ( beat.isOnset() ) {
      x1 = 0; x2 = width;
      y1 = 0; y2 = height;
    }
    strokeWeight(3);
    stroke(255);
    quad(x1, y1, x2, y1, x2, y2, x1, y2);
    
    x1 += 4;
    x2 -= 4;
    y1 += 3;
    y2 -= 3;
    
    if ( x1 > 80   ) {
      x1 = 80;
      y1 = 60;
      x2 = width - 80;
      y2 = height - 60;
    }

  
  
  // score board
  scr = new Score(score_point);
  scr.display();
  
  
  if (flag) {
   for (Note c : cccc) {
    //println(c.time);
    //println(rotPos);
    //println(c.color_);
    pressedTime = c.time;
   }
   
   cccc.clear();
   flag = false;
  }
  
  //print(pressedTime);
  
  
  
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
  
  iter = queue.iterator();
  int tx = width - 103, ty=92;
  while(iter.hasNext()) {
    fill(255);
    textSize(32);
    text(iter.next(), tx, ty);
    ty += 30;
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
        cccc.add(note);
        flag = true;
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
  int gap = abs(pressedTime - millis());
  println(gap);
  if (gap<50) {
    score_point += 173;
    addQ("A");
  } else if (50<=gap & gap<100) {
    score_point += 73;
    addQ("B");
  } else if (100<=gap & gap<400) {
    score_point += 37;
    addQ("C");
  } else if (400<=gap) {
    score_point -= 300;
    addQ("F");
  }
  
}

void addQ(String s) {
 if (queue.size() > 3) {
  queue.remove();
 }
 queue.add(s);
}
