class Review {
  final String score;
  final String comment;
  final int booking_id;
  final int customer_id;
  final int product_id;
  final int id;


  Review(this.score, this.comment,this.booking_id, this.customer_id, this.product_id, this.id);

  Review.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        id = json['id'],
        booking_id = json['booking_id'],
        customer_id = json['customer_id'],
        product_id = json['product_id'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'booking_id': booking_id,
    'product_id': product_id,
    'customer_id': customer_id,
    'comment': comment,
    'score': score,
  };
}