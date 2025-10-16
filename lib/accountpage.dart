import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midterm/login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Column(children: [
                
              ],
            )],
        ),
      ),
    );
  }
}
