import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:note/pages/addNote.dart';
import 'dart:math';

import 'package:note/pages/viewNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("notes");
  List<Color> myColors = [
    Colors.yellow.shade300,
    Colors.red.shade300,
    Colors.green.shade300,
    Colors.deepPurple.shade300,
    Colors.purple.shade300,
    Colors.cyan.shade300,
    Colors.teal.shade300,
    Colors.pink.shade300,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Notes"),
          backgroundColor: Colors.purple.shade400,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                      MaterialPageRoute(builder: (context) => const AddNote()))
                  .then((value) => {setState(() {})});
            },
            child: const Icon(Icons.add, color: Colors.deepOrange),
            backgroundColor: Colors.deepPurpleAccent.shade700),
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.docs.length == 0) {
                return Center(
                    child: Container(
                        child: const AlertDialog(
                  content: Text("You have no Notes...."),
                )));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  Random random = Random();
                  Color bg = myColors[random.nextInt(4)];
                  Map data = snapshot.data?.docs[index].data() as Map;
                  DateTime mydateTime = data["created"].toDate();
                  String formatedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => Viewnote(data, formatedTime,
                                  snapshot.data!.docs[index].reference)))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Card(
                      color: bg,
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${data["title"]}",
                                style: const TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                formatedTime,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "lato",
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.docs.length,
              );
            } else {
              return const Center(
                child: SpinKitSquareCircle(
                  color: Colors.blueAccent,
                ),
              );
            }
          },
        ));
  }
}
