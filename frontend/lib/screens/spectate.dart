import 'package:chess_aah/screens/create_game.dart';
import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/widgits/friends.dart';
import 'package:chess_aah/widgits/myBottomNevigationBar.dart';
import 'package:chess_aah/widgits/search.dart';
import 'package:flutter/material.dart';

class SpectatePage extends StatelessWidget {
  const SpectatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SearchWidgit(),
        Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
        ),
        FriendsWidgit()
      ],
    ));
  }
}
