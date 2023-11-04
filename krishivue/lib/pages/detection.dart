import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DetectionPage extends StatefulWidget {
 const DetectionPage({Key? key, required this.picture}) : super(key: key);
  final XFile? picture;
  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detection of Diseases"),

      ),
      body:Center(
        child:CircularProgressIndicator()
        
        )
    );
  }
}