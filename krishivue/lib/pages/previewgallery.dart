import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:krishivue/pages/detection.dart';
import 'package:http/http.dart' as http;

class PreviewGalleryPage extends StatefulWidget {
  const PreviewGalleryPage({Key? key, required this.picture}) : super(key: key);

  final File picture;

  @override
  State<PreviewGalleryPage> createState() => _PreviewGalleryPageState();
}

class _PreviewGalleryPageState extends State<PreviewGalleryPage> {
 void uploadImage() async {
  // Create a POST request to your Flask API endpoint
  var url = Uri.parse('YOUR_FLASK_API_ENDPOINT_URL'); // Replace with your API endpoint URL

  // Create a multipart request
  var request = http.MultipartRequest('POST', url);

  // Add the image file to the request
  var file = widget.picture;
  print("The picture is : ${file}");
  var stream = http.ByteStream(file.openRead());
  var length = await file.length();
  var multipartFile = http.MultipartFile('image', stream, length, filename: 'image.jpg');
  print("The multipart file is : ${multipartFile}");
  request.files.add(multipartFile);

  // Send the request
  var response = await request.send();

  // Check the response status code
  if (response.statusCode == 200) {
    // Request was successful
    // You can handle the response here if the server sends any data back
  } else {
    // Request failed
    print('Error: ${response.reasonPhrase}');
  }
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