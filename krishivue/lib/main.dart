import 'package:flutter/material.dart';
import 'package:krishivue/pages/intro.dart';
import 'package:krishivue/pages/landing.dart';
import "package:krishivue/widgets/bottomnavbar.dart";
import 'package:flutter/services.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      "/":(context)=>SplashScreen(),
      '/landing':(context)=>CustomBottomNavigationBar(),
      
      

    },
  ));
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../pages/home_view.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Object Detection TFLite',
      
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home:SafeArea(child: HomeView(),)
       
//     );
//   }
// }




























// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../ui/home_view.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         title: 'Live Object Detection TFLite',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: const HomeView(),
//       );
// }