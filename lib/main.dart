import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Reminder 🎂',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Birthday Reminder 🎂'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  HashMap birthmonthMap = new HashMap<int, dynamic>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController birthdatTextController = TextEditingController();
  var monthsList = [
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

  final _nameKey = GlobalKey<FormState>();

  void _storeRecord(name, date) {
    setState(() {
      _counter++;
    });
  }

  //store  birthday
  void storeBirthday() {}

  //verify the month of the input from uaser
  bool verifyMonth(date) {
    try {
      if (date.length >= 10) {
        var day = int.parse(date[0] + date[1]);
        var month = int.parse(date[3] + date[4]);
        var year = int.parse(date[6] + date[7] + date[8] + date[9]);

        if (day > 0 && day < 32 && month > 0 && month < 13) {
          var birthdate = DateTime.utc(year, month, day);
          DateTime todayDate = DateTime.now();
          print("day: ");
          print(birthdate);
          print(day);
          print(month);
          print(year);
          print(todayDate);
          if (birthdate.isBefore(todayDate)) {
            print("here we go");
            return true;
          } else {
            print('Could not input future birthday!');
          }
        } else {
          print("Date/Month input is incorrect");
          return false;
        }
      } else {
        return false;
      }
    } on Exception {
      print('Format error!');
      return false;
    }
    //if (int.parse(day)) {}
    return false;
  }

  bool verifyNameNotEmpty(name) {
    if (name != null && name != "") {
      return true;
    }
    return false;
  }

  void _processInput() {
    if (verifyNameNotEmpty(nameTextController.text) &&
        verifyMonth(birthdatTextController.text)) {
      nameTextController.text = "";
      birthdatTextController.text = "";
      showAlertDialog(
          context, "Submitted", "Thank you. The record is submitted");
    } else {
      showAlertDialog(context, "Error",
          "Input is incorrect. Name could not be null and birthday should be in DD/MM/YYYY format.");
    }
  }

  showAlertDialog(BuildContext context, title, text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 450,
                child: Column(children: <Widget>[
                  Text(
                    'Birthdays',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    monthsList[index],
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )));
                        }),
                  )
                ])),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'New Record',
                  style: Theme.of(context).textTheme.headline4,
                )),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 200.0,
              child: TextFormField(
                controller: nameTextController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username'),
              ),
            ),
            Container(
              width: 200.0,
              child: TextFormField(
                controller: birthdatTextController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Year(DD/MM/YYYY)'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _processInput,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
