
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/infopage.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future getdata() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('project').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(
            child: Text('No data available.'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute
                  (builder: (context)=>infopage())),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        snapshot.data[index].data()["project_name"],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    elevation:10.0 ,
                  ),
                );
            },
          );
        }
      },
    );
  }
}
 