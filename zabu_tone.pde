import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class ZabuTone extends Tone {
  Arduino arduino;
  boolean playing = false;
  ZabuTone() {
    super();
  }
  
  ZabuTone(float pt) {
    super(pt);
  }
  
  ZabuTone(float pt, float dt, float dm, Arduino ard) {
    super(pt, dt, dm);
  }
  
  void setPlaying(boolean signal) {
    playing = signal;
  }
  
  void dynamicUpdate() {
    if (beat_count%4 == 0 || random(10) < 2) {
      duration = 1;
    } else {
      duration = 0.5;
    }
    dynamic = cos(PI * 1 * beat_count) * 30 + 90;
    playing = false;
  }
  void play() {
    if (!playing) {
      //float[] pitches = {sound_cipher.LOW_CONGA, sound_cipher.LOW_CONGA, sound_cipher.LOW_CONGA};
      //float[] pitches = {70, 75, 72};
      //float [] dynamics = {80, 100, 80};
      //float[] durations = {0.5, 1, 0.5};
      sound_cipher.playNote(starBeat, channel, instrument, pitch, dynamic, duration, articulation, pan);
      //sound_cipher.playChord(starBeat, channel, instrument, pitches, dynamic, duration, articulation, pan);
      beat_count += duration;
      playing =  true;
    }
  }
  
  void light_on(int pin) {
  }
}
