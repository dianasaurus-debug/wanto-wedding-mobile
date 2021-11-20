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

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class DetailJasa extends StatefulWidget {
  final int idVendor;

  const DetailJasa({Key? key, required this.idVendor}) : super(key: key);

  @override
  _DetailJasaState createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  late Future<Vendor> futureDetailVendor;
  late List<Widget> imageSliders;
  @override
  void initState() {
    futureDetailVendor = VendorNetwork().getOneVendor(widget.idVendor);
    imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        // height: MediaQuery.of(context).size.height*0.30,
        // width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. ${imgList.indexOf(item)} image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();
  }

  int _current = 0;
  int _current_bottom = 0;
  bool _showContent = true;

  final CarouselController _controller = CarouselController();




  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(CupertinoIcons.search, color: Color(0xff80cbc4)),
                border: InputBorder.none,
                hintText: 'Cari',
                // contentPadding:
                //     EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: Color(0xff80cbc4)),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.shopping_cart_outlined,
                    color: Color(0xff80cbc4)),
                onPressed: () {}),
          ],
        ),
        body:
        FutureBuilder<Vendor>(
          future: futureDetailVendor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                  padding : EdgeInsets.only(bottom: 15),
                  child :   ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Color(0xff80cbc4), BlendMode.darken),
                                    image: new NetworkImage(
                                      IMG_URL+snapshot.data!.cover
                                    ),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    // new BackdropFilter(
                                    //   filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                                    //   child: new Container(
                                    //     decoration: new BoxDecoration(
                                    //         color: Colors.white.withOpacity(0.0)),
                                    //   ),
                                    // ),
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(snapshot.data!.nama,
                                                    style: TextStyle(
                                                        color: Colors.white, fontSize: 20)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Chip(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(color: Colors.green),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  visualDensity: VisualDensity(
                                                      horizontal: 0.0, vertical: -4),
                                                  backgroundColor:
                                                  Color.fromRGBO(255, 0, 0, 0),
                                                  label: Text(snapshot.data!.harga,
                                                      style: TextStyle(
                                                          color: Colors.green, fontSize: 12)),
                                                ),
                                              ],
                                            )
                                        )
                                    )
                                  ],
                                )),
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
                                    height: 210,
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 150,
                                                        child: Image.network(IMG_URL_VENDOR+snapshot.data!.galeries![index].filename,
                                                            fit: BoxFit.cover),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(16.0),
                                                        child: Text(
                                                          'Dekorasi Pernikahan',
                                                          style: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(0.6),
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ],
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
