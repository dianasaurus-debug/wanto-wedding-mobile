import 'dart:convert';
import 'dart:io';

import 'package:dream_wedding_app/Controllers/auth.dart';
import 'package:dream_wedding_app/Controllers/bank_account.dart';
import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Models/bank_account.dart';
import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/Screens/konfirmasi_bayar.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingForm extends StatefulWidget {
  final Vendor vendor;
  const BookingForm({Key? key, required this.vendor}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  late Future<List<BankAccount>> futureBank;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late BankAccount selected_bank_account;

  final maxLines = 5;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  int selected = -1;
  var start_booking;
  var end_booking;
  var customer_id;
  var product_id;
  var deskripsi;
  var nominal;
  var bank_account_id;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    futureBank = BankAccountNetwork().getBankAccount();
  }

  Widget _buildPlayerModelList(int index, BankAccount items) {
    return Card(
      child: ExpansionTile(
        key: Key(index.toString()),
        //attention
        initiallyExpanded: index == selected,
        //attention
        trailing: Icon(
          index == selected ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onExpansionChanged: (expanded) {
          if (expanded)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
              bank_account_id = items.id;
              selected_bank_account = items;
            });
          else
            setState(() {
              selected = -1;
            });
        },
        title: Row(children: [
          Text('Transfer ${items.nama_bank}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ]),
        children: <Widget>[
          ListTile(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(
                      text: 'Nomor rekening : ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                      text: items.nomor_rekening,
                      style: TextStyle(
                          color: Color(0xff80cbc4),
                          fontWeight: FontWeight.bold),
                    )
                  ])),
              RichText(
                  text: TextSpan(
                      text: 'Atas Nama : ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                      text: items.acc_holder,
                      style: TextStyle(
                          color: Color(0xff80cbc4),
                          fontWeight: FontWeight.bold),
                    )
                  ])),
            ]),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Booking Paket Gold',
              style: TextStyle(color: Color(0xff80cbc4))),
          iconTheme: IconThemeData(
            color: Color(0xff80cbc4), //change your color here
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            IMG_URL + widget.vendor.cover,
                            height: 80.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child:Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.vendor.nama,
                                      style: TextStyle(fontSize: 17)),
                                  SizedBox(height: 10),
                                  Text(
                                      formatCurrency
                                          .format(int.parse(widget.vendor.harga)),
                                      style: TextStyle(
                                          color: Color(0xff80cbc4),
                                          fontSize: 15)),
                                ],
                              )),
                        )
                      ],
                    ),
                    Divider(
                      color: Color(0xff80cbc4),
                    ),
                    SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('Pilih Tanggal',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(' (pastikan 1 bulan setelah hari ini)',
                              style: TextStyle(fontSize: 15, color: Colors.red)),
                      ]
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Tanggal Mulai'),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            child: DateTimeField(
                              format: format,
                              decoration: InputDecoration(
                                hintText: 'Tanggal dan Waktu',
                              ),
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now().add(Duration(days: 34)),
                                    initialDate: currentValue ?? DateTime.now().add(Duration(days: 35)),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                              validator: (start_booking_value) {
                                if (start_booking_value! == null) {
                                  return 'Mohon masukkan tanggal mulai';
                                }
                                start_booking = start_booking_value.toIso8601String();
                                return null;
                              },
                            ),
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
                          ),
                          SizedBox(height: 5),
                          Text('Tanggal Berakhir'),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            child: DateTimeField(
                              format: format,
                              decoration: InputDecoration(
                                hintText: 'Tanggal dan Waktu',
                              ),
                              validator: (end_booking_value) {
                                if (end_booking_value! == null) {
                                  return 'Mohon masukkan tanggal berakhir';
                                }
                                end_booking = end_booking_value.toIso8601String();
                                return null;
                              },
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now().add(Duration(days: 31)),
                                    initialDate: currentValue ?? DateTime.now().add(Duration(days: 31)),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
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
                          ),
                        ]),
                    SizedBox(height: 15),
                    Text('Pembayaran DP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Untuk pemesanan jasa Anda diharuskan untuk membayar uang DP terlebih dahulu',
                                style: TextStyle(color: Colors.grey)),
                            Divider(
                              color: Color(0xff80cbc4),
                            ),
                            SizedBox(height: 5),
                            RichText(
                                text: TextSpan(
                                    text: 'Nominal DP : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: formatCurrency.format(
                                        int.parse(widget.vendor.nominal_dp)),
                                    style: TextStyle(
                                        color: Color(0xff80cbc4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                            SizedBox(height: 10),
                            Text('Pilihan Pembayaran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            FutureBuilder<List<BankAccount>>(
                                future: futureBank,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: ListView.builder(
                                        key: Key(
                                            'builder ${selected.toString()}'),
                                        //attention
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _buildPlayerModelList(
                                              index, snapshot.data![index]);
                                        },
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 40, 20, 40),
                                      child: CircularProgressIndicator());
                                }),
                          ],
                        )),
                    SizedBox(height: 10),
                    Text('Catatan untuk Vendor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: maxLines * 24.0,
                      child: TextField(
                        maxLines: maxLines,
                        decoration: InputDecoration(
                          hintText: "Masukkan catatan",
                        ),
                        onChanged: (newText) { deskripsi = newText; }
                      ),
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
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _booking();
                          }
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
                                Icon(Icons.check_circle_rounded,
                                    color: Colors.white, size: 20),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pesan Sekarang!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        )),
                  ],
                ))));
  }
  void _booking()
  async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user_id = jsonDecode(localStorage.getString('user'))['id'];
    var data = {
    'start_booking' : start_booking,
    'end_booking' : end_booking,
    'customer_id' : user_id,
    'product_id' : widget.vendor.id,
    'deskripsi' : deskripsi,
    'nominal' : widget.vendor.nominal_dp,
    'bank_account_id' : bank_account_id,
    };
    var res = await AuthNetwork().postData(data, '/booking/pesan');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => KonfirmasiBayarScreen(id_booking : body['data']['id'])
        ),
      );
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Pemesanan Gagal!",
        desc: "Pastikan tanggal pemesanan sesuai (harus lebih dari 1 bulan setelah hari ini).",
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
}
