import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class CongaTone extends ZabuTone {
  CongaTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  CongaTone(float pt, float dm, SCScore score, Arduino ard) {
    super(pt, dm, score, ard);
  }
  
  CongaTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    println("Simple");
    //Simple One
    if (rhythm_level == 0) {
      for (float i=0; i< 16; i++) {
        if (i%8 < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic, 0.25, 0.8, 64);
        } else if (i%8 < 4) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic - 40, 0.25, 0.8, 64);
        } else if (i%8 < 7) {
          if ((dynamic + 30) < 128) {
            score.addNote(i * 0.5, 9, 0, pitch, dynamic + 30, 0.25, 0.8, 64);
          } else {
            score.addNote(i * 0.5, 9, 0, pitch, 127, 0.25, 0.8, 64);
          }
        }
      }
    } else  if (rhythm_level == 1) {
      println("Complex");
      //Complex one
      for (float i=0; i< 16; i++) {
        if (i%8 == 0 || i%16 == 14) {
          score.addNote(i * 0.5, 9, 0, pitch, 60, 0.5, 0.8, 64);
        } else if (random(10) < 1) {
          score.addNote(i * 0.5, 9, 0, pitch, 5, 0.5, 0.8, 64);
        }
        if (i%8 == 4) {
          score.addNote(i * 0.5, 9, 0, pitch, 55, 0.5, 0.8, 64);
        } else if (random(10) < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, 10, 0.5, 0.8, 64);
        }
        
        if (random(10) < 8) {
          score.addNote(i * 0.5, 9, 0, pitch, random(40) + 10, 0.5, 0.8, 64);
        } else {
          score.addNote(i * 0.5, 9, 0, pitch, 30 , duration, 0.5, 64);
        }
      }
    }
  }
}
