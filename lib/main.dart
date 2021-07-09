import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Reminder',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Birthday Reminder'),
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
  TextEditingController nameTextController = TextEditingController();
  TextEditingController birthdatTextController = TextEditingController();

  final _nameKey = GlobalKey<FormState>();

  void _storeRecord(name, date) {
    setState(() {
      _counter++;
    });
  }

  void _incrementCounter() {
    print(DateFormat.yMd().parse(birthdatTextController.text));
    print(nameTextController.text + birthdatTextController.text);
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
                height: 350,
                child: Column(children: <Widget>[
                  Text('Birthdays'),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return Text((index + 1).toString());
                        }),
                  )
                ])),
            Text(
              'New Record',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
