import 'dart:io';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Screens/booking_form_screen.dart';
import 'package:dream_wedding_app/Screens/booking_list.dart';
import 'package:dream_wedding_app/Screens/daftar_butik.dart';
import 'package:dream_wedding_app/Screens/daftar_catering.dart';
import 'package:dream_wedding_app/Screens/daftar_makeup.dart';
import 'package:dream_wedding_app/Screens/daftar_paket_lengkap.dart';
import 'package:dream_wedding_app/Screens/detail_jasa_screen.dart';
import 'package:dream_wedding_app/Screens/login_screen.dart';
import 'package:dream_wedding_app/Screens/notifications.dart';
import 'package:dream_wedding_app/Screens/register_screen.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Vendor>> futureTopThumbnails, futurePaketLengkap, futureTopThumbnailsGlobal, futurePaketLengkapGlobal ;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
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
  late FirebaseMessaging messaging;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _checkIfLoggedIn();
      futureTopThumbnails = VendorNetwork().getThumbnails();
      futurePaketLengkap = VendorNetwork().getAllPaketLengkap();
      futureTopThumbnailsGlobal = VendorNetwork().getThumbnailsGlobal();
      futurePaketLengkapGlobal = VendorNetwork().getAllPaketLengkapGlobal();
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
        Text(event.notification!.title!, style:TextStyle(fontSize: 16, color: Color(0xff80cbc4))),
        subtitle: Text(event.notification!.body!),
        background: Colors.white,
        duration: Duration(seconds: 20),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Route route = MaterialPageRoute(
          builder: (context) => NotificationScreen());
      Navigator.push(context, route);
    });
  }

  int _current = 0;
  int _current_bottom = 0;

  final CarouselController _controller = CarouselController();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          isAuth: isAuth
        ),
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder<List<Vendor>>(
                  future: isAuth==true ? futureTopThumbnails : futureTopThumbnailsGlobal,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(snapshot.data!.length>0){
                        return Column(children: [
                          CarouselSlider(
                            items: snapshot.data!.map((data) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.5,
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 2,
                                  child:
                                  GridTile(
                                    header: GridTileBar(
                                      leading: Badge(
                                        toAnimate: false,
                                        shape: BadgeShape.square,
                                        badgeColor: Color(0xff80cbc4),
                                        borderRadius: BorderRadius.circular(8),
                                        badgeContent: Text('Rekomendasi ',
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 17)),
                                      ),
                                      title: Text(''),

                                    ),
                                    child: ShaderMask(
                                        shaderCallback: (rect) {
                                          return LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ],
                                          ).createShader(Rect.fromLTRB(0, -20,
                                              rect.width, rect.height - 20));
                                        },
                                        blendMode: BlendMode.darken,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(
                                            //   colors: [gradientStart, gradientEnd],
                                            //   begin: FractionalOffset(0, 0),
                                            //   end: FractionalOffset(0, 1),
                                            //   stops: [0.0, 1.0],
                                            //   tileMode: TileMode.clamp
                                            // ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  IMG_URL + data.cover),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                    footer: Container( // You can use GridTileBar instead
                                      child: Column(
                                          children: [
                                            Text(
                                              '${data.nama}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                                height: 10
                                            ),
                                             Row(
                                                  children: [
                                                    if(double.parse(data.rating_mean)>0) ...[
                                                      Text(
                                                          '${formatCurrency
                                                              .format(int.parse(
                                                              data.harga))} | ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 15)),
                                                      RatingBarIndicator(
                                                        rating: double.parse(data.rating_mean),
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
                                                        ' (${data.rating_mean})',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.yellow,
                                                            fontWeight : FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                    ]
                                                    else
                                                      ...[
                                                        Text(
                                                            '${formatCurrency
                                                                .format(
                                                                int.parse(data
                                                                    .harga))} | ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15)),
                                                        Text('Belum dirating',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10))
                                                      ]
                                                  ]
                                              )
                                          ]),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                    ),
                                  ),
                                );
                              });
                            }).toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                              height: 170.0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: snapshot.data!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme
                                          .of(context)
                                          .brightness ==
                                          Brightness.dark
                                          ? Colors.white
                                          : Color(0xff80cbc4))
                                          .withOpacity(
                                          _current == entry.key ? 1 : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]);
                      } else {
                        return Text("Belum ada data");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => BookingList());
                          Navigator.push(context, route);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child:
                          GestureDetector(
                            onTap: () {
                              isAuth == true ?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingList()),
                              ) : loginAlert();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.format_list_bulleted_rounded,
                                    color: Colors.black, size: 20),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pesanan Saya",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child:
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                      offset:
                                      Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 85,
                                child: GestureDetector(
                                    onTap: () =>
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DaftarLengkap()),
                                      )
                                    },
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.cube_box,
                                            color: Color(0xff80cbc4), size: 40),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text('Paket\nLengkap',
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                            textAlign: TextAlign.center)
                                      ],
                                    )
                                )
                                ),
                          ),

                        ),
                        Expanded(
                          child:
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child:
                              Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                        offset:
                                        Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 85,
                                  child:
                                  GestureDetector(
                                      onTap: () =>
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DaftarButik()),
                                        )
                                      },
                                      child:
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(CupertinoIcons.building_2_fill,
                                              color: Color(0xff80cbc4),
                                              size: 40),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Butik',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center)
                                        ],
                                      )))
                          ),
                        ),
                        Expanded(
                            child:
                            Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                        offset:
                                        Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:
                                  GestureDetector(
                                    onTap: () =>
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DaftarMakeUp()),
                                      )
                                    },
                                    child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.face_retouching_natural_sharp,
                                          color: Color(0xff80cbc4), size: 40),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text('Paket\nMake Up',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          textAlign: TextAlign.center)
                                    ],
                                  )),
                                  height: 85,
                                ))),
                        Expanded(
                            child:
                            Padding(
                                padding: EdgeInsets.only(left: 5),
                                child:
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                        offset:
                                        Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child:
                                  GestureDetector(
                                    onTap: () =>
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DaftarCatering()),
                                      )
                                    },
                                    child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.food_bank,
                                          color: Color(0xff80cbc4), size: 40),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text('Catering',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          textAlign: TextAlign.center)
                                    ],
                                  )),
                                  height: 85,
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text('Paket Lengkap',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'Paket yang sudah lengkap dengan beragam jasa untuk pernikahan anda',
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ]),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>DaftarLengkap()));
                              },
                              child: Text('Lihat semua',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16)),
                            )

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 1.9,
                          child: FutureBuilder<List<Vendor>>(
                              future: isAuth==true ? futurePaketLengkap : futurePaketLengkapGlobal,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.8,
                                            margin: EdgeInsets.only(right: 5),
                                            child: ListView(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                    {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                DetailJasa(
                                                                    idVendor: snapshot
                                                                        .data![index]
                                                                        .id)),
                                                      )
                                                    },
                                                    child: Card(
                                                      clipBehavior: Clip
                                                          .antiAlias,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            width: double
                                                                .infinity,
                                                            height: 150,
                                                            child: Image
                                                                .network(
                                                                IMG_URL +
                                                                    snapshot
                                                                        .data![index]
                                                                        .cover,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                  .all(16.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                      '${snapshot
                                                                          .data![index]
                                                                          .nama}',
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: 16),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      children : [
                                                                        if(double.parse(snapshot.data![index].rating_mean)>0) ...[
                                                                          Text(
                                                                            '${formatCurrency.format(int
                                                                                .parse(
                                                                                snapshot
                                                                                    .data![index]
                                                                                    .harga))} | ',
                                                                            style: TextStyle(
                                                                                color:
                                                                                Colors
                                                                                    .green,
                                                                                fontSize: 15),
                                                                          ),
                                                                          RatingBarIndicator(
                                                                            rating: double.parse(snapshot.data![index].rating_mean),
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
                                                                            ' (${snapshot.data![index].rating_mean})',
                                                                            style: TextStyle(
                                                                                color:
                                                                                Colors.black,
                                                                                fontWeight : FontWeight.bold,
                                                                                fontSize: 15),
                                                                          ),
                                                                        ]
                                                                        else
                                                                          ...[
                                                                            Text('${formatCurrency.format(int
                                                                                .parse(
                                                                                snapshot
                                                                                    .data![index]
                                                                                    .harga))} | '
                                                                              ,
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  Colors
                                                                                      .green,
                                                                                  fontSize: 15),
                                                                            ),
                                                                            Text('Belum dirating',
                                                                                style: TextStyle(
                                                                                    color: Colors
                                                                                        .black,
                                                                                    fontSize: 13))
                                                                          ],

                                                                      ]
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
                                                                        color: snapshot.data![index].is_ordered == 0  ? Color(0xff80cbc4) : Colors.grey,
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
                                                  )
                                                ])
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(FontAwesomeIcons.whatsapp),
          backgroundColor: Colors.green.shade500,
          onPressed: () {
            String url =
                "https://wa.me/+923045873730/?text=Hello";
            launch(url);
          },
        )
    );


  }
}
