import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

class Utils {
  Utils._();

  static DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
}

class Spacing {
  static double get xs => 4;
  static double get s => 8;
  static double get m => 16;
  static double get l => 24;
  static double get xl => 32;
  //static double get xx => 40;
  static double get xxl => 64;
}
