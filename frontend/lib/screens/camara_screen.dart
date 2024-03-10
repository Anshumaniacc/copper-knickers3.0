import 'package:camera/camera.dart';
import 'package:chess_aah/main.dart';
import 'package:flutter/material.dart';

class CameraPriviewScreen extends StatefulWidget {
  const CameraPriviewScreen({super.key});

  @override
  State<CameraPriviewScreen> createState() => _CameraPriviewScreenState();
}

class _CameraPriviewScreenState extends State<CameraPriviewScreen> {
  late CameraController cameraController;
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Camerra access denied")));
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Something weent wrong error messege (${e.toString()})")));
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(cameraController),
    );
  }
}
