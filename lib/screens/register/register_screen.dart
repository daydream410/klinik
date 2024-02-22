// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/user/home/home_screen.dart';

import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  //membuat text controller
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //dispose controller biar aplikasi ga makan RAM
  @override
  void dispose() {
    _fullnameController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                  height: 100,
                ),
                const Text(
                  "REGISTER",
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
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
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
                    controller: _alamatController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Alamat',
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
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone',
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
                      _signUp();
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
                            'Register',
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
                    const Text("Sudah memiliki akun? "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
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

  //membuat method register
  void _signUp() async {
    setState(() {
      _isSigning = true;
    });
    String fullname = _fullnameController.text;
    String alamat = _alamatController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    setState(() {
      _isSigning = false;
    });
    if (user != null) {
      print("User Success Created");

      //memanggil method menambahkan user detail saat register
      addUserDetail(fullname, phone, email, alamat);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      print("error");
    }
  }

  //membuat method menambahkan user detail saat register ke firebase firestore
  Future addUserDetail(
      String fullname, String phone, String email, String alamat) async {
    await FirebaseFirestore.instance.collection('users').add({
      'full_name': fullname,
      'phone': phone,
      'email': email,
      'alamat': alamat,
    });
  }
}
