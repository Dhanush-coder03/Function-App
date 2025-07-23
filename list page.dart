import 'package:flutter/material.dart';
import 'package:google_sigin/imagepicker.dart';
import 'package:google_sigin/notes.dart';
import 'package:google_sigin/share.dart';
import 'package:google_sigin/splash.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {

  int _index1 = 0;

  final pages =[
    share(),
    picker(),


  ];

void tap(index){
setState(() {
_index1 = index;
});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: pages[_index1],
        bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: "menu"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "settings")
        ],
          currentIndex: _index1,
          onTap: tap,
        
        ),
    );

  }
}
