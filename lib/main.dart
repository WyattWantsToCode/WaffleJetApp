import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/calendar.dart';
import 'package:qc_collegeandcareer/month/month_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Calendar()
    );
  }
}

Widget gridTile(int index) {
  return Container(
    color: Colors.blue,
    child: Text("$index"),
  );
}


