import 'package:flutter/material.dart';
import 'package:google_sigin/route.dart';
import 'package:google_sigin/themep.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class share extends StatefulWidget {
  const share({super.key});

  @override
  State<share> createState() => _shareState();
}

class _shareState extends State<share> {
  List<String> items = [];

  final _key = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController edit = TextEditingController();

  void additem() {
    String NAME = name.text;
    String PASSWORD = pass.text;
    String MAIL = email.text;
    String MOBILE = mobile.text;

    String entry = "Name   : $NAME\n"
        "Pass   : $PASSWORD\n"
        "Mail   : $MAIL\n"
        "Mobile : $MOBILE";

    items.add(entry);
    setState(() {});
  }

  void list() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', items);
    setState(() {});
  }

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    items = await prefs.getStringList('items') ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }


  void Route(String data) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => result(next: data)),
    ).then((edit) {
      if (edit != null) {
        setState(() {
          int index = items.indexWhere((element) => element == data);
          if (index != -1) {
            items[index] = edit;
            list(); // Save changes
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
        title: Text("Notes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext, index) {
                return GestureDetector(
                  onTap: () => Route(items[index]),
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items[index],
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext) {
                                    edit.text = items[index];
                                    return AlertDialog(
                                      title: TextFormField(
                                        controller: edit,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              items[index] = edit.text;
                                              Navigator.pop(context);
                                            });
                                            list();
                                          },
                                          child: Text("Update"),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: [
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: name,
                          decoration:
                          InputDecoration(labelText: "Enter Your Name"),
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              print("Enter Valid Name");
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: pass,
                          decoration:
                          InputDecoration(labelText: "Enter Your Password"),
                          validator: (input) {
                            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(input!)) {
                              print("Enter Valid Password");
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: email,
                          decoration:
                          InputDecoration(labelText: "Enter Your Mail"),
                          validator: (input) {
                            if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                                .hasMatch(input!)) {
                              return null;
                            }
                          },
                        ),
                        TextFormField(
                          controller: mobile,
                          decoration: InputDecoration(
                              labelText: "Enter Your Mobile Number"),
                          validator: (input) {
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(input!)) {
                              print("Enter Valid Mobile Number");
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              Navigator.pop(context);
                              additem();
                            }
                            list();
                          },
                          child: Text("Update"),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
