class Payment {
  final String start_booking;
  final String end_booking;
  final int customer_id;
  final int product_id;
  final String deskripsi;
  final String created_at;
  final int id;


  Payment(this.id, this.start_booking,this.end_booking,this.customer_id,this.product_id,
      this.deskripsi, this.created_at);

  Payment.fromJson(Map<String, dynamic> json)
      : start_booking = json['start_booking'],
        id = json['id'],
        end_booking = json['end_booking'],
        customer_id = json['customer_id'],
        deskripsi = json['deskripsi'],
        created_at = json['created_at'],
        product_id = json['product_id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'start_booking': start_booking,
    'end_booking': end_booking,
    'deskripsi': deskripsi,
    'customer_id': customer_id,
    'product_id': product_id,
    'created_at' : created_at,
  };
}