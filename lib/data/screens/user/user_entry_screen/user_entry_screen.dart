import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/user/user_model.dart';
import '../../../database/user/user_db.dart';

class UserEntryScreen extends StatefulWidget {
  @override
  _UserEntryScreenState createState() => _UserEntryScreenState();
}

class _UserEntryScreenState extends State<UserEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'User';

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      User newUser = User(
        userName: _userNameController.text,
        password: _passwordController.text,
        role: _role,
      );
      await UserDB.insertUser(newUser);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                IconButton(onPressed: () {Navigator.pop;}, icon: Icon(Icons.arrow_back_ios)),

                const SizedBox(
                  height: 10.0,
                ),

                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) => value!.isEmpty ? 'Enter Username' : null,
                ),

                const SizedBox(
                  height: 10.0,
                ),

                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Enter Password' : null,
                ),

                const SizedBox(
                  height: 10.0,
                ),

                DropdownButtonFormField(
                  value: _role,
                  items: ['User', 'Admin'].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _role = value.toString();
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Role'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveUser,
                  child: const Text('Save User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
