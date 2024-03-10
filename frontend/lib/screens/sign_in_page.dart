import 'package:chess_aah/screen_binder.dart';
import 'package:chess_aah/screens/create_game.dart';
import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/main.dart';
import 'package:chess_aah/screens/spectate.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onSaved: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  onSaved: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      loading = true;
                      setState(() {});

                      try {
                        await firebaseAuth.signInWithEmailAndPassword(
                            email: email!.trim(), password: password!.trim());
                        screenHome = HomePage();
                        screenSpectate = SpectatePage();
                        screenCreateGame = CreateGame();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ScreenBinder()));
                        loading = false;
                      } catch (e) {
                        var messege = SnackBar(content: Text("error : $e"));
                        ScaffoldMessenger.of(context).showSnackBar(messege);
                        loading = false;
                        setState(() {});
                      }
                    }
                  },
                  child:
                      loading ? CircularProgressIndicator() : Text("Log in "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
