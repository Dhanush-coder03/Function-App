import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/Home.dart';
import 'package:google_sigin/list%20page.dart';
import 'package:google_sigin/list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Sign up.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final key1 = GlobalKey<FormState>();

  TextEditingController mail1 = TextEditingController();
  TextEditingController pass1 = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        "1010996261324-t8bsq0e2g8n9osi2j5q8aceg57dt9o20.apps.googleusercontent.com",
  );

  //  Google SignIn
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Pages()));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed")),
      );
    }
  }

  // Email/Password Login
  Future<void> Login() async {
    if (key1.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail1.text.trim(),
          password: pass1.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Pages()),
        );
      } catch (e) {
        print("Login error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed. Check Email/Password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Center(child: Text("Login Page")),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
           image: DecorationImage(
               image: AssetImage("assets/back.jpg"),
                   fit: BoxFit.fill,
           )
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imge.jpg"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur (sigmaX: 6.0,sigmaY: 6.0,),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: key1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: mail1,
                                decoration: InputDecoration(
                                  labelText: "Enter Your Mail",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter email";
                                  }
                                  return null;
                                },
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: pass1,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Enter Your Password",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter password";
                                  }
                                  return null;
                                },
                              ),
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: Login, child: Text("Login")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()),
                                      );
                                    },
                                    child: Text("Sign Up")),
                              ],
                            ),

                            SizedBox(height: 10),


                            ElevatedButton(
                                onPressed: signInWithGoogle,
                                child: Text("SignIn With Google"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
