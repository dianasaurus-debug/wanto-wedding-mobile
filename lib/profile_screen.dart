import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Widgets/profile_menu.dart';
import 'package:dream_wedding_app/Widgets/profile_pic.dart';
import 'package:dream_wedding_app/home_screen.dart';
import 'package:dream_wedding_app/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Profil'),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {},
                          child: Icon(Icons.camera_alt, color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconData(58513, fontFamily: 'MaterialIcons'),
                            color: Colors.grey,
                            size: 22,
                          ),
                          // SvgPicture.asset(
                          //   icon,
                          //   color: kPrimaryColor,
                          //   width: 22,
                          // ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Akun saya')),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconData(58447, fontFamily: 'MaterialIcons'),
                            color: Colors.grey,
                            size: 22,
                          ),
                          // SvgPicture.asset(
                          //   icon,
                          //   color: kPrimaryColor,
                          //   width: 22,
                          // ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Notifikasi', style: TextStyle(fontSize: 17))),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconData(58751, fontFamily: 'MaterialIcons'),
                            color: Colors.grey,
                            size: 22,
                          ),
                          // SvgPicture.asset(
                          //   icon,
                          //   color: kPrimaryColor,
                          //   width: 22,
                          // ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Pengaturan', style: TextStyle(fontSize: 17))),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconData(58122, fontFamily: 'MaterialIcons'),
                            color: Colors.grey,
                            size: 22,
                          ),
                          // SvgPicture.asset(
                          //   icon,
                          //   color: kPrimaryColor,
                          //   width: 22,
                          // ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Bantuan', style: TextStyle(fontSize: 17))),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconData(58291, fontFamily: 'MaterialIcons'),
                            color: Colors.grey,
                            size: 22,
                          ),
                          // SvgPicture.asset(
                          //   icon,
                          //   color: kPrimaryColor,
                          //   width: 22,
                          // ),
                          SizedBox(width: 20),
                          Expanded(child: Text('Log Out', style: TextStyle(fontSize: 17))),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              color: Colors.white,
            )));
  }
}
