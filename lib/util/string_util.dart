import 'dart:math' as math;

class StringUtil {
  static String randomString(int length) {
    String randomStr = "";

    var random = math.Random();

    for (var i = 0; i < length; i++) {
      int alphaNum = 65 + random.nextInt(26);
      int isLower = random.nextBool() ? 32 : 0;

      randomStr += String.fromCharCode(alphaNum + isLower);
    }

    return randomStr;
  }
}
