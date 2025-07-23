import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/loginpage.dart';
import 'package:google_sigin/splash.dart';
import 'package:image_picker/image_picker.dart';

class picker extends StatefulWidget {
  const picker({super.key});

  @override
  State<picker> createState() => _pickerState();
}

class _pickerState extends State<picker> {
  File? _imageFile;//for store the image
  final ImagePicker _picker = ImagePicker();// for imagepicker like texteditingcontroller


  //pick image from gallery
  Future<void> _Gallery() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //pick from camera
  Future<void> _Camera() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[ ElevatedButton(onPressed: () {
            _Gallery();
          }, child: Text("Upload form gallery")),
            SizedBox(height: 16,),
            ElevatedButton(onPressed: () {
              _Camera();
            }, child: Text("Capture from Camera")),
            SizedBox(height: 10,),
            Container(
              height: 400,
              width: 400,
              child: _imageFile != null
                  ? Image.file(_imageFile!,fit: BoxFit.fill,)
                  :Center(child: Text("Please upload image")),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> login()));

            }, child: Text("Sign Out"))

          ]
        ),

      ),
    );
  }
}
