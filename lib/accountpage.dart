import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  double balance = 0;
  double debt = 0;
  double? deposit = 0 ?? 0;
  double? withdraw = 0 ?? 0;
  bool status = true;
  String get formattedBalance => NumberFormat('#,##0.00').format(balance);
  String get formattedDebt => NumberFormat('#,##0.00').format(debt);

  TextEditingController loanController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController withdrawController = TextEditingController();

  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation1;
  late final Animation<Color?> _colorAnimation2;

  void withdrawAmount() {
    withdraw = double.tryParse(withdrawController.text);
    if (hasTwoDecimalPlaces(withdraw!) == true) {
      if (withdraw == null || withdraw! <= 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('Invalid withdrawal amount.'));
          },
        );
        return;
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text('Invalid withdrawal amount.'));
        },
      );
      return;
    }

    setState(() {
      if (withdraw! <= balance) {
        balance -= withdraw!;
      } else {
        double shortage = withdraw! - balance;
        debt += shortage;
        balance = 0;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('Notice: Loan support taken'));
          },
        );
      }
    });
  }

  void depositAmount() {
    setState(() {
      deposit = double.tryParse(depositController.text);
      if (deposit != null && deposit! > 0) {
        if (hasTwoDecimalPlaces(deposit!) == true) {
          if (debt > 0) {
            if (deposit! >= debt) {
              deposit = deposit! - debt;
              debt = 0;
              balance += deposit!;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Notice: Debt has been paid.'),
                  );
                },
              );
              status = false;
            } else {
              debt -= deposit!;
              deposit = 0;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Notice: Debt partially paid.'),
                  );
                },
              );
              status = false;
            }
          } else {
            balance += deposit!;
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text('Invalid deposit amount.'));
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('Invalid deposit amount.'));
          },
        );
        status = false;
      }
    });
  }

  bool hasTwoDecimalPlaces(double number) {
    String fixedString = number.toStringAsFixed(2);
    double roundedNumber = double.parse(fixedString);
    return number == roundedNumber;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _colorAnimation1 = ColorTween(
      begin: Colors.deepPurple,
      end: Colors.orange,
    ).animate(_controller);

    _colorAnimation2 = ColorTween(
      begin: Colors.lightBlueAccent,
      end: Colors.pinkAccent,
    ).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_colorAnimation1.value!, _colorAnimation2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Balance: \$$formattedBalance',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),

                      Text(
                        'Debt: \$$formattedDebt',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Deposit Amount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: TextField(
                          onSubmitted: (value) {
                            depositAmount();
                          },
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Deposit Amount',
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          controller: depositController,
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          depositAmount();
                        },
                        child: Text('Deposit'),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Withdraw Amount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Withdraw Amount',
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          controller: withdrawController,
                          onSubmitted: (value) {
                            withdrawAmount();
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          withdrawAmount();
                        },
                        child: Text('Withdraw'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
