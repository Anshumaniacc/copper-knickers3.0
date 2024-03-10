import 'package:chess_aah/main.dart';
import 'package:chess_aah/screens/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FriendsWidgit extends StatelessWidget {
  FriendsWidgit({super.key});
  final firebaseDatabse = FirebaseDatabase.instance;

  Future<String> FetchUsername(String mail) async {
    var FirebaseSnapshot =
        await firebaseDatabse.ref("usernames").child(mail).get();
    String name = FirebaseSnapshot.child("user_name").value.toString();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    print(email);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: FirebaseAnimatedList(
            physics: NeverScrollableScrollPhysics(),
            query: firebaseDatabse
                .ref("following")
                .child(email!.replaceAll("@", "%").replaceAll(".", "^")),
            itemBuilder: (context, snapshot, animation, index) {
              String mail = snapshot.key.toString();

              return FutureBuilder(
                  future: FetchUsername(mail),
                  builder: (ctx, snap) {
                    if (snap.hasData || snap.data != null) {
                      print(snap.data);
                      return Card(
                          child: ListTile(
                        trailing: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye_sharp,
                              color: Color.fromARGB(118, 255, 255, 255),
                            ),
                            onPressed: () {
                              String name = snap.data.toString();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ProfilePage(
                                            name: name,
                                            mail: mail
                                                .replaceAll("%", "@")
                                                .replaceAll("^", "."),
                                          )));
                            }),
                        title: Text(snap.data.toString()),
                        leading: CircleAvatar(backgroundColor: Colors.blue),
                        subtitle: Text(
                            mail.replaceAll("%", "@").replaceAll("^", "."),
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(78, 255, 255, 255))),
                      ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            },
          ),
        ),
      ),
    );
  }
}
