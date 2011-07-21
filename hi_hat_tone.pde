import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class HiHatTone extends ZabuTone {
  HiHatTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  HiHatTone(float dt, float dm, float pt, SCScore score) {
    super(dt, dm, pt, score);
  }
  
  void dynamicGenNotes() {
    for (float i=0; i< (4/duration); i++) {
      if (i%8 == 0 || i%16 == 14) {
        score.addNote(i * duration, 9, 0, pitch, dynamic + 30, duration, 0.8, 64);
      } else if (random(10) < 1) {
        score.addNote(i * duration, 9, 0, pitch, dynamic + 10, duration, 0.8, 64);
      }
      if (i%8 == 4) {
        score.addNote(i * duration, 9, 0, pitch, dynamic + 30, duration, 0.8, 64);
      } else if (random(10) < 2) {
        score.addNote(i * duration, 9, 0, pitch, dynamic, duration, 0.8, 64);
      }
      
      if (random(10) < 8) {
        score.addNote(i * duration, 9, 0, pitch, random(40) + dynamic, duration, 0.8, 64);
      } else {
        score.addNote(i * duration, 9, 0, pitch, dynamic + 40 , duration, 0.8, 64);
      }
    }
  }
}
