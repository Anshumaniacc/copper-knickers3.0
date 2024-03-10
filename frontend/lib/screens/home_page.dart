import 'dart:ffi';

import 'package:chess_aah/screens/create_game.dart';
import 'package:chess_aah/main.dart';
import 'package:chess_aah/screens/spectate.dart';
import 'package:chess_aah/widgits/myBottomNevigationBar.dart';
import 'package:chess_aah/widgits/past_match_card.dart';
import 'package:chess_aah/widgits/win_percentage_widgit.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

double? Scwidth;

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Scwidth = MediaQuery.of(context).size.width;
    var dataBaseSnapshot = FirebaseDatabase.instance;
    var userNameSnapshot = FirebaseDatabase.instance
        .ref("usernames")
        .child(email!.replaceAll(".", "^").replaceAll("@", "%"));
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Scwidth,
            height: 200,
            child: Center(
              child: FirebaseAnimatedList(
                  query: userNameSnapshot,
                  itemBuilder: (ctx, snapShot, animation, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Hello!",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              snapShot.value.toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          StreamBuilder(
              stream: dataBaseSnapshot
                  .ref("win_percent")
                  .child(email!.replaceAll(".", "^").replaceAll("@", "%"))
                  .onValue,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    double ovrWin = double.parse(snapshot.data!.snapshot
                            .child("overall/win")
                            .value
                            .toString()) /
                        100;
                    final blackWin = double.parse(snapshot.data!.snapshot
                            .child("black/win")
                            .value
                            .toString()) /
                        100;
                    final whiteWin = double.parse(snapshot.data!.snapshot
                            .child("white/win")
                            .value
                            .toString()) /
                        100;
                    return WinPercentage(
                        blackWin: blackWin,
                        overallWin: ovrWin,
                        whiteWin: whiteWin);
                  } catch (e) {
                    return Container(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                            child: Text(
                          "Not enough  matches yet ",
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: const Color.fromARGB(120, 255, 255, 255)),
                        )));
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })),
          SizedBox(
            height: 10,
          ),
          Text(
            "Recent Matches",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: Scwidth,
            height: 400,
            child: FirebaseAnimatedList(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                query: dataBaseSnapshot
                    .ref("recent_matches")
                    .child(email!.replaceAll(".", "^").replaceAll("@", "%")),
                itemBuilder: (ctx, dataSnapshot, animation, index) {
                  var opponent = dataSnapshot.key
                      .toString()
                      .replaceAll("%", "@")
                      .replaceAll("^", ".");
                  var result = dataSnapshot.child("result").value.toString();
                  var moves = dataSnapshot.child("moves").value.toString();
                  var historySnapshot = dataBaseSnapshot
                      .ref("past_matches")
                      .child(email!.replaceAll(".", "^").replaceAll("@", "%"))
                      .child(dataSnapshot.key!)
                      .once();

                  return FutureBuilder(
                      future: historySnapshot,
                      builder: (ctx, snapShot) {
                        String? tWon;
                        String? tLost;
                        String? tDraw;

                        if (snapShot.data != null) {
                          tWon = snapShot.data!.snapshot
                              .child("won")
                              .value
                              .toString();

                          tLost = snapShot.data!.snapshot
                              .child("lost")
                              .value
                              .toString();
                          tDraw = snapShot.data!.snapshot
                              .child("won")
                              .value
                              .toString();

                          return PastMatchMatchCard(
                              opponent: opponent,
                              moves: moves,
                              result: result,
                              tdraw: tDraw,
                              tlsot: tLost,
                              twon: tWon);
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                }),
          )
        ],
      ),
    );
  }
}
