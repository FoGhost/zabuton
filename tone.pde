import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class Tone {
  protected int beat_count = 0;
  
  float starBeat = 0;
  float channel = 9;
  float instrument = 0;
  float pitch;
  float dynamic = 70;
  float duration = 0.5;
  float articulation = 0.8;
  float pan = 0;
  SoundCipher sound_cipher;

  Tone() {
    sound_cipher = new SoundCipher();
  }
  
  Tone(float pt) {
    setPitch(pt);
    sound_cipher = new SoundCipher();
  }
  
  Tone(float pt, float dt, float dm) {
    pitch = pt;
    duration = dt;
    dynamic = dm;
    sound_cipher = new SoundCipher();
  }
  
  void setPitch(float pt) {
    pitch = pt;
  }
  
  void setDuration(float dt) {
    duration = dt;
  }
  
  void setDynamic(float dm) {
    dynamic = dm;
  }
  
  float getPitch(float pt) {
    return pitch;
  }
  
  float getDuration(float dt) {
    return duration;
  }
  
  float getDynamic(float dm) {
    return dynamic;
  }
  
  void play() {
    sound_cipher.playNote(starBeat, channel, instrument, pitch, dynamic, duration, articulation, pan);
    beat_count += duration;
  }
}
