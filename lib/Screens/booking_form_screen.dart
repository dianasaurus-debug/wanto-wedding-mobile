import 'dart:io';

import 'package:dream_wedding_app/Models/bank_account.dart';
import 'package:dream_wedding_app/Screens/konfirmasi_bayar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  final maxLines = 5;

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  List<BankAccount> bankAccount = [
    new BankAccount(1,'Bank Mandiri', '119190191091', 'https://img2.pngdownload.id/20180815/ab/kisspng-bank-mandiri-depok-logo-bank-mandiri-semarang-kred-5b74ed29b6a585.5966533915343895457481.jpg', 'Adelle'),
    new BankAccount(2, 'Bank BRI', '1878171871818', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/BRI_2020.svg/1200px-BRI_2020.svg.png', 'Adelle'),
    new BankAccount(3, 'Bank BNI', '1878171871871', 'https://rekreartive.com/wp-content/uploads/2019/04/Logo-BNI-Bank-Negara-Indonesia-46-Vector-.png', 'Adelle'),
  ];
  int selected = -1;
  @override
  void initState() {
    super.initState();
  }
  Widget _buildPlayerModelList(int index,BankAccount items) {
    return Card(
      child: ExpansionTile(
        key: Key(index.toString()), //attention
        initiallyExpanded: index == selected, //attention
        trailing: Icon(
          index == selected
              ? Icons.check_box
              : Icons.check_box_outline_blank,
        ),
        onExpansionChanged: (expanded) {
          if (expanded)
            setState(() {
              Duration(seconds: 20000);
              selected = index;
            });
          else
            setState(() {
              selected = -1;
            });
        },
        title: Row(children: [
          Image.network(
            items.logo_bank,
            width: 50,
          ),
          SizedBox(width: 5),
          Text('Transfer ${items.nama_bank}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              )),
        ]
        ),
        children: <Widget>[
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                RichText(
                    text: TextSpan(
                        text: 'Nomor rekening : ',
                        style: TextStyle(fontWeight: FontWeight.w700, color : Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: items.nomor_rekening,
                            style: TextStyle(
                                color: Color(0xff80cbc4),
                                fontWeight: FontWeight.bold),
                          )
                        ])
                ),
                RichText(
                    text: TextSpan(
                        text: 'Atas Nama : ',
                        style: TextStyle(fontWeight: FontWeight.w700, color : Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: items.acc_holder,
                            style: TextStyle(
                                color: Color(0xff80cbc4),
                                fontWeight: FontWeight.bold),
                          )
                        ])
                ),
              ]
            ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
                        height: 80.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Paket Gold', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 10),
                            Text('Rp. 40.000.000',
                                style: TextStyle(
                                    color: Color(0xff80cbc4), fontSize: 15)),
                          ],
                        )),
                  ],
                ),
                Divider(
                  color: Color(0xff80cbc4),
                ),
                SizedBox(height: 8),
                Text('Pilih Tanggal',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 300,
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
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    startRangeSelectionColor: Colors.green,
                    endRangeSelectionColor: Colors.green,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      todayTextStyle: TextStyle(color: Colors.greenAccent),
                      todayCellDecoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff80cbc4), width: 1),
                          shape: BoxShape.circle),
                    ),
                    rangeSelectionColor: Color(0xff80cbc4),
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                ),
                SizedBox(height: 15),
                Text('Pembayaran DP',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                          offset: Offset(0, 3), // changes position of shadow
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
                                    fontWeight : FontWeight.bold,
                                    color: Colors.black, fontSize: 15),
                                children: <TextSpan>[
                              TextSpan(
                                text: 'Rp. 50.000',
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
                        Padding(
                          padding: const EdgeInsets.only(bottom : 10),
                          child: ListView.builder(
                            key: Key('builder ${selected.toString()}'), //attention
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: bankAccount.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildPlayerModelList(index, bankAccount[index]);
                            },
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10),
                Text('Catatan untuk Vendor',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                      Route route = MaterialPageRoute(
                          builder: (context) => KonfirmasiBayarScreen());
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
            )));
  }
}
