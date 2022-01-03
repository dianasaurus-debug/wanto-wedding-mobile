import 'dart:convert';

import 'package:dream_wedding_app/Controllers/booking.dart';
import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/Screens/detail_booking.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  late Future<List<Booking>> futureListBooking;

  @override
  void initState() {
    // TODO: implement initState
    futureListBooking = BookingNetwork().getAllBookings();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Daftar Booking',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Color(0xff80cbc4), //change your color here
      ),

    ),
      body: FutureBuilder<List<Booking>>(
          future: futureListBooking,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailBooking(
                                    idBooking: snapshot.data![index].id)),
                          );
                        },
                        child: Card(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ListTile(
                                  title:
                                      Text(snapshot.data![index].vendor.nama),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'DP : ${formatCurrency.format(int.parse(snapshot.data![index].vendor.nominal_dp))}'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                          'Pelunasan : ${formatCurrency.format(int.parse(snapshot.data![index].vendor.harga))}'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: [
                                        Text(
                                          'Mulai:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                            '${snapshot.data![index].start_booking}')
                                      ]),
                                      Row(children: [
                                        Text(
                                          'Berakhir:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                            '${snapshot.data![index].end_booking}')
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${status_booking[snapshot.data![index].status]}',
                                          style: TextStyle(
                                              color: status_color[
                                                  snapshot.data![index].status],
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailBooking(
                                                              idBooking:
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id)),
                                                );
                                              },
                                              padding: EdgeInsets.all(5.0),
                                              color: Colors.green,
                                              textColor: Colors.white,
                                              child: Text("Detail",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            if (snapshot.data![index].status == 0)
                                              RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onPressed: () {
                                                  cancelBooking(
                                                      snapshot.data![index].id);
                                                },
                                                padding: EdgeInsets.all(5.0),
                                                color: Colors.red,
                                                textColor: Colors.white,
                                                child: Text("Batal",
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                              )
                                            else if (snapshot.data![index].status == 7)
                                                RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onPressed: () {
                                                  _showRatingDialog(
                                                      snapshot.data![index]);
                                                },
                                                padding: EdgeInsets.all(5.0),
                                                color: Colors.blue,
                                                textColor: Colors.white,
                                                child: Text("Rate",
                                                    style: TextStyle(
                                                        fontSize: 15)),
                                              )
                                           else if(snapshot.data![index].status == 8)
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                                  ),
                                                  onPressed: () {
                                                    _showDetailRating(snapshot.data![index].review);
                                                  },
                                                  padding: EdgeInsets.all(5.0),
                                                  color: Colors.blue,
                                                  textColor: Colors.white,
                                                  child: Text("Ulasan Saya",
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                )
                                          ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ))));
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: CircularProgressIndicator());
          }),
    );
  }

  void cancelBooking(id) async {
    var res = await BookingNetwork().cancelBooking(id);
    var body = json.decode(res.body);
    if (body["success"] == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      print(body["message"]);
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
      print(body["message"]);
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
            rating: double.parse(review.score),
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
