// custom_bottom_navigation_bar.dart

import 'package:flutter/material.dart';
import 'package:krishivue/pages/landing.dart';
import 'package:krishivue/pages/about.dart';


class CustomBottomNavigationBar extends StatefulWidget {
 

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
   bool showBottomNavBar = true; // initially show the bottom navigation bar
int _selectedIndex = 0;
 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _pages = [
    Landing(),
    AboutUs()
    
  
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: SafeArea(
      child:GestureDetector(
        onTap:() {
            setState(() {
              // Toggle the visibility of the bottom navigation bar
              showBottomNavBar = !showBottomNavBar;
            });
          },
       child: Stack(
          children:[
            Container(
              child:_pages[_selectedIndex]
              ),
              if(showBottomNavBar)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
              
                BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
                backgroundColor: Colors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Colors.pink,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
               )
          ]
       ),
     )
     )
    );
    
  }
}
