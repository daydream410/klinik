import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klinik/components/notif.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/login/login_screen.dart';

import '../../../components/my_text_field.dart';

class RekamMedisEdit extends StatefulWidget {
  final noRekamMedis;
  const RekamMedisEdit({
    super.key,
    required this.noRekamMedis,
  });

  @override
  State<RekamMedisEdit> createState() => _RekamMedisEditState();
}

class _RekamMedisEditState extends State<RekamMedisEdit> {
  final formKey = GlobalKey<FormState>();

  String? userEmail = (FirebaseAuth.instance.currentUser?.email);
  bool isVisible = false;
  bool isVisible2 = true;
  bool _isSave = false;
  var docId;

  final FirebaseAuthService _auth = FirebaseAuthService();

  //membuat text controller
  TextEditingController _noRekamMedisController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _jkController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _usiaController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _catatanController = TextEditingController();

  //dispose controller biar aplikasi ga makan RAM
  @override
  void dispose() {
    _noRekamMedisController.dispose();
    _fullnameController.dispose();
    _jkController.dispose();
    _ttlController.dispose();
    _alamatController.dispose();
    _usiaController.dispose();
    _statusController.dispose();
    _phoneController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Edit Rekam Medis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Visibility(
              visible: isVisible2,
              replacement: Column(
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
                    child: TextField(
                      controller: _noRekamMedisController,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'No Rekam Medis',
                        // hintText: snapshot.data!.docs[index]['noRekamMedis'],
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
                    child: TextField(
                      controller: _fullnameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Nama Lengkap',
                        // hintText: snapshot.data!.docs[index]['fullname'],
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
                    child: TextField(
                      controller: _jkController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Jenis Kelamin',
                        // hintText: snapshot.data!.docs[index]['jenisKelamin'],
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
                    child: TextField(
                      controller: _ttlController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Tempat/Tgl Lahir',
                        // hintText: snapshot.data!.docs[index]['ttl'],
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
                    child: TextField(
                      controller: _alamatController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Alamat',
                        // hintText: snapshot.data!.docs[index]['alamat'],
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
                    child: TextField(
                      controller: _usiaController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Usia',
                        // hintText: snapshot.data!.docs[index]['usia'],
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
                    child: TextField(
                      controller: _statusController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Status',
                        // hintText: snapshot.data!.docs[index]['status'],
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
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Phone Number',
                        // hintText: snapshot.data!.docs[index]['phone'],
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
                    child: TextField(
                      controller: _catatanController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Catatan Tambahan',
                        // hintText: snapshot.data!.docs[index]['catatan'],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
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
                              fontSize: 16,
                              letterSpacing: 2,
                              color: Colors.black),
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rekam_medis')
                    .where('noRekamMedis', isEqualTo: widget.noRekamMedis)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      docId = snapshot.data!.docs[0].id;
                      print(docId);
                      _noRekamMedisController.text =
                          snapshot.data!.docs[0]['noRekamMedis'];
                      _fullnameController.text =
                          snapshot.data!.docs[0]['fullname'];
                      _jkController.text =
                          snapshot.data!.docs[0]['jenisKelamin'];
                      _ttlController.text = snapshot.data!.docs[0]['ttl'];
                      _alamatController.text = snapshot.data!.docs[0]['alamat'];
                      _usiaController.text = snapshot.data!.docs[0]['usia'];
                      _statusController.text = snapshot.data!.docs[0]['status'];
                      _phoneController.text = snapshot.data!.docs[0]['phone'];
                      _catatanController.text =
                          snapshot.data!.docs[0]['catatan'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "No Rekam Medis :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['noRekamMedis']),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Nama Lengkap Pasien :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['fullname']),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Jenis Kelamin :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['jenisKelamin']),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Tempat/Tgl Lahir :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['ttl']),
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
                            "Usia :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['usia']),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Status :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['status']),
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
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "Catatan Tambahan :",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(snapshot.data!.docs[0]['catatan']),
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
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.greenAccent,
        child: TextButton(
            onPressed: () {
              setState(() {
                isVisible == true ? isVisible = false : isVisible = true;
                isVisible2 == false ? isVisible2 = true : isVisible2 = false;
              });
            },
            child: const Icon(
              Icons.edit_document,
              color: Colors.white,
            )),
      ),
    );
  }

//update user detail ke firebase
  Future _updateUserDetail() async {
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'fullname': _fullnameController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'jenisKelamin': _jkController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'ttl': _ttlController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'alamat': _alamatController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'usia': _usiaController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'status': _statusController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'phone': _phoneController.text});
    FirebaseFirestore.instance
        .collection('rekam_medis')
        .doc(docId)
        .update({'catatan': _catatanController.text});
  }
}
