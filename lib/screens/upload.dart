import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';

class upload extends StatefulWidget {
  const upload({super.key});

  @override
  State<upload> createState() => _uploadState();
}


class _uploadState extends State<upload> {
  TextEditingController projectname=TextEditingController();
   TextEditingController teamname=TextEditingController();
    TextEditingController domainname=TextEditingController();
 

FirebaseFirestore firestoreinstance=FirebaseFirestore.instance;
void selectImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png'],
  );

  if (result != null) {
    File imageFile = File(result.files.first.path!);
    String imagePath = imageFile.path.split('/').last;

    uploadImageFile(await imageFile.readAsBytes(), imagePath);
  }
}

var image_url;
Future<String> uploadImageFile(Uint8List imageBytes, String imagePath) async {
  final storage = FirebaseStorage.instance;
  final Reference ref = storage.ref().child(imagePath);
  final UploadTask uploadTask = ref.putData(imageBytes);

 // final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
image_url=await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
 // return downloadUrl.ref.getDownloadURL();
 return image_url;
}


finalupload(){
  var data={
    "project_name": projectname.text,
    "team_name":teamname.text, 
    "domain_name":domainname.text,
    "image_url":image_url.toString(),
}; 

firestoreinstance.collection("project").doc().set(data);
}



  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ElevatedButton(onPressed: ()=>selectImage(),
        child: Text("select image"),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
            controller: projectname,
            decoration: InputDecoration(hintText: "Enter project title" ,),
          ),
          ),
            Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
              controller: teamname,
            decoration: InputDecoration(hintText: "Enter  the name of teammates" ,),
          ),
          ),
            Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
              controller: domainname,
            decoration: InputDecoration(hintText: "Enter domain name" ,),
          ),
          ),
          ElevatedButton(
            onPressed: ()=>finalupload(),
             child:
              Text("upload")
             )
        ],
      ),
    );
    
  }
}