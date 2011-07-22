import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class CabasaTone extends ZabuTone {
  CabasaTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  CabasaTone(float pt, SCScore score, Arduino ard) {
    super(pt, score, ard);
  }
  
  CabasaTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    if (rhythm_level == 0) {
      //Simple one
      for (float i=0; i< 16; i++) {
        if (i%9 == 0 || i%15 == 0) {
          score.addNote(i * 0.5, 9, 0, pitch, 40, 0.5, 0.8, 64);
        } else if (i%4 !=0) {
          float rd = random(10);
          if (i%3 == 0) {
           score.addNote(i * 0.5, 9, 0, pitch, 20, 0.25, 0.8, 64);
          } else {
           score.addNote(i * 0.5, 9, 0, pitch, 10, 0.25, 0.8, 64);
          }
        }
      }
    } else if (rhythm_level == 1) {
      //Complex one
      for (float i=0; i< 16; i++) {
        if (i%8 == 0 || i%16 == 14) {
          score.addNote(i * 0.5, 9, 0, pitch, 40, 0.5, 0.8, 64);
        } else if (random(10) < 1) {
          score.addNote(i * 0.5, 9, 0, pitch, 5, 0.5, 0.8, 64);
        }
        if (i%8 == 4) {
          score.addNote(i * 0.5, 9, 0, pitch, 35, 0.5, 0.8, 64);
        } else if (random(10) < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, 20, 0.5, 0.8, 64);
        }
        
        if (random(10) < 8) {
          score.addNote(i * 0.5, 9, 0, pitch, random(30) + 10, 0.5, 0.8, 64);
        } else {
          score.addNote(i * 0.5, 9, 0, pitch, 20 , duration, 0.5, 64);
        }
      }
    }
  }
}
