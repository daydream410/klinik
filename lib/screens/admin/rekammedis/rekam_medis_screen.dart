import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:klinik/screens/admin/home/admin_home_screen.dart';
import 'package:klinik/screens/admin/rekammedis/rekam_medis_edit_screen.dart';
import 'package:klinik/screens/admin/rekammedis/tambah_rekam_medis_screen.dart';

class RekamMedisScreen extends StatefulWidget {
  const RekamMedisScreen({super.key});

  @override
  State<RekamMedisScreen> createState() => _RekamMedisScreenState();
}

class _RekamMedisScreenState extends State<RekamMedisScreen> {
  @override
  Widget build(BuildContext context) {
    String? noRekamMedis;
    // int antrian = 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHomeScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Rekam Medis'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rekam_medis')
              .orderBy('timestamp')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    // antrian++;
                    return Card(
                      child: ListTile(
                        onLongPress: () async {
                          FirebaseFirestore.instance
                              .collection("rekam_medis")
                              .doc(snapshot.data?.docs[index].reference.id)
                              .delete();
                        },
                        onTap: () async {
                          noRekamMedis =
                              snapshot.data!.docs[index]['noRekamMedis'];
                          print(noRekamMedis);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RekamMedisEdit(
                                noRekamMedis: noRekamMedis,
                              ),
                            ),
                          );
                        },
                        title: Text(snapshot.data!.docs[index]['fullname']),
                        subtitle: Text(snapshot.data!.docs[index]['ttl'] +
                            " || " +
                            snapshot.data!.docs[index]['status'] +
                            " || " +
                            snapshot.data!.docs[index]['catatan']),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            const Text('No Rekam Medis:'),
                            Text(snapshot.data!.docs[index]['noRekamMedis']),
                          ],
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
                  "Tidak Ada Rekam Medis",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahRekamMedisScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
