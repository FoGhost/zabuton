import arb.soundcipher.*;
import arb.soundcipher.constants.*;
import processing.serial.*;
import cc.arduino.*;
import arb.soundcipher.*;
import arb.soundcipher.constants.*;

Arduino arduino;

SCScore score;
FootTone left_foot_tone;
FootTone right_foot_tone;
ZabuTone zabu_tone1;
ZabuTone zabu_tone2;
ZabuTone zabu_tone3;
TomTone tom_tone;
CongaTone conga_tone;
CabasaTone cabasa_tone;
HiHatTone hi_hat_tone;
CymbalTone cymbal_tone;

//define pin value here
final int RIGHT_FORCE_SENSOR_PIN = 0;
final int LEFT_FORCE_SENSOR_PIN = 1;
final int SWITCH_PIN = 12;
final int LED_PIN = 9;

float force_sensor_max_threshold = 400;
float force_sensor_min_threshold = 20;
float foot_tone_volume_min_threshold = 40;
float duration = 0.5;
float dynamic = 80;
float tempo = 110;
boolean play_signal = true;
boolean playing = false;

boolean[][] button_status = {{true, true, true, true}, {false, false, false, false}};
final int RECT_UPPERLEFT_X = 30;
final int RECT_UPPERLEFT_Y = 30;
final int RECT_LENGTH = 30;
final int RECT_INTERVAL = 10;
final color OFF = color(4, 79, 111);
final color ON = color(84, 145, 158);

void setup() {
  //noLoop();
  size( 220, 120, P2D);
  
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(SWITCH_PIN, Arduino.INPUT);
  arduino.pinMode(LED_PIN, Arduino.OUTPUT);

  score = new SCScore();
  score.addCallbackListener(this);
  score.tempo(110.0);
  //score.addCallback(zabu_tone1.duration, 1);
  
  //score.play(-1);
  //sc = new SoundCipher(this);
  //
  /*
  left_foot_tone = new FootTone(score.HIGH_TIMBALE);
  right_foot_tone = new FootTone(score.HI_MID_TOM);
  zabu_tone1 = new ZabuTone(score.LOW_FLOOR_TOM);
  */
  
  /*
  left_foot_tone = new FootTone(score.TAMBOURINE);
  right_foot_tone = new FootTone(score.LOW_WOOD_BLOCK);
  */
  
  left_foot_tone = new FootTone(score.ELECTRIC_SNARE, 10, arduino);
  right_foot_tone = new FootTone(score.KICK_DRUM, 11, arduino);
  
  //Initialized tone
  tom_tone = new TomTone(score.LOW_TOM, score, arduino);
  conga_tone = new CongaTone(score.LOW_CONGA, score, arduino);
  cabasa_tone = new CabasaTone(score.CABASA, score, arduino);
  hi_hat_tone = new HiHatTone(score.HIHAT, score, arduino);
  cymbal_tone = new CymbalTone(score.CRASH, score, arduino);
  
  //conga_tone.dynamicGenNotes();
  //cabasa_tone.dynamicGenNotes();  
  //cymbal_tone.dynamicGenNotes();

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
}

