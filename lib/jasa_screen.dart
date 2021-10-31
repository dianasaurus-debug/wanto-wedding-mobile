import 'dart:io';

import 'package:dream_wedding_app/booking_form_screen.dart';
import 'package:dream_wedding_app/detail_jasa_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JasaScreen extends StatefulWidget {
  @override
  _JasaScreenState createState() => _JasaScreenState();
}

class _JasaScreenState extends State<JasaScreen> {
  @override
  void initState() {
    // TODO: implement initState
  }

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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                  child: Text(
                    'Paket Lengkap',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  alignment: Alignment.topLeft),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(right: 5),
                              child: ListView(children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailJasa()),
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
                                          child: Image.network(imgList[index],
                                              fit: BoxFit.cover),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Paket Gold',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17),
                                                        ),
                                                        Text(
                                                          'Rp. 40.000.000',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15),
                                                        ),
                                                      ]),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => BookingForm()),
                                                        );
                                                      },
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      color: Color(0xff80cbc4),
                                                      textColor: Colors.white,
                                                      child: Text("Pesan",
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ),
                                                  )
                                                ])),
                                      ],
                                    ),
                                  ),
                                )
                              ]));
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  child: Text(
                    'Paket Make Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  alignment: Alignment.topLeft),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(right: 5),
                              child: ListView(children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailJasa()),
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
                                          child: Image.network(imgList[index],
                                              fit: BoxFit.cover),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Paket ${index + 1}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17),
                                                        ),
                                                        Text(
                                                          'Rp. 40.000.000',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15),
                                                        ),
                                                      ]),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      onPressed: () {},
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      color: Color(0xff80cbc4),
                                                      textColor: Colors.white,
                                                      child: Text("Pesan",
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ),
                                                  )
                                                ])),
                                      ],
                                    ),
                                  ),
                                )
                              ]));
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  child: Text(
                    'Paket Butik',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  alignment: Alignment.topLeft),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(right: 5),
                              child: ListView(children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        child: Image.network(imgList[index],
                                            fit: BoxFit.cover),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Paket ${index + 1}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17),
                                                      ),
                                                      Text(
                                                        'Rp. 40.000.000',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      fontSize: 13),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    onPressed: () {},
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    color: Color(0xff80cbc4),
                                                    textColor: Colors.white,
                                                    child: Text("Pesan",
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                )
                                              ])),
                                    ],
                                  ),
                                ),
                              ]));
                        }),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
