import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastMatchMatchCard extends ConsumerWidget {
  final String result;
  final String moves;
  final String twon;
  final String tlsot;
  final String tdraw;
  final String opponent;
  const PastMatchMatchCard(
      {super.key,
      required this.opponent,
      required this.moves,
      required this.result,
      required this.tdraw,
      required this.tlsot,
      required this.twon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 50, left: 8, right: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(
                      image: AssetImage(
                          "lib/assets/images/Icon_ chess _king.jpeg")),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    result,
                    style: TextStyle(
                        color: result == "lsot" ? Colors.red : Colors.green),
                  ),
                  SizedBox(width: 8),
                  Text(
                    moves,
                    style: TextStyle(
                        color: const Color.fromARGB(105, 158, 158, 158),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  Text(
                    " Moves",
                    style: TextStyle(
                        fontSize: 10,
                        color: const Color.fromARGB(105, 158, 158, 158)),
                  )
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Text(
                    opponent,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    child: Center(child: Text(twon)),
                    width: 50,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.green),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    child: Center(child: Text(tlsot)),
                    width: 50,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.red),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    child: Center(child: Text(tdraw)),
                    width: 50,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
