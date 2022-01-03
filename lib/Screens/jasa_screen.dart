import 'dart:io';

import 'package:dream_wedding_app/Controllers/katalog.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Screens/booking_form_screen.dart';
import 'package:dream_wedding_app/Screens/detail_jasa_screen.dart';
import 'package:dream_wedding_app/Widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:intl/intl.dart';

class JasaScreen extends StatefulWidget {
  @override
  _JasaScreenState createState() => _JasaScreenState();
}

class _JasaScreenState extends State<JasaScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late Future<List<Vendor>> futureVendorMakeUp, futureVendorPaketLengkap, futureVendorCatering, futureVendorBusana;
  @override
  void initState() {
    // TODO: implement initState
    futureVendorMakeUp = VendorNetwork().getVendor("2");
    futureVendorPaketLengkap = VendorNetwork().getVendor("1");
    futureVendorCatering = VendorNetwork().getVendor("3");
    futureVendorBusana = VendorNetwork().getVendor("4");
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
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
              FutureBuilder<List<Vendor>>(
                  future: futureVendorPaketLengkap,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        margin: EdgeInsets.only(right: 5),
                                        child: ListView(
                                            children: [
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
                                                                            builder: (context) => BookingForm(vendor : snapshot.data![index])),
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
                                            ])
                                    );
                                  })
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: CircularProgressIndicator()
                    );
                  }
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
              FutureBuilder<List<Vendor>>(
                  future: futureVendorMakeUp,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        margin: EdgeInsets.only(right: 5),
                                        child: ListView(
                                            children: [
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
                                                                            builder: (context) => BookingForm(vendor : snapshot.data![index]),
                                                                      ));
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
                                            ])
                                    );
                                  })
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: CircularProgressIndicator()
                    );
                  }
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
              FutureBuilder<List<Vendor>>(
              future: futureVendorBusana,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(right: 5),
                                    child: ListView(
                                        children: [
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
                                                                        builder: (context) => BookingForm(vendor : snapshot.data![index])
                                                                  ));
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
                                        ])
                                );
                              })
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: CircularProgressIndicator()
                    );
              }
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  child: Text(
                    'Paket Catering',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  alignment: Alignment.topLeft),
              Divider(),
              FutureBuilder<List<Vendor>>(
                  future: futureVendorCatering,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        margin: EdgeInsets.only(right: 5),
                                        child: ListView(
                                            children: [
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
                                                                            builder: (context) => BookingForm(vendor : snapshot.data![index]),
                                                                      ));
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
                                            ])
                                    );
                                  })
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                      child: CircularProgressIndicator()
                    );
                  }
              ),
            ],
          ),
        ));
  }
}
