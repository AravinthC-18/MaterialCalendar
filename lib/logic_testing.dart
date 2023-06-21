import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class testing {
  void testFunc() {
    var date = new DateTime(2013, 3, 0);
    debugPrint(date.day.toString());
    debugPrint(date.weekday.toString());
    new DateFormat('mm yyyy');
    String formattedTime = DateFormat('MMM').format(date);
    var date1 = new DateTime(2023, 12, 1);
    String weakDays = DateFormat('EEE').format(date1);
    debugPrint(formattedTime.toString());
    debugPrint(weakDays);


  }
}

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}