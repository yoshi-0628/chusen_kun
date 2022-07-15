import 'dart:math' as math;

class IntUtil {
  static bool isNumeric(String? value) {
    if(value == null) {
      return false;
    }
    var test = int.tryParse(value) != null;
    print('トライ $test');
    return int.tryParse(value) != null;
  }
}
