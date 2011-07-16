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
}
