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
final int LED_PIN_1 = 9;

float force_sensor_max_threshold = 400;
float foot_tone_volume_min_threshold = 40;
float duration = 0.5;
float dynamic = 80;
float tempo = 110;
boolean play_signal = true;
void setup() {
  //noLoop();
  size( 220, 120, P2D);
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(SWITCH_PIN, Arduino.INPUT);
  arduino.pinMode(LED_PIN_1, Arduino.OUTPUT);
  //sc = new SoundCipher(this);
  //
  /*
  left_foot_tone = new FootTone(score.HIGH_TIMBALE);
  right_foot_tone = new FootTone(score.HI_MID_TOM);
  zabu_tone1 = new ZabuTone(score.LOW_FLOOR_TOM);
  */
  
  left_foot_tone = new FootTone(score.TAMBOURINE);
  right_foot_tone = new FootTone(score.LOW_WOOD_BLOCK);
  zabu_tone1 = new ZabuTone(score.LOW_CONGA);
  
  
  /*
  left_foot_tone = new FootTone(score.VIBRASLAP);
  right_foot_tone = new FootTone(score.TRIANGLE);
  zabu_tone1 = new ZabuTone(score.HAND_CLAP);
  */
  
  /*
  left_foot_tone = new FootTone(score.VIBRASLAP);
  right_foot_tone = new FootTone(score.TRIANGLE);
  
  zabu_tone1 = new ZabuTone(score.HI_MID_TOM);
  zabu_tone2 = new ZabuTone(score.PEDAL_HI_HAT);
  zabu_tone3 = new ZabuTone(score.HAND_CLAP);
  */
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

  if (switch_val== 1) {
    zabu_tone1.play();
    /*
    zabu_tone2.play();
    zabu_tone3.play();
    */
    
    //LED testing
    int light;
    if (random(10) > 11) {
      arduino.analogWrite(LED_PIN_1, 100); 
    } else {
      arduino.analogWrite(LED_PIN_1, 255);
    }
    //END LED testing
    
  } else {
    //LED testing
    arduino.analogWrite(LED_PIN_1, 0);
    //END LED testing
  }
  if ( left_val > 0) {
      left_foot_tone.setDynamic(forceToDynamic(left_val));
      left_foot_tone.play();
      left_foot_tone.lock();
  } else {
    left_foot_tone.unlock();
  }
  
  if (right_val > 0) {
    right_foot_tone.setDynamic(forceToDynamic(right_val));
    right_foot_tone.play();
    right_foot_tone.lock();
  } else {
    right_foot_tone.unlock();
  }
  
  //redraw();
  println(left_val + ": " + right_val + ": " + switch_val);
}

float forceToDynamic(int force) {
  return map(force, 0, force_sensor_max_threshold, foot_tone_volume_min_threshold, 120);
}

void handleCallbacks(int callbackID) {
  zabu_tone1.dynamicUpdate();
  /*
  zabu_tone2.dynamicUpdate();
  zabu_tone3.dynamicUpdate();
  */
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
