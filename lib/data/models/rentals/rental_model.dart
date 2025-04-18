class Rental{
  final int? id;
  final int productId;
  final int customerId;
  final String rentalDate;
  late final String? returnDate;
  final int quantity;
  final double totalPrice;
  final String status;

  Rental ({
    this.id,
    required this.productId,
    required this.customerId,
    required this.rentalDate,
    this.returnDate,
    required this.quantity,
    required this.totalPrice,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'customerId': customerId,
      'rentalDate': rentalDate,
      'returnDate': returnDate,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
        id: map['id'],
        productId: map['productId'],
        customerId: map['customerId'],
        rentalDate: map['rentalDate'],
        returnDate: map['returnDate'],
        quantity: map['quantity'],
        totalPrice: map['totalPrice'],
        status: map['status']
    );
  }
}