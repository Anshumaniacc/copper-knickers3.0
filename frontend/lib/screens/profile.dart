import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.name, required this.mail});
  final String name;
  final String mail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        CircleAvatar(backgroundColor: Colors.amber, radius: 20),
                        Text(name,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Text(mail,
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(58, 255, 255, 255),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                )),
              ),
            ),
          ],
        ));
  }
}
