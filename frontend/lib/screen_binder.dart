import 'package:chess_aah/main.dart';
import 'package:chess_aah/widgits/myBottomNevigationBar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ScreenBinder extends StatefulWidget {
  const ScreenBinder({super.key});

  @override
  State<ScreenBinder> createState() => _ScreenBinderState();
}

class _ScreenBinderState extends State<ScreenBinder> {
  var screenIndex = 0;
  @override
  Widget build(BuildContext context) {
    String text = "";
    if (screenIndex == 0) {
      text = "Home";
    } else if (screenIndex == 1) {
      text = "Spectate";
    } else if (screenIndex == 2) {
      text = "Create Game";
    }

    Widget? myBody;
    if (screenIndex == 0) {
      myBody = screenHome;
    } else if (screenIndex == 1) {
      myBody = screenSpectate;
    } else if (screenIndex == 2) {
      myBody = screenCreateGame;
    }
    return Scaffold(
      appBar: AppBar(title: Text(text), actions: [
        CircleAvatar(
          backgroundColor: Colors.amber,
        )
      ]),
      bottomNavigationBar: GNav(
          gap: 8,
          onTabChange: (index) {
            if (index == screenIndex) {
            } else {
              setState(() {
                screenIndex = index;
              });
            }
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.play_arrow,
              text: "Spectate",
            ),
            GButton(
              icon: Icons.add,
              text: "Create Game",
            )
          ]),
      body: myBody,
    );
  }
}
