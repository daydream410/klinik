import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AntrianScreen extends StatefulWidget {
  const AntrianScreen({super.key});

  @override
  State<AntrianScreen> createState() => _AntrianScreenState();
}

class _AntrianScreenState extends State<AntrianScreen> {
  @override
  Widget build(BuildContext context) {
    int antrian = 1;
    antrian--;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Antrian'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('layanan')
              .orderBy('timestamp')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    antrian++;
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index]['full_name']),
                        subtitle: Text(snapshot.data!.docs[index]
                                ['jenis_layanan'] +
                            " || " +
                            snapshot.data!.docs[index]['catatan']),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Antrian: $antrian'),
                            const SizedBox(height: 14),
                            Text(
                              snapshot.data!.docs[index]['kode'] == 1
                                  ? 'Menunggu Pelayanan'
                                  : 'Sedang Di Layanin',
                            ),
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
    );
  }
}
