class Product {
  final int? id;
  final String? photoPath;
  final String name;
  final num rentalPricePerDay;
  num availableQuantity;
  final String status;

  Product({
    this.id,
    this.photoPath,
    required this.name,
    required this.rentalPricePerDay,
    required this.availableQuantity,
    required this.status,
  });

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'photoPath': photoPath,
      'name': name,
      'rentalPricePerDay': rentalPricePerDay,
      'availableQuantity': availableQuantity,
      'status': status
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
   return Product(
       id: map['id'],
       photoPath: map['photoPath'],
       name: map['name'],
       rentalPricePerDay: map['rentalPricePerDay'],
       availableQuantity: map['availableQuantity'],
       status: map['status']
   );
  }

}