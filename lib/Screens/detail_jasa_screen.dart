import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class DetailJasa extends StatefulWidget {
  final int idVendor;

  const DetailJasa({Key? key, required this.idVendor}) : super(key: key);

  @override
  _DetailJasaState createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  late Future<Vendor> futureDetailVendor;
  late List<Widget> imageSliders;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late ScrollController _scroll_controller;
  _scrollListener() {
    if (_scroll_controller.offset >= _scroll_controller.position.maxScrollExtent &&
        !_scroll_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_scroll_controller.offset <= _scroll_controller.position.minScrollExtent &&
        !_scroll_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }
  @override
  void initState() {
    _scroll_controller = ScrollController();
    _scroll_controller.addListener(_scrollListener);//the listener for up and down.
    futureDetailVendor = VendorNetwork().getOneVendor(widget.idVendor);
  }

  int _current = 0;
  int _current_bottom = 0;
  bool _showContent = true;

  final CarouselController _controller = CarouselController();




  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Detail Vendor',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff80cbc4), //change your color here
          ),
        ),
        body:
        FutureBuilder<Vendor>(
          future: futureDetailVendor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                  padding : EdgeInsets.only(bottom: 15),
                  child : ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                      IMG_URL+snapshot.data!.cover
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              child: Column(
                                children : [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                        crossAxisAlignment : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data!.nama}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                              height: 5
                                          ),
                                          Row(
                                              children: [
                                                if(double.parse(snapshot.data!.rating_mean)>0) ...[
                                                  Text(
                                                      '${formatCurrency.format(int.parse(snapshot.data!.harga))} | ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .green,
                                                          fontSize: 15)),
                                                  RatingBarIndicator(
                                                    rating: double.parse(snapshot.data!.rating_mean),
                                                    itemBuilder: (context,
                                                        index) =>
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors
                                                              .amber,
                                                        ),
                                                    itemCount: 5,
                                                    itemSize: 15.0,
                                                    direction: Axis.horizontal,
                                                  ),
                                                  Text(
                                                    ' (${snapshot.data!.rating_mean})',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontWeight : FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ]
                                                else
                                                  ...[
                                                    Text(
                                                        '${formatCurrency.format(int.parse(snapshot.data!.harga))} | ',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15)),
                                                    Text('Belum dirating',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13))
                                                  ]
                                              ]
                                          )
                                        ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: GestureDetector(
                                        onTap: () {
                                          // Route route = MaterialPageRoute(
                                          //     builder: (context) => BottomNavigation());
                                          // Navigator.push(context, route);
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color(0xff80cbc4),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                                offset: Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Pesan Sekarang",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ]),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Galeri',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        Divider(),
                                        Container(
                                          width: double.infinity,
                                          height: 180,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data!.galeries!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                    width: MediaQuery.of(context).size.width * 0.8,
                                                    margin: EdgeInsets.only(right: 5),
                                                    child: ListView(
                                                        children: [
                                                          Card(
                                                            clipBehavior: Clip.antiAlias,
                                                            child:
                                                                Container(
                                                                  width: double.infinity,
                                                                  height: 150,
                                                                  child: Image.network(IMG_URL_VENDOR+snapshot.data!.galeries![index].filename,
                                                                      fit: BoxFit.cover),
                                                                ),
                                                          ),
                                                        ]));
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text('Deskripsi',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          trailing: IconButton(
                                            icon: Icon(
                                                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                                            onPressed: () {
                                              setState(() {
                                                _showContent = !_showContent;
                                              });
                                            },
                                          ),
                                        ),
                                        _showContent
                                            ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Html(data: """${snapshot.data!.deskripsi}"""),
                                              // Text(snapshot.data!.deskripsi)
                                            ],
                                          ),
                                        )
                                            : Container()
                                        ,
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Ulasan',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        Divider(),
                                        if(snapshot.data!.reviews!.length==0)
                                          Center(
                                              child: Text('Belum ada ulasan', style: TextStyle(fontSize: 18)),
                                          )
                                        else
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Row(
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: double.parse(snapshot.data!.reviews![index].score),
                                                            itemBuilder: (context,
                                                                index) =>
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                            itemCount: 5,
                                                            itemSize: 15.0,
                                                            direction: Axis.horizontal,
                                                          ),
                                                          Text(
                                                            ' (${snapshot.data!.reviews![index].score})',
                                                            style: TextStyle(
                                                                color:
                                                                Colors.black,
                                                                fontWeight : FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                        ]
                                                      ),
                                                      Text(snapshot.data!.reviews![index].comment, style: TextStyle(fontSize: 15)),

                                                    ]
                                                  )
                                                ),
                                              );
                                            },
                                            itemCount: snapshot.data!.reviews!.length,
                                          )
                                      ],
                                    ),
                                  ),
                                ]
                              )
                            )
                          ],
                        ),
                      ])
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )

);
  }
}
