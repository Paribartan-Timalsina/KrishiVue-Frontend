import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:krishivue/pages/camerapage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
class Landing extends StatefulWidget {
 

  @override
  State<Landing> createState() => LandingState();
}

class LandingState extends State<Landing> {
    File? uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
        var choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
       // print(choosedimage);
        //set source: ImageSource.camera to get image from camera
        setState(() {
            uploadimage = File(choosedimage!.path);
            print(uploadimage);
        });
  }

  @override
  Widget build(BuildContext context) {

   
     return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(  //show image here after choosing image
                            child:
                            uploadimage == null ? 
                               Container(child: Text("There is no image"),): //if uploadimage is null then show empty container
                               Container(   //elese show image here
                                  child: SizedBox( 
                                     height:150,
                                     child:Image.file(uploadimage!),
                                     //child:Image.file(uploadimage!) //load image from file
                                  )
                               )
                        ),

                         Container( 
                            //show upload button after choosing image
                          child:uploadimage == null? 
                               Container(): //if uploadimage is null then show empty container
                               Container(   //elese show uplaod button
                                  child:ElevatedButton.icon(
                                    onPressed: (){
                                        //uploadImage();
                                        //start uploading image
                                    }, 
                                    icon: Icon(Icons.file_upload), 
                                    label: Text("UPLOAD IMAGE"),
                                    
                                    //set brghtness to dark, because deepOrangeAccent is darker coler
                                    //so that its text color is light
                                  )
                               ) 
                        ),
           ElevatedButton(
              
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CameraPage(cameras: value))));
          },
          child: Icon(
            Icons.camera,
             size: 48,      // Adjust the size as needed
      color: Colors.red,  // Specify the icon color
          )
        ),
         ElevatedButton(
              onPressed: () async {
                await chooseImage(); // call choose image function
              },
              child: Text('Pick and Upload Image'),
            ),
             
          ],
        ),
      ),
    );
  }
}




