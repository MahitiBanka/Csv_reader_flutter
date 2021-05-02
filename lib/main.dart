import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> value;
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose csv file"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                //print("ok");
                FilePickerResult result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  PlatformFile file = result.files.first;

                  final input = File(file.path).openRead();
                  print(input);
                  final fields = await input
                      .transform(utf8.decoder)
                      .transform(CsvToListConverter())
                      .toList();

                  setState(() {
                    value = fields;
                    done = true;
                  });

                  print(fields);
                }
              },
              //},
              child: Text("choose file"),
            ),
            // Container(
            //   child:
            //       (done == true) ? Text("this is ${value[0][0]}") : Text("hi"),
            // )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
