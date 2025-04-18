import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/user/user_model.dart';
import '../../../database/user/user_db.dart';
import '../user_entry_screen/user_entry_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    final userList = await UserDB.getAllUsers();
    setState(() {
      users = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].userName),
                  subtitle: Text(users[index].role),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserEntryScreen()),
              ).then((_) => fetchUsers());
            },
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}
