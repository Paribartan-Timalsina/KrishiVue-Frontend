import 'package:flutter/material.dart';
import 'package:krishivue/pages/landing.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Delay navigation to the landing screen by 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(), // Replace with your landing screen widget
        ),
      );
    });

    // Start the fade-in animation
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //backgroundColor: Colors.grey[300],
      body:SafeArea(
        
        //padding: const EdgeInsets.fromLTRB(0.5,0.5,0.5,0.5),
        child: Container(
          width: MediaQuery.of(context).size.width * 1, // 100% of the screen width
          height: MediaQuery.of(context).size.height * 1, // 100% of the screen height
         decoration:BoxDecoration(
              image:DecorationImage(image: AssetImage('assets/back.jpg',
            
              ),
              fit:BoxFit.fill,
              
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), // Adjust opacity here (0.5 for 50% transparency)
        BlendMode.dstATop, // This blend mode makes the image transparent
          ),
              )
            ),
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),// Adjust the animation duration
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            
             ClipOval(
              child: Container(
                width: 400, // Adjust the width and height as needed
                height:400,
                color: Colors.transparent, // Set a transparent color to avoid clipping issues
                child: Center(
                  child: Image.asset(
                    'assets/logo.png', // Replace with your image path
                    fit: BoxFit.cover, // You can adjust the BoxFit property as needed
                  ),
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
