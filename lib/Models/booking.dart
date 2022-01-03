import 'package:dream_wedding_app/Models/payment.dart';
import 'package:dream_wedding_app/Models/review.dart';
import 'package:dream_wedding_app/Models/vendor.dart';

class Booking {
  late String start_booking;
  late String end_booking;
  late int customer_id;
  late int product_id;
  late String deskripsi;
  late String created_at;
  late int id;
  late int status;
  late Vendor vendor;
  late Review? review;
  late List<Payment>? payment;


  Booking({this.id = 0, this.start_booking = '',this.end_booking = '',this.customer_id = 0, this.product_id = 0,this.status = 0,
      this.deskripsi = '', this.created_at = ''}) : this.vendor = Vendor();

  Booking.fromJson(Map<String, dynamic> json)
      : start_booking = json['start_booking'],
        id = json['id'],
        end_booking = json['end_booking'],
        customer_id = json['customer_id'],
        status = json['status'],
        deskripsi = json['deskripsi'],
        created_at = json['created_at'],
        vendor = new Vendor.fromJson(json["product"]),
        review = json["review"] == null ? null : new Review.fromJson(json["review"]),
        payment = json["payment"] == null ? null : List<Payment>.from(json["payment"].map((x) => new Payment.fromJson(x))),
        product_id = json['product_id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'start_booking': start_booking,
    'end_booking': end_booking,
    'deskripsi': deskripsi,
    'status': status,
    'customer_id': customer_id,
    'product_id': product_id,
    'created_at' : created_at,
  };
}