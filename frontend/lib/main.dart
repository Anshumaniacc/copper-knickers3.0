import 'package:camera/camera.dart';
import 'package:chess_aah/screens/create_game.dart';
import 'package:chess_aah/screens/home_page.dart';
import 'package:chess_aah/screens/landing_page.dart';
import 'package:chess_aah/screens/spectate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String? email;
String? password;
late List<CameraDescription> cameras;
late HomePage screenHome;
late SpectatePage screenSpectate;
late CreateGame screenCreateGame;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  cameras = await availableCameras();
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: MaterialApp(
      theme: ThemeData.dark(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong !!!"),
            );
          } else if (snapshot.hasData) {
            bool isemailVerified =
                FirebaseAuth.instance.currentUser!.emailVerified;

            print(isemailVerified);
            print(FirebaseAuth.instance.currentUser!.email);

            if (isemailVerified) {
              final container = ProviderScope.containerOf(context);

              return const HomePage();
            } else {
              return const LandingPage();
            }
          }

          return const LandingPage();
        },
      ),
    ),
  ));
}
