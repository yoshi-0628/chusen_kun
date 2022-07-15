import 'dart:math' as math;

class IntUtil {
  static bool isNumeric(String? value) {
    if(value == null) {
      return false;
    }
    return int.tryParse(value) != null;
  }
}
