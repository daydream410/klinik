import 'package:flutter/material.dart';

class InfoKlinikScreen extends StatelessWidget {
  const InfoKlinikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        title: const Text('Info Klinik'),
        centerTitle: true,
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
                            'https://cdn.discordapp.com/attachments/993306743557849139/1209791823573286932/hospital-building-healthcare-cartoon-background-vector-illustration-with-ambulance-car-doctor-patient-nurses-medical-clinic-exterior_2175-1507.png?ex=65e8356f&is=65d5c06f&hm=eede75ff3b0d49e3230edfdc02db21cc5fdd5eb9e57b1b1a1a795e56da71f372&'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Klinik :",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text('Klinik Suka Cita'),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Alamat Klinik :",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text('Jln. huru hara no.26'),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Email Klinik:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text('SpecialCare@gmail.com'),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Phone Number Klinik :",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text('+62 8523 5237 423'),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
