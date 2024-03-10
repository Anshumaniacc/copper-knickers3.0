import 'package:chess_aah/main.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  MyBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: Duration(milliseconds: 50),
      backgroundColor: const Color.fromARGB(
          0, 255, 255, 255), // Set your desired background color
      color: Colors.grey, // Set the active item color

      height: 50, // Set the height of the navigation bar
      index: currentIndex,
      items: [
        Icon(
          Icons.home,
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.play_arrow,
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ],
      onTap: (value) async {
        if (value == currentIndex) {
        } else {
          if (value == 0) {
            await Future.delayed(Duration(milliseconds: 50));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => screenHome));
          } else if (value == 1) {
            await Future.delayed(Duration(milliseconds: 50));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => screenSpectate));
          } else if (value == 2) {
            await Future.delayed(Duration(milliseconds: 50));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => screenCreateGame));
          }
        }
      },
    );
  }
}
