
/// --- This Product Category Section should consist the categories of products of the client's business
enum DashboardOccupation {
  general,
  plumber,
  electrician,
  construction,
}

enum PaymentStatus { paid, due }

enum ReceiveStatus {received, notReceived}

class Dashboard {
  final int? id;
  final String dCustomerName;
  final String dProductName;
  final String dCustomerNumber;
  final String dOccupation;
  final String date;
  final int dPrice;
  final PaymentStatus pStatus;
  final ReceiveStatus rStatus;

  Dashboard({
    this.id,
    required this.dCustomerName,
    required this.dProductName,
    required this.dCustomerNumber,
    required this.dOccupation,
    required this.date,
    required this.dPrice,
    required this.pStatus,
    required this.rStatus,
  });

  // Convert a Dashboard object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dCustomerName': dCustomerName,
      'dProductName': dProductName,
      'dCustomerNumber': dCustomerNumber,
      'dOccupation': dOccupation,
      'date': date,
      'dPrice': dPrice,
      'pStatus': pStatus.toString(), // Store as a string
      'rStatus': rStatus.toString(), // Store as a string
    };
  }

  // Create a Dashboard object from a Map
  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      id: map['id'],
      dCustomerName: map['dCustomerName'],
      dProductName: map['dProductName'],
      dCustomerNumber: map['dCustomerNumber'],
      dOccupation: map['dOccupation'],
      date: map['date'],
      dPrice: map['dPrice'],
      pStatus: map['pStatus'] == 'PaymentStatus.paid' ? PaymentStatus.paid : PaymentStatus.due,
      rStatus: map['rStatus'] == 'ReceiveStatus.received' ? ReceiveStatus.received : ReceiveStatus.notReceived,
    );
  }
}
