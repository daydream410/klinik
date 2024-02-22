// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klinik/components/notif.dart';
import 'package:klinik/firebase_auth/firebase_auth_service.dart';
import 'package:klinik/screens/user/home/home_screen.dart';
import 'package:uuid/uuid.dart';

class LayananScreen extends StatefulWidget {
  const LayananScreen({super.key});

  @override
  State<LayananScreen> createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  var uuid = Uuid();

  //membuat text controller
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _catatanController = TextEditingController();

  //dispose controller biar aplikasi ga makan RAM
  @override
  void dispose() {
    _fullnameController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  _LayananScreenState() {
    _selectedVal = _jenisLayanan[0];
  }

  String? _selectedVal = '';
  final _jenisLayanan = [
    'Pemeriksaan Ibu dan Anak',
    'Pemeriksaan Kehamilan',
    'Imunisasi dan KB'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Layanan Klinik'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  hintText: "Nama Lengkap",
                  labelText: "Nama Lengkap",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                value: _selectedVal,
                items: _jenisLayanan
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                    // print(_selectedVal);
                  });
                },
                decoration: const InputDecoration(labelText: 'Jenis Layanan'),
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
                  Timer(const Duration(seconds: 2), () {
                    NotificationService.showSimpleNotification(
                      title: 'Beep beeep!',
                      body: 'Data Layanan Baru',
                      payload: 'Manajemen Pasien',
                    );
                  });
                  addLayanan(
                    //memanggil method
                    _fullnameController.text,
                    _selectedVal!,
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
                                builder: (context) => const HomeScreen(),
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
                  backgroundColor: Colors.greenAccent,
                ),
                child: const Text(
                  'Daftar',
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
      String fullname, String jenisLayanan, String catatan) async {
    await FirebaseFirestore.instance.collection('layanan').add({
      'full_name': fullname,
      'jenis_layanan': jenisLayanan,
      'catatan': catatan,
      'timestamp': Timestamp.now(),
      'kode': 1,
      'id': uuid.v4(),
    });
  }
}
