import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class CymbalTone extends ZabuTone {
  CymbalTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  CymbalTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    println(dynamic +" : duration: " + duration);
    //float i = 0;
    //while(i< (4/duration)) {
      
    score.addNote(0, 9, 0, pitch, dynamic+20, duration, 0.8, 64);
    score.addNote(0, 9, 0, pitch, dynamic+20, duration, 0.8, 64);  
    //}
    for (float i=0; i< (4/duration) ; i++) {/*
      if (i%8 == 0 || i%16 == 14) {
        score.addNote(i/4, 9, 0, pitch, dynamic + 30, duration, 0.8, 64);
      } else if (random(10) < 1) {
        score.addNote(i/4, 9, 0, pitch, dynamic + 10, duration, 0.8, 64);
      }
      if (i%8 == 4) {
        score.addNote(i/4, 9, 0, pitch, dynamic + 30, duration, 0.8, 64);
      } else if (random(10) < 2) {
        score.addNote(i/4, 9, 0, pitch, dynamic, duration, 0.8, 64);
      }*/
      
      // simple
      if (i%2 ==0) {
        score.addNote(i * duration, 9, 0, pitch, dynamic+20, duration, 0.8, 64);
      }
      
      if (random(10) < 5) {
        //score.addNote(i * duration, 9, 0, pitch, dynamic+20, duration, 0.8, 64);
      } else {
        //score.addNote(i * duration, 9, 0, pitch, dynamic + 40 , duration, 0.8, 64);
      }
    }
  }
}
