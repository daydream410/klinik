// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/admin/home/admin_home_screen.dart';
import 'package:klinik/screens/admin/rekammedis/rekam_medis_screen.dart';

class TambahRekamMedisScreen extends StatefulWidget {
  const TambahRekamMedisScreen({super.key});

  @override
  State<TambahRekamMedisScreen> createState() => _TambahRekamMedisScreenState();
}

class _TambahRekamMedisScreenState extends State<TambahRekamMedisScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Rekam Medis'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _noRekamMedisController,
                decoration: const InputDecoration(
                  hintText: "No Rekam Medis",
                  labelText: "No Rekam Medis",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  hintText: "Nama Pasien",
                  labelText: "Nama Pasien",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _jkController,
                decoration: const InputDecoration(
                  hintText: "Jenis Kelamin",
                  labelText: "Jenis Kelamin",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _ttlController,
                decoration: const InputDecoration(
                  hintText: "Tempat/Tgl Lahir",
                  labelText: "Tempat/Tgl Lahir",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  hintText: "Alamat",
                  labelText: "Alamat",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _usiaController,
                decoration: const InputDecoration(
                  hintText: "Usia",
                  labelText: "Usia",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  hintText: "Status",
                  labelText: "Status",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: "Telepon",
                  labelText: "Telepon",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _catatanController,
                decoration: const InputDecoration(
                  hintText: "Catatan Tambahan",
                  labelText: "Catatan Tambahan",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  addLayanan(
                    //memanggil method
                    _noRekamMedisController.text,
                    _fullnameController.text,
                    _jkController.text,
                    _ttlController.text,
                    _alamatController.text,
                    _usiaController.text,
                    _statusController.text,
                    _phoneController.text,
                    _catatanController.text,
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Sukses'),
                      content: const SizedBox(
                        height: 50,
                        child: Text('Data Sukes Terkirim'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RekamMedisScreen(),
                              ),
                            );
                          },
                          child: const Text('Ok'),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent),
                child: const Text(
                  'Tambahkan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //membuat method menambahkan layanan ke firestore
  Future addLayanan(
      String noRekamMedis,
      String fullname,
      String jenisKelamin,
      String ttl,
      String alamat,
      String usia,
      String status,
      String phone,
      String catatan) async {
    await FirebaseFirestore.instance.collection('rekam_medis').add({
      'noRekamMedis': noRekamMedis,
      'fullname': fullname,
      'jenisKelamin': jenisKelamin,
      'ttl': ttl,
      'alamat': alamat,
      'usia': usia,
      'status': status,
      'phone': phone,
      'catatan': catatan,
      'timestamp': Timestamp.now(),
    });
  }
}
