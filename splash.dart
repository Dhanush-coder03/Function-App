
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/SignIn.dart';
import 'package:google_sigin/list%20page.dart';

import 'package:google_sigin/loginpage.dart';

import 'Home.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState(){
    Future.delayed(Duration(seconds: 3),()
    {
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pages()));
      }
      else {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login()));
      }
    }
    );
    // super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Notes",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
