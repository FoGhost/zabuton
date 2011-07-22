import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class HiHatTone extends ZabuTone {
  HiHatTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  HiHatTone(float pt, SCScore score, Arduino ard) {
    super(pt, score, ard);
  }
  
  HiHatTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    if (rhythm_level == 0) {

    } else if (rhythm_level == 1) {
      //Complex one
      for (float i=0; i< 16; i++) {
        if (i%8 == 0 || i%16 == 14) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic + 30, 0.25, 0.8, 64);
        } else if (random(10) < 1) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic + 10, 0.25, 0.8, 64);
        }
        if (i%8 == 4) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic + 30, 0.25, 0.8, 64);
        } else if (random(10) < 2) {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic, 0.25, 0.8, 64);
        }
        
        if (random(10) < 8) {
          score.addNote(i * 0.5, 9, 0, pitch, random(40) + dynamic, 0.25, 0.8, 64);
        } else {
          score.addNote(i * 0.5, 9, 0, pitch, dynamic + 40 , 0.25, 0.8, 64);
        }
      }
    }
  }
}
