import "package:flutter/material.dart";
import 'package:note/controller/google_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/cover.png"))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: Text(
                "Create & Manage your Notes",
                style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: "lato",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Continue with Google",
                      style: TextStyle(fontFamily: "lato", fontSize: 18.0),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 12.0))),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
