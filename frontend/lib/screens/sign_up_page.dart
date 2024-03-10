import 'package:chess_aah/screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fiebaseSetUserName = FirebaseDatabase.instance.ref("usernames");
    final fireAuth = FirebaseAuth.instance;
    final _passController = TextEditingController();
    final _passAgainController = TextEditingController();
    final _emailController = TextEditingController();
    final _userNameController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  "Make you AAH! Account ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.contains("@") || value.contains(".com")) {
                      return null;
                    } else {
                      return "Please enter a valid mail";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Mail",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      hintText: "Unique Username",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  validator: (value) {
                    if (value != _passAgainController.text) {
                      return "Please enter same password in both fields";
                    } else {
                      return null;
                    }
                  },
                  controller: _passController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                TextFormField(
                  controller: _passAgainController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: "Enter your password again ",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        fireAuth
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim())
                            .then((value) {
                          fiebaseSetUserName
                              .child(_emailController.text
                                  .trim()
                                  .replaceAll("@", "%")
                                  .replaceAll(".", "^"))
                              .set({
                            "user_name": _userNameController.text.trim()
                          });
                          fireAuth.signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passAgainController.text.trim());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const LandingPage()));
                        }).onError((error, stackTrace) {
                          var snackBar = SnackBar(
                            content: Text(error.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: const Text("Sign Up"))
              ],
            )),
      ),
    );
  }
}
