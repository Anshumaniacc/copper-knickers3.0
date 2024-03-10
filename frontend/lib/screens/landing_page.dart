import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/screens/sign_in_page.dart';
import 'package:chess_aah/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(children: [
        SizedBox(height: 100),
        Image(image: AssetImage("lib/assets/images/chess.png")),
        Text(
          "AAH!!",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
        ),
        SizedBox(
          height: 36,
        ),
        Container(
          height: 50,
          width: width - 50,
          child: FloatingActionButton(
            heroTag: "signin",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
            },
            child: Text("Sign In"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: width / 2 - 50,
              child: FloatingActionButton(
                heroTag: "signup",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SignUpPage())));
                },
                child: Text("Sign Up"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Container(
              height: 50,
              width: width / 2 - 50,
              child: FloatingActionButton(
                heroTag: "google",
                onPressed: () {},
                child: Text("Google"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text("By Continuing you agree to the Terms and Conditions")
      ]),
    );
  }
}
