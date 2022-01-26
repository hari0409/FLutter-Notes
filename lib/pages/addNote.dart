import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String desc;
  void add(String title, String desc) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("notes");
    var data = {
      "title": title,
      "description": desc,
      "created": DateTime.now(),
    };
    ref.add(data);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: const Text("Create your Note"),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
            child: ElevatedButton.icon(
              onPressed: () {
                add(title, desc);
              },
              icon: const Icon(Icons.save),
              label: const Text("Save"),
            ),
          )
        ],
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration.collapsed(hintText: "Title"),
                      style: const TextStyle(
                          fontSize: 28.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      onChanged: (_val) {
                        title = _val;
                      },
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                        decoration: const InputDecoration.collapsed(
                            hintText: "Description"),
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: "lato",
                            color: Colors.white),
                        onChanged: (_val) {
                          desc = _val;
                        },
                        maxLines: 20,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
