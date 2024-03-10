import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/screens/spectate.dart';
import 'package:chess_aah/widgits/gameForm.dart';
import 'package:chess_aah/widgits/myBottomNevigationBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateGame extends StatelessWidget {
  const CreateGame({super.key});

  @override
  Widget build(BuildContext context) {
    var dataBaseRef = FirebaseDatabase.instance.ref("matches");
    return Center(
      child: GameForm(),
    );
  }
}
