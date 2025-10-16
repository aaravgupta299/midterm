import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:midterm/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(100),
              child: Column(
                children: [
                  Text('Username'),
                  Container(
                    width: 400,
                    height: 50,
                    child: TextField(controller: username),
                  ),
                  SizedBox(height: 25),
                  Text('Password'),
                  Container(
                    width: 400,
                    height: 50,
                    child: TextField(controller: password, obscureText: true),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      if (username.text == 'aarav' && password.text == '67') {
                        context.go('/account');
                      }
                    },
                    child: Text('Sign In'),
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
