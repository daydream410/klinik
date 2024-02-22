// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/admin/home/admin_home_screen.dart';
import 'package:klinik/screens/register/register_screen.dart';
import 'package:klinik/screens/user/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  //membuat text controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //dispose controller biar aplikasi ga makan RAM
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText
                            ? const Icon(
                                Icons.visibility_off,
                                size: 20,
                              )
                            : const Icon(
                                Icons.visibility,
                                size: 20,
                              ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      _signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isSigning
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum memiliki akun? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //membuat method login
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      print("User Success Login");
      //if else login untuk admin / users biasa
      if (email == 'admin@gmail.com') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      print("error");
    }
  }
}
