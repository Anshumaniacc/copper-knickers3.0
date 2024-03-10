import 'package:chess_aah/screens/camara_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GameForm extends StatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  var firebaseRef = FirebaseDatabase.instance.ref("matches");
  TextEditingController emailController1 = TextEditingController();
  TextEditingController emailController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController1,
            decoration: InputDecoration(labelText: 'white player'),
          ),
          SizedBox(height: 16.0),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController2,
            decoration: InputDecoration(labelText: 'black player'),
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () async {
              // Add your logic for creating the game here
              String email1 = emailController1.text;
              String email2 = emailController2.text;

              // TODO: Implement game creation logic
              String key = "$email1|$email2|${DateTime.now()}"
                  .replaceAll("@", "%")
                  .replaceAll(".", "^");
              String value = " ";

              await firebaseRef.child(key).set(value);

              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => CameraPriviewScreen()));
            },
            child: Text('Create Game'),
          ),
        ],
      ),
    );
  }
}
