import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class ZabuTone extends Tone {
  Arduino arduino;
  boolean playing = false;
  final int LED_PIN = 9;
  
  int rhythm_level = 0;
  
  ZabuTone() {
    super();
  }
  
  ZabuTone(float pt) { 
    super(pt);
    duration = 0.25;
  }
  
  ZabuTone(float pt, SCScore score) {
    super(pt, score);
  }
  
  ZabuTone(float pt, SCScore score, Arduino ard) {
    super(pt, score);
    arduino = ard;
  }
  
  ZabuTone(float pt, float dt, float dm, Arduino ard) {
    super(pt, dt, dm);
  }
  
  ZabuTone(float dt, float dm, float pt, SCScore sc) {
    super(pt, dt, dm);
    sound_cipher = new SoundCipher();
    score = sc;
  }
  
  void setPlaying(boolean signal) {
    playing = signal;
  }
  
  void setRhythmLevel(int level) {
    rhythm_level = level;
  }
  
  int getRhythmLevel(int level) {
    return rhythm_level;
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
      float[] pitches = {sound_cipher.LOW_CONGA, sound_cipher.LOW_CONGA, sound_cipher.LOW_CONGA};
      //float[] pitches = {70, 75, 72};
      //float [] dynamics = {80, 100, 80};
      //float[] durations = {0.5, 1, 0.5};
      sound_cipher.playNote(starBeat, channel, instrument, pitch, dynamic, duration, articulation, pan);
      //sound_cipher.playChord(starBeat, channel, instrument, pitches, dynamic, duration, articulation, pan);
      beat_count += duration;
      playing =  true;
    }
  }
  
  void lightOn() {
    arduino.analogWrite(LED_PIN, 255);
  }
  
  void lightOff() {
    arduino.analogWrite(LED_PIN, 0); 
  }
  
  void boot() {
    
  }
  /*
  void dynamicGenNotes() {
     for (float i=0; i<8; i++) {
      if (i%8 == 0 || i%16 == 14) {
        score.addNote(i/4, 9, 0, pitch, 100, 0.5, 0.8, 64);
      } else if (random(10) < 1) score.addNote(i/4, 9, 0, pitch, 70, 0.5, 0.8, 64);
      if (i%8 == 4) {
        score.addNote(i/4, 9, 0, pitch, 100, 0.25, 0.8, 64);
      } else if (random(10) < 2) score.addNote(i/4, 9, 0, pitch, 60, 0.5, 0.8, 64);
      if (random(10) < 8) {
        score.addNote(i/4, 9, 0, pitch, random(40) + 70, 0.5, 0.8, 64);
      } else score.addNote(i/4, 9, 0, pitch, 80, 0.5, 0.8, 64);
    }
  }*/

}
