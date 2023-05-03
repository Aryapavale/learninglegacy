import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class infopage extends StatefulWidget {
  const infopage({super.key});
 

  @override
  State<infopage> createState() => _infopageState();
}

class _infopageState extends State<infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Information"),
      ),
      body: Center(
        child: Text("this is the info"),
      ),

    );
  }
}