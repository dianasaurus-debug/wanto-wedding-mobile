import 'dart:io';

import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Screens/booking_form_screen.dart';
import 'package:dream_wedding_app/Screens/detail_booking.dart';
import 'package:dream_wedding_app/Screens/detail_jasa_screen.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/Screens/register_screen.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarButik extends StatefulWidget {
  @override
  _DaftarButikState createState() => _DaftarButikState();
}

class _DaftarButikState extends State<DaftarButik> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late Future<List<Vendor>> futureVendorBusana;
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
  void loginAlert() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Anda harus login/daftar",
      desc: "Untuk membuat pesanan Anda harus terdaftar sebagai customer",
      buttons: [
        DialogButton(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async {
            Route route = MaterialPageRoute(
                builder: (context) => LoginScreen());
            Navigator.push(context, route);
          },
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "Daftar",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async {
            Route route = MaterialPageRoute(
                builder: (context) => RegisterScreen());
            Navigator.push(context, route);
          },
          color: Colors.green,
        )
      ],
    ).show();

  }
  @override
  void initState() {
    // TODO: implement initState
    futureVendorBusana = isAuth == true ? VendorNetwork().getVendor("4") : VendorNetwork().getVendorGlobal("4");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Daftar Gaun',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff80cbc4), //change your color here
        ),
      ),
      body: FutureBuilder<List<Vendor>>(
          future: futureVendorBusana,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.length>0)
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailJasa(idVendor : snapshot.data![index].id)),
                          )
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                child: Image.network(IMG_URL+snapshot.data![index].cover,
                                    fit: BoxFit.cover),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data![index].nama}',
                                          style: TextStyle(
                                              color:
                                              Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          formatCurrency.format(int.parse(snapshot.data![index].harga)),
                                          style: TextStyle(
                                              color:
                                              Colors.green,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment:
                                          Alignment
                                              .centerRight,
                                          child: RaisedButton(
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10.0),
                                            ),
                                            onPressed: () {
                                              if(isAuth==true){
                                                snapshot.data![index].is_ordered == 0 ?
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingForm(vendor: snapshot.data![index])),) : null;
                                              } else {
                                                loginAlert();
                                              }

                                            },
                                            padding:
                                            EdgeInsets
                                                .all(
                                                5.0),
                                            color: snapshot.data![index].is_ordered == 0 || isAuth==false ? Color(0xff80cbc4) : Colors.grey,
                                            textColor: Colors
                                                .white,
                                            child: Text(
                                                "Pesan",
                                                style: TextStyle(
                                                    fontSize: 15)),
                                          ),
                                        )
                                      ])),
                            ],
                          ),
                        ),
                      );

                  });
              else
                return Center(
                    child: Text('Tidak ada data',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: CircularProgressIndicator());
          }),
    );
  }
}
