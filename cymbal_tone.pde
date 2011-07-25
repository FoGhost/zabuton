import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class CymbalTone extends ZabuTone {
  CymbalTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  CymbalTone(float pt, float dm, SCScore score, Arduino ard) {
    super(pt, dm, score, ard);
  }
  
  CymbalTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    if (rhythm_level == 0) {
      for (float i=0; i< 16; i++) {
        if (i%9 == 0 || i%15 == 0) {
          score.addNote(i * 0.5, 9, 0, pitch, 100, 0.5, 0.8, 64);
        } else if (i%4 !=0) {
          float rd = random(10);
          if (i%3 == 0) {
           score.addNote(i * 0.5, 9, 0, pitch, 70, 0.25, 0.8, 64);
          } else {
           score.addNote(i * 0.5, 9, 0, pitch, 30, 0.25, 0.8, 64);
          }
        }
      }
      /*
      for (float i=0; i< 16 ; i++) {
        // Simple one
        if (i%4 == 0) {
          float rd = random(10);
          if (rd < 7) {
            score.addNote(i * 0.5, 9, 0, pitch, 60, 0.25, 0.1, 64);
          } else if(rd< 9) {
            score.addNote(i * 0.5, 9, 0, pitch, 20, 0.25, 0.1, 64);
          } else {
             score.addNote(i * 0.5, 9, 0, pitch, 80, 0.25, 0.1, 64);
          }
        } else {
          //score.addNote(i * 0.5, 9, 0, pitch, 30, 0.5, 0.8, 64);
        }
      }*/
    } else  if (rhythm_level == 1) {
      for (float i=0; i< 16; i++) {
        if (i%8 == 0 || i%16 == 14) {
          score.addNote(i * 0.5, 9, 0, pitch, 40, 0.25, 0.8, 64);
        } else if (random(10) < 1) {
          score.addNote(i * 0.5, 9, 0, pitch, 5, 0.25, 0.8, 64);
        }
        
        if (i%8 == 4) {
          score.addNote(i * 0.5, 9, 0, pitch, 30, 0.25, 0.8, 64);
        } else if (random(10) < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, 15, 0.25, 0.8, 64);
        }
        
        if (random(10) < 8) {
          score.addNote(i * 0.5, 9, 0, pitch, random(5) + 20, 0.25, 0.8, 64);
        } else {
          score.addNote(i * 0.5, 9, 0, pitch, 15 , duration, 0.25, 64);
        }
      }
    }
  }
}
