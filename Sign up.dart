import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sigin/list%20page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final key = GlobalKey<FormState>();

  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> Signuup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail.text.trim(),
        password: password.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pages()),
      );
    } catch (e) {
      print("Signup failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign Up")),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                height: 240,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: mail,
                        decoration: InputDecoration(
                          labelText: "Enter Your Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Enter email";
                          }
                          if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                              .hasMatch(input)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Enter Your Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Enter password";
                          }
                          if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$')
                              .hasMatch(input)) {
                            return "Password is too weak";
                          }
                          return null;
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          Signuup();
                        }
                      },
                      child: Text("Sign Up"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
