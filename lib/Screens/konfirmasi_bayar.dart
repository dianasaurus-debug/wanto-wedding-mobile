import 'dart:io';

import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Models/bank_account.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonfirmasiBayarScreen extends StatefulWidget {
  final int id_booking;

  const KonfirmasiBayarScreen({Key? key, required this.id_booking})
      : super(key: key);

  @override
  _KonfirmasiBayarScreenState createState() => _KonfirmasiBayarScreenState();
}

class _KonfirmasiBayarScreenState extends State<KonfirmasiBayarScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late Future<Booking> futureDetailBooking;

  @override
  void initState() {
    // TODO: implement initState
    futureDetailBooking = BookingNetwork().getBookingDetail(widget.id_booking);
  }

  BankAccount bankAccount = new BankAccount();

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Booking>(
            future: futureDetailBooking,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle,
                                size: 100, color: Color(0xff80cbc4)),
                            SizedBox(height: 10),
                            Text('Pemesanan berhasil!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff80cbc4),
                                    fontSize: 30)),
                            SizedBox(height: 20),
                            Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
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
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Detail Pemesanan',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20)),
                                    Divider(
                                      color: Color(0xff80cbc4),
                                    ),
                                    SizedBox(height: 5),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Nama Jasa',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          SizedBox(height: 5),
                                          Text(snapshot.data!.vendor.nama,
                                              style: TextStyle(
                                                  color: Color(0xff80cbc4),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                    SizedBox(height: 8),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Jenis Jasa',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          SizedBox(height: 5),
                                          Text(
                                              snapshot
                                                  .data!.vendor.nama_kategori,
                                              style: TextStyle(
                                                  color: Color(0xff80cbc4),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                    SizedBox(height: 8),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Harga Total Jasa',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          SizedBox(height: 5),
                                          Text(
                                              formatCurrency.format(int.parse(
                                                  snapshot.data!.vendor.harga)),
                                              style: TextStyle(
                                                  color: Color(0xff80cbc4),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                    SizedBox(height: 8),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Informasi Pembayaran DP',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 3,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [

                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Nominal DP',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          formatCurrency.format(
                                                              int.parse(snapshot
                                                                  .data!
                                                                  .payment![0]
                                                                  .nominal)),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff80cbc4),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('Kode Unik',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          '${snapshot.data!.payment![0].kode_unik}',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff80cbc4),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                                SizedBox(height: 5),
                                                Divider(
                                                  color: Color(0xff80cbc4),
                                                ),
                                                Row(children: [
                                                  Text(
                                                    'Nama Bank : ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      '${snapshot.data!.payment![0].bankAccount.nama_bank}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff80cbc4),
                                                          fontSize: 15)),
                                                ]),
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'Atas Nama : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${snapshot.data!.payment![0].bankAccount.acc_holder}',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff80cbc4),
                                                              fontSize: 15))
                                                    ])),
                                                SizedBox(height: 5),
                                                RichText(
                                                    text: TextSpan(
                                                        text:
                                                            'Nomor Rekening : ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${snapshot.data!.payment![0].bankAccount.nomor_rekening}',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff80cbc4),
                                                              fontSize: 15))
                                                    ])),
                                              ],
                                            ),
                                          ),
                                        ]),
                                    SizedBox(height: 10),
                                  ],
                                )),
                            SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => BottomNavigation());
                                  Navigator.push(context, route);
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kembali ke beranda",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                )),
                          ],
                        )));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }));
  }
}
