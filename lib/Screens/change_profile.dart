import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/Screens/profile_detail.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_wedding_app/Screens/home_screen.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  late Future<User> futureDetailUser;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  var nama_depan;
  var nama_belakang;
  var alamat;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    futureDetailUser = UserNetwork().getProfile();
  }
  File? uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Edit Profil', style: TextStyle(color:Colors.black),),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
        ),
        body:
        FutureBuilder<User>(
          future: futureDetailUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child:
                    Form(
                      key: _formKey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              if(uploadimage == null&&snapshot.data!.profile_photo_path!=null)
                                CircleAvatar(
                                  backgroundImage: NetworkImage(IMG_URL+snapshot.data!.profile_photo_path)
                                )
                              else if(uploadimage == null&&snapshot.data!.profile_photo_path==null)
                                      CircleAvatar(backgroundImage: NetworkImage(IMG_URL+'user.png')
                                )
                              else
                                CircleAvatar(
                                  backgroundImage: Image.file(uploadimage!).image,
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
                                    onPressed: () {
                                      chooseImage();
                                    },
                                    child: Icon(Icons.camera_alt, color: Colors.grey),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Nama Depan', style: TextStyle(fontSize: 18, fontWeight : FontWeight.bold, color: Colors.green)),
                            hintStyle: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          initialValue: '${snapshot.data!.nama_depan}',
                          validator: (namaDepanValue) {
                            if (namaDepanValue!.isEmpty) {
                              return 'Please enter some text';
                            }
                            nama_depan = namaDepanValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Nama Belakang', style: TextStyle(fontSize: 18, fontWeight : FontWeight.bold, color: Colors.green)),
                            hintStyle: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          initialValue: '${snapshot.data!.nama_belakang}',
                          validator: (namaBelakangValue) {
                            if (namaBelakangValue!.isEmpty) {
                              return 'Please enter some text';
                            }
                            nama_belakang = namaBelakangValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text('Alamat Lengkap', style: TextStyle(fontSize: 18, fontWeight : FontWeight.bold, color: Colors.green)),
                            hintStyle: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          maxLines: 3,
                          initialValue: '${snapshot.data!.alamat}',
                          validator: (alamatValue) {
                            if (alamatValue!.isEmpty) {
                              return 'Please enter some text';
                            }
                            alamat = alamatValue;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _updateProfil();
                              }
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
                                  _isLoading? 'Proccessing...' : 'Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    ))

                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )

    );
  }
  void _updateProfil()
  async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = jsonDecode(localStorage.getString('user'))['id'];
    var image_file = null;
    Map<String,String> data = {};

      data = {
        "nama_depan" : nama_depan,
        "nama_belakang" : nama_belakang,
        "alamat" : alamat,
        "_method" : "PUT"
      };

    var res = await AuthNetwork().updateProfile(uploadimage!.path, data, '/update/profile');
    var body = jsonDecode(res);
    if(body["success"]==true){
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ProfileDetail()
        ),
      );
    } else {
      print(body["message"]);
    }
  }
}
