import 'dart:io';

import 'package:dream_wedding_app/Models/bank_account.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class KonfirmasiBayarScreen extends StatefulWidget {
  final Vendor vendor;
  final BankAccount bank_account;
  const KonfirmasiBayarScreen({Key? key, required this.vendor, required this.bank_account}) : super(key: key);
  @override
  _KonfirmasiBayarScreenState createState() => _KonfirmasiBayarScreenState();
}

class _KonfirmasiBayarScreenState extends State<KonfirmasiBayarScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void initState() {
    // TODO: implement initState
  }

  BankAccount bankAccount = new BankAccount(1,'Bank Mandiri', '119190191091', 'Adelle');

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : SingleChildScrollView(
            padding : EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size : 100, color : Color(0xff80cbc4)),
                SizedBox(
                  height : 10
                ),
                Text('Pemesanan berhasil!', style : TextStyle(fontWeight: FontWeight.bold, color : Color(0xff80cbc4), fontSize : 30)),
                SizedBox(
                    height : 20
                ),
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Detail Pemesanan',
                            style: TextStyle(color: Colors.grey, fontSize : 20)),
                        Divider(
                          color: Color(0xff80cbc4),
                        ),
                        SizedBox(height: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                            Text('Nama Jasa', style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text(widget.vendor.nama,  style: TextStyle(
                                color: Color(0xff80cbc4),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                          ]
                        ),
                        SizedBox(height: 8),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Text('Jenis Jasa', style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Text(widget.vendor.nama_kategori,  style: TextStyle(
                                  color: Color(0xff80cbc4),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                            ]
                        ),
                        SizedBox(height: 8),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Text('Harga Total Jasa', style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Text(formatCurrency.format(int.parse(widget.vendor.harga)),  style: TextStyle(
                                  color: Color(0xff80cbc4),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                            ]
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: Color(0xff80cbc4),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Text('Nominal DP', style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Text(formatCurrency.format(int.parse(widget.vendor.nominal_dp)),  style: TextStyle(
                                  color: Color(0xff80cbc4),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                            ]
                        ),
                        SizedBox(height: 8),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Text('Informasi Pembayaran DP', style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Container(
                                padding : EdgeInsets.all(10),
                                decoration : BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text('Nama Bank : ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                      Text('${widget.bank_account.nama_bank}',
                                          style: TextStyle(
                                              color: Color(0xff80cbc4),
                                              fontSize: 15
                                          )
                                      ),
                                    ]
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Atas Nama : ',
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '${widget.bank_account.acc_holder}',
                                                  style: TextStyle(
                                                      color: Color(0xff80cbc4),
                                                      fontSize: 15))
                                            ])
                                    ),
                                    SizedBox(height: 5),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Nomor Rekening : ',
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '${widget.bank_account.nomor_rekening}',
                                                  style: TextStyle(
                                                      color: Color(0xff80cbc4),
                                                      fontSize: 15))
                                            ])
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                        SizedBox(height: 10),

                      ],
                    )
                ),
                SizedBox(
                    height : 20
                ),
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
                            offset:
                            Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
            )
        )

        )
    );
  }
}
