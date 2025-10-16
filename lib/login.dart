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
                  Text(
                    'welcome to brainrot bank yunc 🥀',
                    style: TextStyle(
                      fontSize: 24.0, // Set the desired font size
                      fontWeight: FontWeight.bold, // Optional: make text bold
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ), // Optional: set text color
                    ),
                  ),
                  SizedBox(width: 400, height: 50),
                  Text('Username '),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextField(controller: username),
                  ),
                  SizedBox(height: 25),
                  Text('Password'),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextField(controller: password, obscureText: true),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      if (username.text == 'aarav' && password.text == '67') {
                        context.go('/account');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                'unc doesnt even remember his password 🥀 ',
                              ),
                            );
                          },
                        );
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
