import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klinik/components/notif.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/login/login_screen.dart';

import '../../../components/my_text_field.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? userEmail = (FirebaseAuth.instance.currentUser?.email);
  bool isVisible = false;
  bool isVisible2 = true;
  bool _isSave = false;
  var docId;

  final FirebaseAuthService _auth = FirebaseAuthService();

  //membuat text controller
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  //dispose controller biar aplikasi ga makan RAM
  @override
  void dispose() {
    _fullnameController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.greenAccent),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2013/07/13/12/47/girl-160326_960_720.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isVisible == true ? isVisible = false : isVisible = true;
                  isVisible2 == false ? isVisible2 = true : isVisible2 = false;
                });
              },
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Visibility(
              visible: isVisible2,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: userEmail)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        _fullnameController.text =
                            snapshot.data!.docs[0]['full_name'];
                        _emailController.text = snapshot.data!.docs[0]['email'];
                        _alamatController.text =
                            snapshot.data!.docs[0]['alamat'];
                        _phoneController.text = snapshot.data!.docs[0]['phone'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nama Lengkap :",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(snapshot.data!.docs[0]['full_name']),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              "Alamat :",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(snapshot.data!.docs[0]['alamat']),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              "Email :",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(snapshot.data!.docs[0]['email']),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              "Phone Number :",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(snapshot.data!.docs[0]['phone']),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.hasError.toString()),
                        );
                      } else {
                        return const Center(
                            child: Text(
                          "Tidak Ada Antrian",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ));
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                  }),
            ),
            Visibility(
              visible: isVisible,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email',
                          isEqualTo: FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        docId = snapshot.data!.docs[0].id;
                        print(docId);
                        return SizedBox(
                          width: 200,
                          height: 250,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Nama Lengkap',
                                        hintText: snapshot.data!.docs[index]
                                            ['full_name'],
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Alamat',
                                        hintText: snapshot.data!.docs[index]
                                            ['alamat'],
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
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Email',
                                        hintText: snapshot.data!.docs[index]
                                            ['email'],
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
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Phone Number',
                                        hintText: snapshot.data!.docs[index]
                                            ['phone'],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.hasError.toString()),
                        );
                      } else {
                        return const Center(
                            child: Text(
                          "Tidak Ada Antrian",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ));
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                  }),
            ),
            Visibility(
              visible: isVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isVisible == true
                            ? isVisible = false
                            : isVisible = true;
                        isVisible2 == false
                            ? isVisible2 = true
                            : isVisible2 = false;
                        _fullnameController.clear();
                        _alamatController.clear();
                        _phoneController.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16, letterSpacing: 2, color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _updateUserDetail();
                      setState(() {
                        isVisible == true
                            ? isVisible = false
                            : isVisible = true;
                        isVisible2 == false
                            ? isVisible2 = true
                            : isVisible2 = false;
                        _fullnameController.clear();
                        _alamatController.clear();
                        _phoneController.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isSave
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//update user detail ke firebase
  Future _updateUserDetail() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({'full_name': _fullnameController.text});
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({'alamat': _alamatController.text});
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({'phone': _phoneController.text});
  }
}
