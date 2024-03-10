import 'package:flutter/material.dart';

class WinPercentage extends StatelessWidget {
  const WinPercentage(
      {super.key,
      required this.blackWin,
      required this.overallWin,
      required this.whiteWin});
  final double overallWin;
  final double whiteWin;
  final double blackWin;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Win Percentage",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "  Overall",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
              value: overallWin,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "  White",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              value: whiteWin,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "  Black",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              value: blackWin,
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
