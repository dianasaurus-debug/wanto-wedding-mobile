import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Models/katalog.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KatalogElement extends StatefulWidget {
  final List<Katalog> usedKatalog;

  const KatalogElement({Key? key, required this.usedKatalog}) : super(key: key);

  @override
  _KatalogElementState createState() => _KatalogElementState();
}

class _KatalogElementState extends State<KatalogElement> {
  Widget build(BuildContext context) {
    return widget.usedKatalog.length > 0
        ? Expanded(
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: widget.usedKatalog.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      // ignore this, cos I am giving height to the container
                      width: MediaQuery.of(context).size.width * 0.5,
                      // ignore this, cos I am giving width to the container
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(IMG_URL_KATALOG +
                                  widget.usedKatalog[index].cover)),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      alignment: Alignment.bottomCenter,
                      // This aligns the child of the container
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xff80cbc4),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          padding: EdgeInsets.all(10.0),
                          //some spacing to the child from bottom
                          child: Text(
                            '${widget.usedKatalog[index].judul}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )));
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                }))
        : Center(
            child: Text('Tidak ada katalog',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }
}
