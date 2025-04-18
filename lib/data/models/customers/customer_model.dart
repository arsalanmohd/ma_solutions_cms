class Customer {
  final int? id;
  final String name;
  final String contact;
  final String address;
  final String occupation;
  final String statusPaid;
  final String statusReturned;

  Customer ({
    this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.occupation,
    required this.statusPaid,
    required this.statusReturned
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'address': address,
      'occupation': occupation,
      'statusPaid': statusPaid,
      'statusReturned': statusReturned
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
        id: map['id'],
        name: map['name'],
        contact: map['contact'],
        address: map['address'],
        occupation: map['occupation'],
        statusPaid: map['statusPaid'],
        statusReturned: map['statusReturned']
    );
  }

}