// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:krishivue/pages/camerapage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:async';
// import 'dart:io';
// import "package:krishivue/widgets/bottomnavbar.dart";
// import 'package:krishivue/pages/detection.dart';
// import 'package:krishivue/widgets/app_bar.dart';
// import 'package:krishivue/widgets/nav_drawer.dart';

// class Landing extends StatefulWidget {
//   @override
//   State<Landing> createState() => LandingState();
// }

// class LandingState extends State<Landing> {
//   File? uploadimage; //variable for choosed file
//   int currentPageIndex = 0;
//   Future<void> chooseImage() async {
//     var choosedimage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     // print(choosedimage);
//     //set source: ImageSource.camera to get image from camera
//     setState(() {
//       uploadimage = File(choosedimage!.path);
//       print(uploadimage);
//     });
//   }

//   void uploadImage() {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => DetectionPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedIndex: currentPageIndex,
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: Colors.red,
//         destinations: const <NavigationDestination>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.info_outlined),
//             label: 'Business',
//           ),
//           // NavigationDestination(

//           //   icon: Icon(Icons.info_outlined),
//           //   label: 'School',
//           // ),
//         ],
//       ),
//       drawer: NavDrawer(),
//       appBar: CustomAppBar(title: "Home"),
//       body: SafeArea(
//         bottom: true,
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.82,
//           width: MediaQuery.of(context).size.width * 1,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//             image: AssetImage(
//               'assets/back.jpg',
//             ),
//             fit: BoxFit.fill,
//             colorFilter: ColorFilter.mode(
//               Colors.black.withOpacity(
//                   0.15), // Adjust opacity here (0.5 for 50% transparency)
//               BlendMode.dstATop, // This blend mode makes the image transparent
//             ),
//           )),
//           child: Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                      height: MediaQuery.of(context).size.height * 0.82*0.7,
//                       width: MediaQuery.of(context).size.width * 1,
//                     //show image here after choosing image
//                     child: Center(
//                   child: uploadimage == null
//                       ? Text(
//                           "Select Image using one of the icon",
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         )
//                       : //if uploadimage is null then show empty container
//                      // Container(
                     
//                            Image.file(uploadimage!),
//                           //child:Image.file(uploadimage!) //load image from file
//                           //)
//                     //),
//                 )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                     //show upload button after choosing image
//                     child: uploadimage == null
//                         ? Container()
//                         : //if uploadimage is null then show empty container
//                         Container(
//                           height: 40,
//                             //elese show uplaod button
//                             child: ElevatedButton.icon(
//                             onPressed: () {
//                               uploadImage();
//                               //start uploading image
//                             },
//                             icon: Icon(
//                               Icons.file_upload,
//                               size: 40,
//                             ),
//                             label: Text("UPLOAD IMAGE"),

//                             //set brghtness to dark, because deepOrangeAccent is darker coler
//                             //so that its text color is light
//                           ))),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                         // height: 50,
//                         // width: 50,
//                         color: Colors.blueGrey,
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: <Widget>[
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     await availableCameras().then((value) =>
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     CameraPage(
//                                                         cameras: value))));
//                                   },
//                                   child: Icon(
//                                     Icons.camera,
//                                     size: 80, // Adjust the size as needed
//                                     color:
//                                         Colors.white, // Specify the icon color
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           15), // Adjust the radius as needed
//                                     ),
//                                   ),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     await chooseImage(); // call choose image function
//                                   },
//                                   child: Icon(
//                                     Icons.file_upload,
//                                     size: 80,
//                                     color: Colors.white,
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           15), // Adjust the radius as needed
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// //THIS IS THE SECOND METHOD IN WHICH I WILL HAVE THE FUNCTIONALITY OF DISAPPEARNING AND REAPPEARNING NAVBAR



import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:krishivue/pages/camerapage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivue/ui/home_view.dart';
import 'dart:async';
import 'dart:io';
import "package:krishivue/widgets/bottomnavbar.dart";
import 'package:krishivue/pages/detection.dart';
import 'package:krishivue/widgets/app_bar.dart';
import 'package:krishivue/widgets/nav_drawer.dart';
import "package:krishivue/pages/previewgallery.dart";

class Landing extends StatefulWidget {
  @override
  State<Landing> createState() => LandingState();
}

class LandingState extends State<Landing> {
  File? uploadimage; // variable for the chosen file
  int currentPageIndex = 0;
  bool showBottomNavBar = true; // initially show the bottom navigation bar

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  void uploadImage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewGalleryPage(picture:uploadimage!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Home"),
      body: SafeArea(
        child: GestureDetector(
        //  // Wrap the entire content with a GestureDetector
        //   onTap:() {
        //     setState(() {
        //       // Toggle the visibility of the bottom navigation bar
        //       showBottomNavBar = !showBottomNavBar;
        //     });
        //   },
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                // Your background image and content here
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/back.jpg',
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(
                          0.15), // Adjust opacity here (0.5 for 50% transparency)
                      BlendMode.dstATop, // This blend mode makes the image transparent
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.82 * 0.8,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Center(
                          child: uploadimage == null
                              ? Text(
                                  "Select Image using one of the icons",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              : Image.file(uploadimage!),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: uploadimage == null
                            ? Container()
                            : Container(
                                height: 40,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  icon: Icon(
                                    Icons.file_upload,
                                    size: 40,
                                  ),
                                  label: Text("UPLOAD IMAGE"),
                                ),
                              ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.blueGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () async {
                                      // await availableCameras().then((value) =>
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 CameraPage(cameras: value))));

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
                                    },
                                    child: Icon(
                                      Icons.camera,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await chooseImage();
                                    },
                                    child: Icon(
                                      Icons.file_upload,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (showBottomNavBar) // Conditionally render the bottom navigation bar
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: CustomBottomNavigationBar(
              //     //   selectedIndex: currentPageIndex,
              //     //   onDestinationSelected: (int index) {
              //     //     setState(() {
              //     //       currentPageIndex = index;
              //     //     });
              //     //   },
              //     //   indicatorColor: Colors.red,
              //     //   destinations: const <NavigationDestination>[
              //     //     NavigationDestination(
              //     //       selectedIcon: Icon(Icons.home),
              //     //       icon: Icon(Icons.home_outlined),
              //     //       label: 'Home',
              //     //     ),
              //     //     NavigationDestination(
              //     //       icon: Icon(Icons.info_outlined),
              //     //       label: 'Business',
              //     //     ),
              //     //     // Add more NavigationDestinations as needed
              //     //   ],
              //      ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
