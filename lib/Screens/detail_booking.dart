import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailBooking extends StatefulWidget {
  final int idBooking;

  const DetailBooking({Key? key, required this.idBooking}) : super(key: key);

  @override
  _DetailBookingState createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  late Future<Booking> futureDetailBooking;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    futureDetailBooking = BookingNetwork().getBookingDetail(widget.idBooking);
  }

  File? uploadimage; //variable for choosed file

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }
  Future<Booking> _refreshProducts(BuildContext context) async {
    return BookingNetwork().getBookingDetail(widget.idBooking);
  }

  final CarouselController _controller = CarouselController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Detail Booking',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff80cbc4), //change your color here
          ),

        ),
        body:
    RefreshIndicator(
    onRefresh: () => _refreshProducts(context),
    child:FutureBuilder<Booking>(
      future: futureDetailBooking,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Image.network(
                            IMG_URL + snapshot.data!.vendor.cover,
                            fit: BoxFit.cover),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data!.vendor.nama}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                Text(
                                  formatCurrency.format(int.parse(
                                      snapshot.data!.vendor.harga)),
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                if (snapshot.data!.status == 0)
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10.0),
                                    ),
                                    onPressed: () {
                                      // cancelBooking(
                                      //     snapshot.data![index].id);
                                    },
                                    padding: EdgeInsets.all(5.0),
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: Text("Batalkan Pesanan",
                                        style: TextStyle(
                                            fontSize: 15)),
                                  )
                              ])),
                    ],
                  ),
                ),
                Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detail Tagihan DP',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Nominal DP',
                                            style: TextStyle(
                                                color: Colors.grey)),
                                        SizedBox(height: 5),
                                        Text(
                                            formatCurrency.format(int.parse(
                                                snapshot.data!.payment![0]
                                                    .nominal)),
                                            style: TextStyle(
                                                color: Color(0xff80cbc4),
                                                fontSize: 17,
                                                fontWeight:
                                                FontWeight.bold)),
                                        Text('Kode Unik',
                                            style: TextStyle(
                                                color: Colors.grey)),
                                        SizedBox(height: 5),
                                        Text(
                                            '${snapshot.data!.payment![0].kode_unik}',
                                            style: TextStyle(
                                                color: Color(0xff80cbc4),
                                                fontSize: 17,
                                                fontWeight:
                                                FontWeight.bold)),
                                      ]),
                                  Badge(
                                    toAnimate: false,
                                    shape: BadgeShape.square,
                                    badgeColor: verification_color[snapshot
                                        .data!
                                        .payment![0]
                                        .status_pembayaran],
                                    borderRadius: BorderRadius.circular(8),
                                    badgeContent: Text(
                                        '${verifications[snapshot.data!.payment![0].status_pembayaran]}',
                                        style:
                                        TextStyle(color: Colors.black)),
                                  ),
                                ]),
                            SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                text: 'Rekening Pembayaran\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                      '${snapshot.data!.payment![0].bankAccount.nomor_rekening} (${snapshot.data!.payment![0].bankAccount.nama_bank})',
                                      style: TextStyle(
                                          color: Color(0xff80cbc4),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bukti Pembayaran',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                if (snapshot.data!.payment![0].bukti_pembayaran == null)
                                  Row(children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      onPressed: () {
                                        chooseImage();
                                      },
                                      padding: EdgeInsets.all(5.0),
                                      color: Color(0xff80cbc4),
                                      textColor: Colors.white,
                                      child: Text("Pilih file",
                                          style: TextStyle(fontSize: 15)),
                                    ),
                                    SizedBox(width: 5),
                                    if (uploadimage != null)
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        onPressed: () {
                                          uploadBuktiPembayaran(snapshot
                                              .data!.payment![0].id);
                                        },
                                        padding: EdgeInsets.all(5.0),
                                        color: Color(0xff80cbc4),
                                        textColor: Colors.white,
                                        child: Text("Upload",
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                  ])
                                else
                                  Column(children: [
                                    Image.network(IMG_URL_BUKTI +
                                        snapshot.data!.payment![0]
                                            .bukti_pembayaran)
                                  ])
                              ],
                            )
                          ],
                        ))),
                SizedBox(height: 10),
                Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detail Tagihan Pelunasan',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            if (snapshot.data!.payment!.length > 1)
                              Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text('Nominal Pelunasan',
                                        style:
                                        TextStyle(color: Colors.grey)),
                                    SizedBox(height: 5),
                                    Text(
                                        formatCurrency.format(int.parse(
                                            snapshot.data!.payment![0]
                                                .nominal)),
                                        style: TextStyle(
                                            color: Color(0xff80cbc4),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Text('Kode Unik',
                                        style:
                                        TextStyle(color: Colors.grey)),
                                    SizedBox(height: 5),
                                    Text(
                                        '${snapshot.data!.payment![1].kode_unik}',
                                        style: TextStyle(
                                            color: Color(0xff80cbc4),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Text('Rekening Pembayaran',
                                        style:
                                        TextStyle(color: Colors.grey)),
                                    SizedBox(height: 5),
                                    Text(
                                        '${snapshot.data!.payment![1].bankAccount.nomor_rekening} (${snapshot.data!.payment![1].bankAccount.nama_bank})',
                                        style: TextStyle(
                                            color: Color(0xff80cbc4),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Badge(
                                      toAnimate: false,
                                      shape: BadgeShape.square,
                                      badgeColor: verification_color[
                                      snapshot.data!.payment![1]
                                          .status_pembayaran],
                                      borderRadius:
                                      BorderRadius.circular(8),
                                      badgeContent: Text(
                                          '${verifications[snapshot.data!.payment![1].status_pembayaran]}',
                                          style: TextStyle(
                                              color: Colors.black)),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Bukti Pembayaran',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    if (snapshot.data!.payment![1].bukti_pembayaran == null)
                                      Row(children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          onPressed: () {
                                            chooseImage();
                                          },
                                          padding: EdgeInsets.all(5.0),
                                          color: Color(0xff80cbc4),
                                          textColor: Colors.white,
                                          child: Text("Pilih file",
                                              style:
                                              TextStyle(fontSize: 15)),
                                        ),
                                        SizedBox(width: 5),
                                        if (uploadimage != null)
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.0),
                                            ),
                                            onPressed: () {
                                              uploadBuktiPembayaran(snapshot.data!.payment![1].id);
                                            },
                                            padding: EdgeInsets.all(5.0),
                                            color: Color(0xff80cbc4),
                                            textColor: Colors.white,
                                            child: Text("Upload",
                                                style: TextStyle(
                                                    fontSize: 15)),
                                          ),
                                      ])
                                    else
                                      Column(children: [
                                        Image.network(IMG_URL_BUKTI +
                                            snapshot.data!.payment![1]
                                                .bukti_pembayaran)
                                      ])
                                  ])
                            else
                              Text(
                                  '\nMohon lunasi pembayaran DP terlebih dahulu',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                          ],
                        ))),
                SizedBox(height: 10),
                Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ulasan saya',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            if(snapshot.data!.review==null&&snapshot.data!.status==7)
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      10.0),
                                ),
                                onPressed: () {
                                  _showRatingDialog(
                                      snapshot.data);
                                },
                                padding: EdgeInsets.all(5.0),
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text("Beri Ulasan",
                                    style: TextStyle(
                                        fontSize: 15)),
                              )
                            else if(snapshot.data!.review!=null&&snapshot.data!.status==8)
                              Column(children: [
                                SizedBox(height: 10),
                                RatingBarIndicator(
                                  rating: double.parse(snapshot.data!.review!.score),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '${snapshot.data!.review!.comment}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 15)),
                              ])
                            else
                              Text('\nBelum ada ulasan',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold))
                          ],
                        ))),
                SizedBox(height: 15),
              ]));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    )
    )
        );
  }

  void uploadBuktiPembayaran(id) async {
    var res = await BookingNetwork().uploadBuktiPembayaran(uploadimage!, '/booking/upload-bukti/$id');
    if (res["success"] == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      print(res["message"]);
    }
  }
  void addReview(booking, score, comment) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = jsonDecode(localStorage.getString('user'))['id'];
    var data = {
      'booking_id': booking.id,
      'customer_id': user_id,
      'product_id': booking.product_id,
      'score': score,
      'comment': comment
    };
    var res = await BookingNetwork().addReview(data);
    var body = json.decode(res.body);
    if (body["success"] == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal Upload!",
        desc: "Pastikan data yang dimasukkan benar.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  // show the rating dialog
  // show the rating dialog
  void _showRatingDialog(booking) {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Beri Ulasan Anda',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Nilai seberapa kepuasan Anda dengan layanan kami. Terima kasih atas penilaian jujur Anda.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      submitButtonText: 'Simpan',
      commentHint: 'Masukkan detail dari ulasan Anda',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        addReview(booking, response.rating, response.comment);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  // user defined function
  void _showDetailRating(review) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          scrollable: true,
          title: new Center(child:Text("Ulasan Anda")),
          content: new Column(children: [
            RatingBarIndicator(
              rating: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 30.0,
              direction: Axis.horizontal,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                '${review.comment}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15)),
          ]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Tutup"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
