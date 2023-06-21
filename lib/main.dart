import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DateList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(background: Color(0xff0074B7)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  late int position = 0;
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
                            style: TextStyle(color: Colors.black),
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
    String formattedTime = DateFormat('MMM').format(date);
    print(date);

    var date1 = DateTime(year, month, 1);
    print(date1);
    String weekDays = DateFormat('EEE').format(date1);
    print(weekDays);
    for (int i = 0; i < weekList.length; i++) {
      if (weekList[i].toString() == weekDays) {
        position = i;
        break;
      }
    }
    currentMonth = formattedTime;

    setState(() {
      currentMonth;
      endDate = date.day.toInt();
    });
    print(endDate);
    GetMap(endDate, position);
  }

  TableRowList(int i) {
    dateList = hasMap[i];

    return Container(
      child: Table(
        children: [
          TableRow(children: [
            for (int j = 0; j < dateList.length; j++) ...[
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    dateList[j].day.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  )),
            ]
          ])
        ],
      ),
    );
  }

  void GetMap(int endDate, int position) {
    List<DateList> dateList = [];
    int n = 1;
    print(position);
    for (int i = 1; i <= (endDate / 6) + 1; i++) {
      dateList = [];
      int m = 1;
      for (int j = n; j <= (i == 1 ? 1 : 6 + n); j++) {
        if (i == 1) {
          for (int k = 0; k < 7; k++) {
            if (k < position) {
              DateList list = DateList('', '', '');
              dateList.add(list);
            } else {
              DateList list = DateList(m.toString(), '', '');
              dateList.add(list);
              m += 1;
            }
          }
        } else {
          DateList list = DateList(endDate >= j ? j.toString() : "", "", "");
          dateList.add(list);
        }

        hasMap[i] = dateList;
      }
      n += i == 1 ? m - 1 : 7;
    }
    setState(() {
      hasMap;
    });
    print(hasMap);
  }
}
