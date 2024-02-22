import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klinik/screens/admin/setting/manajemenScreen.dart';
import 'package:klinik/screens/login/login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? userEmail = (FirebaseAuth.instance.currentUser?.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Setting'),
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
            const SizedBox(
              height: 24,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: userEmail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
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
            const SizedBox(
              height: 24,
            ),
            Card(
              child: ListTile(
                title: const Text('Manajemen Pasien'),
                subtitle: const Text('Mengatur Pelayanan Pasien'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManajemenLayanan(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
