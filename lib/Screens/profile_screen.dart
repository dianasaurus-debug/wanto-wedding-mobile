
import 'dart:convert';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/Screens/bantuan.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/Screens/notifications.dart';
import 'package:dream_wedding_app/Screens/profile_detail.dart';
import 'package:dream_wedding_app/Screens/register_screen.dart';
import 'package:dream_wedding_app/Screens/setting_screen.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  late Future<User> futureDetailUser;
  bool isAuth = false;
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    futureDetailUser = UserNetwork().getProfile();
  }
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
        body:
        isAuth == true ?
        FutureBuilder<User>(
          future: futureDetailUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
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
                                backgroundImage: snapshot.data!.profile_photo_path!=null ? NetworkImage(IMG_URL+snapshot.data!.profile_photo_path) : NetworkImage(IMG_URL+'user.png'),
                              ),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileDetail()),
                              );
                            },
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
                                Expanded(child: Text('Akun saya', style: TextStyle(fontSize: 17))),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotificationScreen()),
                              );
                            },
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SettingScreen()),
                              );
                            },
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BantuanScreen()),
                              );
                            },
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
                            onPressed: (){
                              logout();
                            },
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
                  )
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ) : Center(
          child: Padding(
             padding : EdgeInsets.all(20),
             child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login,
                        size: 100,
                        color: Color(0xff80cbc4)),
                    SizedBox(
                        height : 10
                    ),
                   Text('Silahkan login atau daftar untuk melihat profil', style: TextStyle(fontSize: 20, fontWeight : FontWeight.bold, ), textAlign: TextAlign.center),
                    SizedBox(
                        height : 20
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Color(0xff80cbc4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                             'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    SizedBox(
                        height : 10
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Color(0xff80cbc4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),

                  ])
          )
        )

    );
  }
  void logout() async {
    var res = await AuthNetwork().postData({'test' : 'halo'}, '/logout');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }
}
