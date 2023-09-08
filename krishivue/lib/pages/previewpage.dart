import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:krishivue/pages/detection.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
 void uploadImage(){
Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetectionPage(
                  
                  )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: SafeArea(
        child: 
        Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(widget.picture.path),
          
            fit: BoxFit.cover, 
             height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 1 ),
              
          ),

          const SizedBox(height: 24),

           Container(
                          //elese show uplaod button
                          child: ElevatedButton.icon(
                          onPressed: () {
                            uploadImage();
                            //start uploading image
                          },
                          icon: Icon(Icons.file_upload,
                          size: 50,),
                          label: Text("UPLOAD IMAGE"),
        
                          //set brghtness to dark, because deepOrangeAccent is darker coler
                          //so that its text color is light
                        )),

        ]),
      ),
    );
  }
}