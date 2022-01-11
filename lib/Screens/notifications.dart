import 'dart:io';

import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Controllers/user.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Models/notification.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Screens/booking_form_screen.dart';
import 'package:dream_wedding_app/Screens/detail_booking.dart';
import 'package:dream_wedding_app/Screens/detail_jasa_screen.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/accordion.dart';
import 'package:dream_wedding_app/Widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> futureNotifications;
  @override
  void initState() {
    // TODO: implement initState
    futureNotifications = VendorNetwork().getAllNotifications();
  }

  Future<List<NotificationModel>> _refreshProducts(BuildContext context) async {
    return futureNotifications;
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Notifikasi',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff80cbc4), //change your color here
          ),
        ),
        body:  RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child:FutureBuilder<List<NotificationModel>>(
              future: futureNotifications,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Card(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ListTile(
                                  title:
                                  Text(snapshot.data![index].title, style: TextStyle(color: Color(0xff80cbc4), fontSize: 16)),
                                  subtitle: Text(snapshot.data![index].content, style: TextStyle(color: Colors.grey, fontSize: 14)),
                                )));
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    child: CircularProgressIndicator());
              }),
        )
    );
  }
}
