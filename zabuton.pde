import arb.soundcipher.*;
import arb.soundcipher.constants.*;
import processing.serial.*;
import cc.arduino.*;
import arb.soundcipher.*;
import arb.soundcipher.constants.*;

Arduino arduino;
//SoundCipher sc;
//SoundCipher[] sub_scs =  new SoundCipher[6];
SCScore score;
FootTone left_foot_tone;
FootTone right_foot_tone;
ZabuTone zabu_tone1;
ZabuTone zabu_tone2;
ZabuTone zabu_tone3;

//define pin value here
final int RIGHT_FORCE_SENSOR_PIN = 0;
final int LEFT_FORCE_SENSOR_PIN = 1;
final int SWITCH_PIN = 12;

float global_duration = 0.5;
float global_dynamic = 80;
float global_tempo = 110;

void setup() {
  noLoop();
  size( 220, 120, P2D);
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(SWITCH_PIN, Arduino.INPUT);

  //sc = new SoundCipher(this);
  //
  /*
  left_foot_tone = new FootTone(score.HIGH_TIMBALE);
  right_foot_tone = new FootTone(score.HI_MID_TOM);
  zabu_tone = new ZabuTone(score.LOW_FLOOR_TOM);
  */
  /*
  left_foot_tone = new FootTone(score.CHINESE_CYMBAL);
  right_foot_tone = new FootTone(score.CRASH);
  zabu_tone = new ZabuTone(score.PEDAL_HI_HAT);
  */
  
  /*
  left_foot_tone = new FootTone(score.VIBRASLAP);
  right_foot_tone = new FootTone(score.TRIANGLE);
  zabu_tone = new ZabuTone(score.HAND_CLAP);
  */
  left_foot_tone = new FootTone(score.VIBRASLAP);
  right_foot_tone = new FootTone(score.TRIANGLE);
  
  zabu_tone1 = new ZabuTone(score.HI_MID_TOM);
  zabu_tone2 = new ZabuTone(score.PEDAL_HI_HAT);
  zabu_tone3 = new ZabuTone(score.HAND_CLAP);
  
  score = new SCScore();
  score.addCallbackListener(this);
  score.addCallback(zabu_tone1.duration, 1);
  score.play(-1);
  
  redraw();
}

void draw() {
  // erase the window to black
  background(color(4, 79, 111));
  // draw using a white stroke
  stroke(color(84, 145, 158));
 
  int left_val = arduino.analogRead(LEFT_FORCE_SENSOR_PIN);
  int right_val = arduino.analogRead(RIGHT_FORCE_SENSOR_PIN);
  int switch_val = arduino.digitalRead(SWITCH_PIN);
  if ( switch_val== 1) {
    zabu_tone1.play();
    zabu_tone2.play();
    zabu_tone3.play();
    if (left_val > 0) {
      float dynamic = map(left_val, 0, 880, 60, 120);
      left_foot_tone.setDynamic(dynamic);
      left_foot_tone.play();
    }
    if (right_val > 0) {
      float dynamic = map(left_val, 0, 880, 60, 120);
      right_foot_tone.setDynamic(dynamic);
      right_foot_tone.play();
    }
  }
  
  println(left_val + ": " + right_val + ": " + switch_val);
}

void handleCallbacks(int callbackID) {
  redraw();
  zabu_tone1.dynamic_update();
  zabu_tone2.dynamic_update();
  zabu_tone3.dynamic_update();
  
  score.empty();
  score.addCallback(zabu_tone1.duration, 1);
  score.update();
}

void stop()
{
  // stop SCScore object
  score.stop();
  // stop the processing object
  super.stop();
}
