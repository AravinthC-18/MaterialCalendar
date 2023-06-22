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
  late List<String> monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
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
              Text("Material Calendar",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700)),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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

                        InkWell(
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "$currentMonth $currentYear",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              )),
                          onTap: () {
                            openAlertDialog(currentMonth, currentYear, 0);
                          },
                        ),

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

  GetEndDate(int monthEnd, int yearEnd) {
    /*setState(() {
      currentmonthEnd = DateFormat("MMM").format();
      currentYear = DateFormat("yyyy").format(today);
    });*/
    var date = DateTime(yearEnd, monthEnd + 1, 0);
    String formattedTime = DateFormat("MMM").format(date);
    String findYear = DateFormat('yyyy').format(date);
    print(date);
    print(findYear);
    currentYear = findYear;
    var date1 = DateTime(yearEnd, monthEnd, 1);
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
      month = monthEnd;
      year = yearEnd;
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

  GetMap(int endDate, int startPosition) {
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

  void openAlertDialog(String currentMonth, String currentYear, int n) {
    List<int> yearList = [];
    for (int i = int.parse(currentYear) - 8;
        i < int.parse(currentYear) + 8;
        i++) {
      yearList.add(i);
    }

    n == 0
        ? showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                  data: ThemeData(backgroundColor: Color(0xffEBEFF3)),
                  child: AlertDialog(
                    backgroundColor: const Color(0xffEBEFF3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white)),
                    actions: [
                      SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              //YEAR
                              InkWell(
                                child: Container(
                                  width: 240,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        currentYear,
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                onTap: () {
                                  openAlertDialog(currentMonth, currentYear, 1);
                                },
                              ),

                              //MONTH
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < monthList.length;
                                      i++) ...[
                                    InkWell(
                                      child: Card(
                                        elevation: 0,
                                        color: monthList[i].toString() ==
                                                currentMonth
                                            ? Color(0xff0074B7)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              monthList[i].toString(),
                                              style: TextStyle(
                                                  color:
                                                      monthList[i].toString() ==
                                                              currentMonth
                                                          ? Colors.white
                                                          : Colors.black),
                                            )),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        GetEndDate(
                                            i + 1, int.parse(currentYear));
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ],
                          ))
                    ],
                  ));
            })
        : showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                  data: ThemeData(backgroundColor: Color(0xffEBEFF3)),
                  child: AlertDialog(
                    backgroundColor: const Color(0xffEBEFF3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white)),
                    actions: [
                      SizedBox(
                          width: 350,
                          child: Column(
                            children: [
                              Container(
                                  width: 300,
                                  decoration: ShapeDecoration(
                                    //color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //REVERSED
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            openAlertDialog(currentMonth, yearList[0].toString(), 1);
                                          },
                                          icon: Icon(
                                            Icons.arrow_left_rounded,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text(
                                            "${yearList[0]}-${yearList[yearList.length - 1]}",
                                            textAlign: TextAlign.center,
                                          )),
                                      //FORWARD
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            openAlertDialog(currentMonth, yearList[yearList.length-1].toString(), 1);
                                          },
                                          icon: Icon(
                                            Icons.arrow_right_rounded,
                                          )),
                                    ],
                                  )),

                              //YEAR
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  for (int i = 0; i < yearList.length; i++) ...[
                                    InkWell(
                                      child: Card(
                                        elevation: 0,
                                        color: yearList[i].toString() ==
                                                currentYear
                                            ? Color(0xff0074B7)
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              yearList[i].toString(),
                                              style: TextStyle(
                                                  color:
                                                      yearList[i].toString() ==
                                                              currentYear
                                                          ? Colors.white
                                                          : Colors.black),
                                            )),
                                      ),
                                      onTap: () {
                                        int month = 0;
                                        for (int i = 0;
                                            i < monthList.length;
                                            i++) {
                                          if (currentMonth ==
                                              monthList[i].toString()) {
                                            month = i + 1;
                                            break;
                                          }
                                        }
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        openAlertDialog(currentMonth,
                                            yearList[i].toString(), 0);
                                        GetEndDate(month,
                                            int.parse(yearList[i].toString()));
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ],
                          ))
                    ],
                  ));
            });
  }
}
