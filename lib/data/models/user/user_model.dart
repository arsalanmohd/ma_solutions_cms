class User {
  final int? id;
  final String userName;
  final String password;
  final String role;

  User({
    this.id,
    required this.userName,
    required this.password,
    required this.role,
  });

  // Convert a User object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'role': role,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        userName: map['userName'],
        password: map['password'],
        role: map['role']
    );
  }
}

