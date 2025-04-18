import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/screens/main_content_screen.dart';
import 'package:ma_solutions_cms/main.dart';
import 'package:ma_solutions_cms/utils/round_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ----- Logo
            const SizedBox(
              height: 150,
              width: 300,
              child: RoundedImage(imageUrl: 'images/logo for light.png', backgroundColor: Colors.white, borderRadius: 0),
            ),

            // ---------- Login
            // ------User Name
            const SizedBox(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  icon: Icon(Icons.person)
                ),

              ),
            ),

            const SizedBox(height: 20,),

            // ------Password
            const SizedBox(
              width: 350,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    icon: Icon(Icons.key)
                ),

              ),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));},
                      child: Text('Login')
                  ),

                  SizedBox(height: 20,),

                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Signup')
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
