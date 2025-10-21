import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation1;
  late final Animation<Color?> _colorAnimation2;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  void signIn() {
    if (username.text == 'Aarav' && password.text == 'Gupta') {
      context.go('/account');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(content: Text('Wrong user or password!'));
        },
      );
    }
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
                  padding: const EdgeInsets.all(100),
                  child: Column(
                    children: [
                      const Text(
                        'Bank of Aarav',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 500, height: 25),
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: username,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Username',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: TextField(
                          onSubmitted: (value) {
                            signIn();
                          },
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Password',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
