class Payment {
  final int? id;
  final String rentalId;
  final double amountPaid;
  final String paymentDate;
  final String paymentMode;

  Payment ({
    this.id,
    required this.rentalId,
    required this.amountPaid,
    required this.paymentDate,
    required this.paymentMode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amountPaid': amountPaid,
      'paymentDate': paymentDate,
      'paymentMode': paymentMode,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
        rentalId: map['rentalId'],
        amountPaid: map['amountPaid'],
        paymentDate: map['paymentDate'],
        paymentMode: map['paymentMode']
    );
  }
}