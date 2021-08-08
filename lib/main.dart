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
  List<List<dynamic>> data = new List.generate(12, (i) => []);
  HashMap birthmonthMap = new HashMap<int, List<dynamic>>();
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
  List<bool> monthExpandedList = List.filled(12, false);
  String tempName = "";
  int tempBDate = 0;
  int tempBMonth = 0;
  int tempBYear = 0;

  void _storeRecord(name, date) {
    setState(() {
      _counter++;
    });
  }

  //store  birthday
  void storeBirthday(day, month, year) {
    setState(() {
      data[month - 1]
          .add({"name": nameTextController.text, "day": day, "year": year});
      //sort
      data[month - 1].sort((a, b) => a["day"].compareTo(b["day"]));
    });
  }

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
          if (birthdate.isBefore(todayDate)) {
            storeBirthday(day, month, year);
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightGreen[50],
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
                              margin: EdgeInsets.all(10),
                              color: Colors.green,
                              child: ExpansionPanelList(
                                animationDuration: Duration(milliseconds: 1000),
                                children: [
                                  if (data[index].length == 0) ...[
                                    ExpansionPanel(
                                      headerBuilder: (context, isExpanded) {
                                        return ListTile(
                                            title: new Center(
                                          child: new Text(
                                            monthsList[index] +
                                                "(" +
                                                data[index].length.toString() +
                                                ")",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ));
                                      },
                                      body: ListTile(
                                          title: Center(
                                        child: Text('No birthday this month',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )),
                                      isExpanded: monthExpandedList[index],
                                      canTapOnHeader: true,
                                    ),
                                  ] else ...[
                                    ExpansionPanel(
                                      headerBuilder: (context, isExpanded) {
                                        return ListTile(
                                            title: new Center(
                                          child: new Text(
                                            monthsList[index] +
                                                "(" +
                                                data[index].length.toString() +
                                                ")",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                        ));
                                      },
                                      body: ListTile(
                                        title: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: data[index].length,
                                          itemBuilder: (context, newIndex) {
                                            return new Center(
                                                child: new Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                  new Expanded(
                                                      flex: 1,
                                                      child:
                                                          new SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Text(
                                                                "\n" +
                                                                    "Name: " +
                                                                    data[index][
                                                                            newIndex]
                                                                        [
                                                                        "name"] +
                                                                    " Birth Date: " +
                                                                    data[index][newIndex]
                                                                            [
                                                                            "day"]
                                                                        .toString() +
                                                                    " " +
                                                                    monthsList[
                                                                        index] +
                                                                    " " +
                                                                    data[index][newIndex]
                                                                            [
                                                                            "year"]
                                                                        .toString() +
                                                                    " " +
                                                                    "\n",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                                softWrap: false,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                              ))),
                                                  Flexible(
                                                      child: TextButton(
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (states.contains(
                                                            MaterialState
                                                                .focused))
                                                          return Colors.red;
                                                        return Colors
                                                            .green; // Defer to the widget's default.
                                                      }),
                                                    ),
                                                    onPressed: () {
                                                      //delete record

                                                      showTwoAlertDialog(
                                                          context,
                                                          data[index][newIndex]
                                                              ["name"]);
                                                      setState(() {
                                                        data[index]
                                                            .removeAt(newIndex);
                                                      });
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontSize: 10.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                  ))
                                                ]));
                                          },
                                        ),
                                      ),
                                      isExpanded: monthExpandedList[index],
                                      canTapOnHeader: true,
                                    ),
                                  ],
                                ],
                                dividerColor: Colors.grey,
                                expansionCallback: (panelIndex, isExpanded) {
                                  monthExpandedList[index] =
                                      !monthExpandedList[index];
                                  setState(() {});
                                },
                              ),
                            ),
                          );
                        }),
                  )
                ])),
            Container(
                margin: EdgeInsets.only(top: 20),
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

showTwoAlertDialog(BuildContext context, String name) {
  // set up the buttons
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Data deleted"),
    content: Text("This record from $name is deleted."),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
