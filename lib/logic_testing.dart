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
    DateTime now = new DateTime.now();
    String findMonth = DateFormat('MMM').format(now);
    String findYear = DateFormat('yyyy').format(now);
    String findDate = DateFormat('dd').format(now);
    debugPrint(findDate);
    debugPrint(findMonth);
    debugPrint(findYear);

    debugPrint("compare");
    debugPrint(now.toString());

    String currentYear = "2023";
    String currentMonth = "Jun";
    String currentDate = "24";

    var monthFormat = DateFormat('yyyy-MMM-dd')
        .parse("$currentYear-$currentMonth-$currentDate");
    //var checkFormat = DateFormat('yyyy-MM-dd').format(monthFormat);
    bool isTrue = now.isAfter(monthFormat);
    debugPrint(monthFormat.toString());

    debugPrint(isTrue.toString());
    debugPrint("monthFormat");


  }
}

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}
