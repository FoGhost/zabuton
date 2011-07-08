import arb.soundcipher.*;
import arb.soundcipher.constants.*;

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
//SoundCipher sc;
//SoundCipher[] sub_scs =  new SoundCipher[6];
//SCScore score;

//define pin value here
final int RIGHT_FORCE_SENSOR_PIN = 0;
final int LEFT_FORCE_SENSOR_PIN = 1;
final int SWITCH_PIN = 12;

float global_duration = 0.5;
float global_dynamic = 80;
float global_tempo = 110;

void setup() {
  //noLoop();
  size( 220, 120, P2D );
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(SWITCH_PIN, Arduino.INPUT);
  
  //sc = new SoundCipher(this);
  //
  //score = new SCScore();
  //score.addCallbackListener(this);
  //score.addCallback(0.5, 1);
  //score.play(-1);
  //redraw();
}

void draw() {
  // erase the window to black
  background(color(4, 79, 111));
  // draw using a white stroke
  stroke(color(84, 145, 158));
 
  int left_val = arduino.analogRead(LEFT_FORCE_SENSOR_PIN);
  int right_val = arduino.analogRead(RIGHT_FORCE_SENSOR_PIN);
  int switch_val = arduino.digitalRead(SWITCH_PIN);
  
  println(left_val + ": " + right_val + ": " + switch_val);
}

void handleCallbacks(int callbackID) {
  redraw();

}

void stop()
{
  // stop SCScore object
  //score.stop();
  // stop the processing object
  super.stop();
}
