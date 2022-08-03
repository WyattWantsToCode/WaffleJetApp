import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';
import 'package:qc_collegeandcareer/firebase_options.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: FutureBuilder(
    future: getAppSetupFromDB(),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.hasData) {
          
          

          return const HomeScreen();
        }
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    }),
  ),
    );
  }
}
