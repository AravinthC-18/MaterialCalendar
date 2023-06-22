import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "DateList.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(background: Color(0xff0074B7)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Flutter Demo Home Page"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int month, year;
  late String currentMonth, currentYear;
  late int startPosition = 0;
  late int endDate;
  late Map<int, dynamic> hasMap = {};
  late List<DateList> dateList = [];
  late List<String> weekList = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  late double sizeBox = 510;
  late double sizeBox1 = 250;
  late DateTime today;

  @override
  void initState() {
    today = DateTime.now();
    print(today);
    setState(() {
      today;
      month = today.month;
      year = today.year;
      currentMonth = DateFormat("MMM").format(today);
      currentYear = DateFormat("yyyy").format(today);
    });
    GetEndDate(month, year);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sizeBox = 510;
    // sizeBox1 = 250;
    return Scaffold(
      backgroundColor: Color(0xffEBEFF3),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  )),
              Text("Time Tracking",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700)),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //WEEK AND MONTH
            SizedBox(
              width: sizeBox,
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Row(children: [
                  //WEEK
                  SizedBox(
                    width: sizeBox1,
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Week",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  //MONTH
                  SizedBox(
                      width: sizeBox1,
                      child: Card(
                        color: Color(0xff0074B7),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Month",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      )),
                ]),
              ),
            ),
            //MONTH AND YEAR
            SizedBox(
              width: sizeBox,
              child: Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //REVERSED
                        IconButton(
                            onPressed: () {
                              setState(() {
                                month -= 1;
                              });
                              GetEndDate(month, year);
                            },
                            icon: Icon(
                              Icons.arrow_left_rounded,
                            )),

                        Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "$currentMonth $currentYear",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            )),

                        //FORWARD
                        IconButton(
                            onPressed: () {
                              setState(() {
                                month += 1;
                              });
                              GetEndDate(month, year);
                            },
                            icon: Icon(
                              Icons.arrow_right_rounded,
                            )),
                      ])),
            ),
            SizedBox(
              width: sizeBox,
              child: Table(
                children: [
                  TableRow(children: [
                    for (int i = 0; i < weekList.length; i++) ...[
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            weekList[i].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: weekList[i].toString() == "Sat" ||
                                        weekList[i].toString() == "Sun"
                                    ? Colors.black
                                    : Colors.black),
                          ))
                    ]
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: sizeBox,
              child: Column(children: [
                for (int i = 1; i <= (endDate / 6) + 1; i++) ...[
                  TableRowList(i)
                ]
              ]),
            )
          ],
        ),
      ),
    );
  }

  void GetEndDate(int month, int year) {
    /*setState(() {
      currentMonth = DateFormat("MMM").format();
      currentYear = DateFormat("yyyy").format(today);
    });*/
    var date = DateTime(year, month + 1, 0);
    String formattedTime = DateFormat("MMM").format(date);
    String findDate = DateFormat('yyyy').format(date);
    print(date);
    currentYear = findDate;
    var date1 = DateTime(year, month, 1);
    print(date1);
    String weekDays = DateFormat("EEE").format(date1);
    print(weekDays);
    for (int i = 0; i < weekList.length; i++) {
      if (weekList[i].toString() == weekDays) {
        startPosition = i;
        break;
      }
    }
    currentMonth = formattedTime;

    setState(() {
      currentMonth;
      currentYear;
      endDate = date.day.toInt();
    });
    print(endDate);
    GetMap(endDate, startPosition);
  }

  TableRowList(int i) {
    dateList = hasMap[i];

    return Container(
      child: Table(
        children: [
          TableRow(children: [
            for (int j = 0; j < dateList.length; j++) ...[
              Column(
                children: [
                  //DATE
                  CheckCurrenDate(dateList[j].day.toString()),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //EVENT
                      CheckCurrentEvent(
                          dateList[j].day.toString(),
                          dateList[j].event.toString(),
                          dateList[j].time.toString()),
                      //TIME
                      CheckCurrentTime(dateList[j].day.toString(),
                          dateList[j].time.toString()),
                    ],
                  )
                ],
              )
            ]
          ])
        ],
      ),
    );
  }

  void GetMap(int endDate, int startPosition) {
    print("GetMap");
    hasMap = {};
    List<DateList> dateList = [];
    int n = 1;
    print(startPosition);
    for (int i = 1; i <= (endDate / 6) + 1; i++) {
      dateList = [];
      int m = 1;
      for (int j = n; j <= (i == 1 ? 1 : 6 + n); j++) {
        if (i == 1) {
          for (int k = 0; k < 7; k++) {
            if (k < startPosition) {
              DateList list = DateList("", "", "");
              dateList.add(list);
            } else {
              var date1 = DateTime(year, month, m);
              String weekDays = DateFormat("EEE").format(date1);
              DateList list = DateList(m.toString(), "",
                  weekDays == "Sat" || weekDays == "Sun" ? "" : "9:15");
              dateList.add(list);
              m += 1;
            }
          }
        } else {
          if (j == 7 || j == 5 || j == 17 || j == 25) {
            DateList list = DateList(endDate >= j ? j.toString() : "",
                j == 7 || j == 17 || j == 25 ? "LOP" : "CL", "");
            dateList.add(list);
          } else {
            var date1 = DateTime(year, month, j);
            String weekDays = DateFormat("EEE").format(date1);
            DateList list = DateList(endDate >= j ? j.toString() : "", "",
                weekDays == "Sat" || weekDays == "Sun" ? "" : "9:20");
            dateList.add(list);
          }
        }

        hasMap[i] = dateList;
      }
      n += i == 1 ? m - 1 : 7;
    }
    setState(() {
      hasMap;
    });
    print("Length" + hasMap.length.toString());
  }

  TextDayColor(int j) {
    var date1 = DateTime(year, month, j);
    String weekDays = DateFormat('EEE').format(date1);
    return weekDays == "Sat" || weekDays == "Sun" ? Colors.black : Colors.black;
  }

  CheckCurrenDate(String day) {
    String findMonth = DateFormat('MMM').format(today);
    String findYear = DateFormat('yyyy').format(today);
    String findDate = DateFormat('dd').format(today);
    return currentYear == findYear &&
            currentMonth == findMonth &&
            day == findDate
        ? Card(
            color: Color(0xff0074B7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      day.isEmpty ? Colors.black : TextDayColor(int.parse(day)),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ));
  }

  CheckCurrentEvent(String day, String event, String time) {
    bool isTrue = true;
    if (day.isEmpty) {
    } else {
      var monthFormat =
          DateFormat('yyyy-MMM-dd').parse("$currentYear-$currentMonth-$day");
      isTrue = today.isAfter(monthFormat);
    }

    return Visibility(
      visible: day.isEmpty ? false : isTrue,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Icon(Icons.circle_rounded,
            color: event == "LOP"
                ? Colors.red
                : event == "CL"
                    ? Colors.amber
                    : time.isEmpty
                        ? Colors.transparent
                        : Colors.greenAccent,
            size: 5),
      ),
    );
  }

  CheckCurrentTime(String day, String time) {
    bool isTrue = true;
    if (day.isEmpty) {
    } else {
      var monthFormat =
          DateFormat('yyyy-MMM-dd').parse("$currentYear-$currentMonth-$day");
      isTrue = today.isAfter(monthFormat);
    }
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: time.isEmpty ? false : isTrue,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(day.isEmpty ? "" : time,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