void draw() {
  // erase the window to black
  background(color(4, 79, 111));
  // draw using a white stroke
  stroke(color(84, 145, 158));
 
  int left_val = arduino.analogRead(LEFT_FORCE_SENSOR_PIN);
  int right_val = arduino.analogRead(RIGHT_FORCE_SENSOR_PIN);
  
  //conga_tone.isOn()
  if (conga_tone.isOn()) {
    if (!conga_tone.isBooted()) {
    //Status: Sleeping
      //TODO dhynammic add instrument in callback
      if (playing == false) {
        conga_tone.dynamicGenNotes();
        score.addCallback(8, 0);
        score.play();
        playing = true;
      }
      conga_tone.boot(left_foot_tone, right_foot_tone);
    } else {
    //Status: Booted
      if (playing == false) {
        score.play();
        playing = true;
      }
      conga_tone.lightOn();
    }
  } else {
    if (conga_tone.isBooted()) {
      conga_tone.shutdown();
    }
    score.stop();
    score.empty();
    playing = false;
  }

  if (left_val > force_sensor_min_threshold) {
      left_foot_tone.update(forceToDynamic(left_val));
      left_foot_tone.play();
      left_foot_tone.lightOn();
      left_foot_tone.lock();
  } else {
    left_foot_tone.update(0);
    left_foot_tone.lightOff();
    left_foot_tone.unlock();
  }
  
  if (right_val > force_sensor_min_threshold) {
    right_foot_tone.update(forceToDynamic(right_val));
    right_foot_tone.play();
    right_foot_tone.lightOn();
    right_foot_tone.lock();
  } else {
    right_foot_tone.update(0);
    right_foot_tone.lightOff();
    right_foot_tone.unlock();
  }
  println(left_val + ": " + right_val + ": " + conga_tone.isOn() + " is_booted: " + conga_tone.isBooted());
  
  //Buttons for controlling
  for (int i = 0; i < 2 ; i++) {
    for (int j = 0; j < 4; j++) {
      if (button_status[i][j] == false) {
        fill(OFF);
      } else {
        fill(ON);
      }
      rect(RECT_UPPERLEFT_X + j * (RECT_LENGTH+RECT_INTERVAL), RECT_UPPERLEFT_Y + i * (RECT_LENGTH+RECT_INTERVAL), RECT_LENGTH, RECT_LENGTH);
    }
  }
}

float forceToDynamic(int force) {
  return map(force, force_sensor_min_threshold, force_sensor_max_threshold, foot_tone_volume_min_threshold, 120);
}

void handleCallbacks(int callbackID) {
  println("callback");
  score.stop();
  score.empty();
  conga_tone.dynamicGenNotes();
  cabasa_tone.dynamicGenNotes();  
  //cymbal_tone.dynamicGenNotes();
  
  score.addCallback(8, 0);
  playing = false;
  //score.play();
  //zabu_tone1.dynamicGenNotes();
  /*
  switch (callbackID) {
    case 11:
      left_foot_tone.score.stop();
  }
  */
  //score.update();
}

void mousePressed() {
  int x_pos = -1, y_pos = -1;
  if (RECT_UPPERLEFT_Y < mouseY && mouseY < RECT_UPPERLEFT_Y+ 2 * RECT_LENGTH + RECT_INTERVAL) {
    x_pos = (mouseX - RECT_UPPERLEFT_X) / (RECT_LENGTH + RECT_INTERVAL);
    
    if (mouseY < RECT_UPPERLEFT_Y+ RECT_LENGTH + RECT_INTERVAL) {
      y_pos = 0;
    } else {
      y_pos = 1;
    }
  }
  
  if (x_pos < 4 && y_pos < 2) {
   if (y_pos == 1) {
    button_status[y_pos][x_pos] = true;
    button_status[0][x_pos] = false;
   } else if(y_pos == 0) {
    button_status[y_pos][x_pos] = true;
    button_status[1][x_pos] = false;
   }
  }
  
  switch (x_pos) {
    case 0:
      conga_tone.setRhythmLevel(y_pos);
      break;
    case 1:
      cabasa_tone.setRhythmLevel(y_pos);
      break;
    case 2:
      cymbal_tone.setRhythmLevel(y_pos);
      break;
    case 3:
      break;
  }
}

void keyPressed() {
   if (key == 'c') {
     score.stop();
     score.empty();
     conga_tone.dynamicGenNotes();
     //cabasa_tone.dynamicGenNotes();
     //cymbal_tone.dynamicGenNotes();
     //hi_hat_tone.dynamicGenNotes();
     score.addCallback(8, 0);
     score.play();
     //zabu_tone1.play();
   }
}
void stop()
{
  // stop SCScore object
  score.stop();
  // stop the processing object
  super.stop();
}
