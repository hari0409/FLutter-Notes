import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Viewnote extends StatefulWidget {
  late final Map data;
  late final String time;
  final DocumentReference ref;
  Viewnote(this.data, this.time, this.ref);
  @override
  _ViewnoteState createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  late String title;
  late String desc;
  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  void save() async {
    await widget.ref.update({"title": title, "description": desc});
    setState(() {
      edit = !edit;
    });
  }

  @override
  Widget build(BuildContext context) {
    title = widget.data["title"];
    desc = widget.data["description"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: const Text("View Note"),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade400),
                  onPressed: () {
                    delete();
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ],
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
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        initialValue: widget.data["title"],
                        enabled: edit,
                        maxLines: 2,
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Cant be empty!..";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: "lato",
                            color: Colors.white),
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
                              fontSize: 20.0,
                              fontFamily: "lato",
                              color: Colors.white),
                          onChanged: (_val) {
                            desc = _val;
                          },
                          initialValue: widget.data["description"],
                          enabled: edit,
                          maxLines: 20,
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Cant be empty!..";
                            } else {
                              return null;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: edit
          ? FloatingActionButton(
              onPressed: () {
                save();
              },
              child: const Icon(Icons.save),
            )
          : null,
    );
  }
}
