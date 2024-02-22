import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:klinik/components/notif.dart';

class ManajemenLayanan extends StatefulWidget {
  const ManajemenLayanan({super.key});

  @override
  State<ManajemenLayanan> createState() => _ManajemenLayananState();
}

class _ManajemenLayananState extends State<ManajemenLayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Manajemen Pasien'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('layanan')
              .limit(50)
              .where('kode', isEqualTo: 1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index]['full_name']),
                        subtitle: Text(snapshot.data!.docs[index]
                                ['jenis_layanan'] +
                            " || " +
                            snapshot.data!.docs[index]['catatan']),
                        trailing: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                            ),
                            child: TextButton(
                              onPressed: () async {
                                Timer(const Duration(seconds: 2), () {
                                  NotificationService.showSimpleNotification(
                                    title: 'Beep beeep!',
                                    body: 'Data Layanan Sedang Di Proses!',
                                    payload: 'Antrian Pasien',
                                  );
                                });
                                //update kode untuk menunjukan kalau layanan sedang di proses
                                await FirebaseFirestore.instance
                                    .collection('layanan')
                                    .doc(snapshot.data!.docs[index].id)
                                    .update({"kode": 2});
                              },
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //delete semua antrian
          var collection = FirebaseFirestore.instance.collection('layanan');
          var snapshots = await collection.get();
          for (var doc in snapshots.docs) {
            await doc.reference.delete();
          }
        },
        child: const Icon(Icons.delete_forever),
        backgroundColor: Colors.red,
      ),
    );
  }
}
