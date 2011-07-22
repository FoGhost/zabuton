import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class TomTone extends ZabuTone {
  TomTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  TomTone(float pt, SCScore score, Arduino ard) {
    super(pt, score, ard);
  }
  
  TomTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    if (rhythm_level == 0) {
      //Simple One
    } else if (rhythm_level == 1) {
      //Complex One
      for (float i=0; i< 16; i++) {
        if (i%8 == 0 || i%16 == 14) {
          score.addNote(i * 0.5, 9, 0, pitch, 110, 0.5, 0.8, 64);
        } else if (random(10) < 1) {
          score.addNote(i * 0.5, 9, 0, pitch, 10, 0.5, 0.8, 64);
        }
        if (i%8 == 4) {
          score.addNote(i * 0.5, 9, 0, pitch, 100, 0.5, 0.8, 64);
        } else if (random(10) < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, 20, 0.5, 0.8, 64);
        }
        
        if (random(10) < 8) {
          score.addNote(i * 0.5, 9, 0, pitch, random(40) + 20, 0.5, 0.8, 64);
        } else {
          score.addNote(i * 0.5, 9, 0, pitch, 60 , duration, 0.5, 64);
        }
      }
    }
  }
}
