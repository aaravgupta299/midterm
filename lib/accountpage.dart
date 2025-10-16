import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int balance = 0;
  int debt = 0;
  int? deposit = 0 ?? 0;
  int? withdraw = 0 ?? 0;
  bool loadSuccess = false;
  TextEditingController loanController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController withdrawController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text('Balance: $balance'),
                  Text('Debt: $debt'),
                  SizedBox(height: 50),
                  Text('Deposit Amount'),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Deposit Amount'),
                      controller: depositController,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        deposit = int.tryParse(depositController.text);
                        if (deposit != null && deposit! > 0) {
                          if (debt > 0) {
                            if (deposit! >= debt) {
                              deposit = deposit! - debt;
                              debt = 0;
                              balance += deposit!;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'you arent a broke boy no more (debt has been paid)',
                                    ),
                                  );
                                },
                              );
                            } else {
                              debt -= deposit!;
                              deposit = 0;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'broke boy your debt was only partially paid 💔',
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            balance += deposit!;
                          }
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  'deposit complete (intense phonk music)',
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('ts was NOT a deposit amount 💀'),
                              );
                            },
                          );
                        }
                      });
                    },
                    child: Text('Deposit'),
                  ),
                  SizedBox(height: 50),
                  Text('Withdraw Amount'),
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Withdraw Amount'),
                      controller: withdrawController,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      int? withdrawAmount = int.tryParse(
                        withdrawController.text,
                      );

                      if (withdrawAmount == null || withdrawAmount <= 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('ts was NOT a wthdrawal amount 💀'),
                            );
                          },
                        );
                        return;
                      }

                      setState(() {
                        if (withdrawAmount <= balance) {
                          // Enough money — normal withdrawal
                          balance -= withdrawAmount;
                        } else {
                          // Not enough — borrow the rest
                          int shortage = withdrawAmount - balance;
                          debt += shortage;
                          balance = 0;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  'broke boy needed loan support 💔',
                                ),
                              );
                            },
                          );
                        }
                      });
                    },
                    child: Text('Withdraw'),
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
