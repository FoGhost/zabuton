import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class ZabuTone extends Tone {
  Arduino arduino;
  boolean playing = false;
  final int LED_PIN = 9;
  final int SWITCH_PIN = 12;
  boolean is_booted = false;
  boolean started_booting = false;
  int rhythm_level = 0;
  Timer timer;
  
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
  
  ZabuTone(float pt, float dm, SCScore score, Arduino ard) {
    super(pt, score);
    dynamic = dm;
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
  
  boolean isOn() {
    int val = arduino.digitalRead(SWITCH_PIN);
    if (val == 0) {
      return false;
    } else {
      return true;
    }
  }
  
  boolean isBooted() {
    if (is_booted == true) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean isBooting() {
    if (timer.isFinished()) {
      return false;
    } else {
      return true;
    }
  }
  
  void completeBooting() {
    is_booted = true;
    //lightOff();
  }
  
  void boot(FootTone left_tone, FootTone right_tone) {
    if (started_booting == false) {
      lightOn();
      timer = new Timer(3000);
      timer.start();
      started_booting = true;
    } else if (isBooting()) {
      lightOn();
      left_tone.setLedVal(255);
      left_tone.lightOn();
      right_tone.setLedVal(255);
      right_tone.lightOn();
      delay(500);
      lightOff();
      left_tone.lightOff();
      right_tone.lightOff();
      delay(500);
    } else {
      completeBooting();
      started_booting = false;
    }
  }
  
  void shutdown() {
    lightOff();
    is_booted = false;
  }
  
  void lightOn() {
    arduino.analogWrite(LED_PIN, 255);
  }
  
  void lightOff() {
    arduino.analogWrite(LED_PIN, 0); 
  }
}
