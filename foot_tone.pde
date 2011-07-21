import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class FootTone extends Tone {
  boolean playable = true;
  
  FootTone() {
    super();
  }
  
  FootTone(float pt) {
    super(pt);
  }
  
  FootTone(float pt, float dt, float dm) {
    super(pt, dt, dm);
  }
  void lock() {
    playable = false;
  }
  
  void unlock() {
    playable = true;
  }
  
  void dynamic_update(float val) {
    
  }
  
  void play() {
    if (playable) {
      sound_cipher.playNote(starBeat, channel, instrument, pitch, dynamic, duration, articulation, pan);
      beat_count += duration;
    }
  }
    
  void playSerialNotes() {
    if(playable) {
      serializeNotes();
      score.addCallback(4, 11);
      score.play();
    }
  }
  
  void serializeNotes() {
    score.empty();
    for (float i=0; i<16; i++) {
      if (i%8 == 0 || i%16 == 14) {
        score.addNote(i/4, 9, 0, 36, 100, 0.25, 0.8, 64);
      } else if (random(10) < 1) score.addNote(i/4, 9, 0, 36, 70, 0.25, 0.8, 64);
      if (i%8 == 4) {
        score.addNote(i/4, 9, 0, 38, 100, 0.25, 0.8, 64);
      } else if (random(10) < 2) score.addNote(i/4, 9, 0, 38, 60, 0.25, 0.8, 64);
      if (random(10) < 8) {
        score.addNote(i/4, 9, 0, 42, random(40) + 70, 0.25, 0.8, 64);
      } else score.addNote(i/4, 9, 0, 46, 80, 0.25, 0.8, 64);
    }

  }
}
