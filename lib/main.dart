import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/upload.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentindex = 0;

  List tabs = [
    home(),
    upload(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Legacy Learning",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("legacy learning"),
          ),
          body: tabs[currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.upload), label: "upload")
            ],
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            },
          ),
        ));
  }
}
