import arb.soundcipher.*;
import arb.soundcipher.constants.*;

class ZabuTone extends Tone {
  ZabuTone() {
    super();
  }
  
  ZabuTone(float pt) {
    super(pt);
  }
  
  ZabuTone(float pt, float dt, float dm) {
    super(pt, dt, dm);
  }
  
  void dynamic_update() {
    if (beat_count%4 == 0 || random(10) < 2) {
      duration = 1;
    } else {
      duration = 0.5;
    }
    dynamic = cos(PI * 1 * beat_count) * 30 + 90;
  }
}
