import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:krishivue/pages/camerapage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:krishivue/pages/detection.dart';

class Landing extends StatefulWidget {
  @override
  State<Landing> createState() => LandingState();
}

class LandingState extends State<Landing> {
  File? uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // print(choosedimage);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
      print(uploadimage);
    });
  }
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
      appBar: AppBar(title: const Text("Home Page",
      textAlign: TextAlign.center,
      ),
      centerTitle: true,),
      body: SafeArea(
        
        child:Container(
         decoration:BoxDecoration(
              image:DecorationImage(image: AssetImage('assets/back.jpg',
            
              ),
              fit:BoxFit.fill,
              
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), // Adjust opacity here (0.5 for 50% transparency)
        BlendMode.dstATop, // This blend mode makes the image transparent
          ),
              )
            ),
       child:  Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              Container(
                 height: MediaQuery.of(context).size.height * 0.6 ,
                          width: MediaQuery.of(context).size.width * 0.9 ,
                  //show image here after choosing image
                  child: Center(
                    child: uploadimage == null
                        ? Text("Select Image using one of the icon",
                        style: TextStyle(
                          fontSize: 20,
                        
                        ),)
                        : //if uploadimage is null then show empty container
                        Container(
                            //elese show image here
                           // child: Container(
                           
                  
                            child: Image.file(uploadimage!),
                            //child:Image.file(uploadimage!) //load image from file
                          //)
                          ),
                  )),
             SizedBox(height: 10,),
              Container(
                  //show upload button after choosing image
                  child: uploadimage == null
                      ? Container()
                      : //if uploadimage is null then show empty container
                      Container(
                          //elese show uplaod button
                          child: ElevatedButton.icon(
                          onPressed: () {
                            uploadImage();
                            //start uploading image
                          },
                          icon: Icon(Icons.file_upload,
                          size: 40,),
                          label: Text("UPLOAD IMAGE"),
        
                          //set brghtness to dark, because deepOrangeAccent is darker coler
                          //so that its text color is light
                        ))),
                        SizedBox(height:10),
              

                 Expanded(
                   child: Align(
                    alignment: Alignment.bottomCenter,
                     child: Container(
                      // height: 50,
                      // width: 50,
                      color: Colors.blueGrey,
                      child:
                                   
                                   Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                       
                        children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              await availableCameras().then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraPage(cameras: value))));
                            },
                            child: Icon(
                              Icons.camera,
                              size: 80, // Adjust the size as needed
                              color: Colors.red, // Specify the icon color
                            ),
                            style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
    ),
  ),
                            ),
                                   
                        ElevatedButton(
                          
                          onPressed: () async {
                            await chooseImage(); // call choose image function
                          },
                          child: Icon(
                            Icons.file_upload,
                            size: 80,
                            
                          ),
                          style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
    ),
  ),
                        ),
                      ]
                      ),
                                   )
                                   
                                   ),
                   ),
                 ),
              
            ],
          ),
        ),
        ),
      ),
    );
  }
}
