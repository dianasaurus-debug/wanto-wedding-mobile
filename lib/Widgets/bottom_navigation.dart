
import 'dart:io';

import 'package:dream_wedding_app/Screens/booking_screen.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:dream_wedding_app/Screens/jasa_screen.dart';
import 'package:dream_wedding_app/Screens/katalog_screen.dart';
import 'package:dream_wedding_app/Screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List _widgetOptions = [
    HomeScreen(),
    JasaScreen(),
    KatalogScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState

  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Color(0xff80cbc4),
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              backgroundColor: Colors.grey,
              activeIcon: Icon(Icons.home, color: Color(0xff80cbc4), size: 32),
              label : 'Beranda'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notes, color: Colors.black),
              backgroundColor: Colors.grey,
                activeIcon: Icon(Icons.notes, color: Color(0xff80cbc4), size: 32),
                label : 'Vendor'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book, color: Colors.black),
              backgroundColor: Colors.grey,
                activeIcon: Icon(Icons.book, color: Color(0xff80cbc4), size: 32),
                label : 'Katalog'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              backgroundColor: Colors.grey,
                activeIcon: Icon(Icons.person, color: Color(0xff80cbc4), size: 32),
                label : 'Profil'
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    );
  }
}
