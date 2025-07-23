import 'package:flutter/material.dart';
import 'package:google_sigin/list%20page.dart';
import 'package:google_sigin/share.dart';


class result extends StatefulWidget {
  String next;
  result({super.key, required this.next});

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Details",style: TextStyle(color: Colors.white),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(widget.next),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> Pages()));
          }, child: Text("Back"))
        ],
      )

    );
  }
}
