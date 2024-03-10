import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SearchWidgit extends StatefulWidget {
  const SearchWidgit({super.key});

  @override
  State<SearchWidgit> createState() => _SearchWidgitState();
}

class _SearchWidgitState extends State<SearchWidgit> {
  String searchedString = "";
  var firebaseData = FirebaseDatabase.instance.ref("usernames");
  var TextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
          child: Column(
        children: [
          Text(
            "Search",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
              controller: TextController,
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: const EdgeInsets.all(8),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  searchedString = TextController.text.trim();
                  print(searchedString);
                });
              },
              child: Text("Search", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ThemeData.dark().primaryColor))),
          searchedString.trim() == ""
              ? Container(
                  height: 200,
                  child: Center(
                      child: Text(
                    " Wanna Search your friend by email",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(111, 255, 255, 255)),
                  )),
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  child: FirebaseAnimatedList(
                      scrollDirection: Axis.vertical,
                      query: firebaseData,
                      itemBuilder: ((context, snapshot, animation, index) {
                        if (snapshot.key!.toString().contains(searchedString
                            .replaceAll(".", "^")
                            .replaceAll('@', "%"))) {
                          return ListTile(
                            trailing: IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () async {
                                await FirebaseDatabase.instance
                                    .ref("following")
                                    .child(email
                                        .toString()
                                        .replaceAll(".", "^")
                                        .replaceAll('@', "%"))
                                    .child(snapshot.key.toString())
                                    .set("active");
                              },
                            ),
                            subtitle: Text(
                              snapshot.key
                                  .toString()
                                  .replaceAll("^", ".")
                                  .replaceAll('%', "@"),
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(70, 255, 255, 255)),
                            ),
                            title: Text(
                              snapshot.child("user_name").value.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }
                      })),
                )
        ],
      )),
    );
  }
}
