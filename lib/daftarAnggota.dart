import 'package:flutter/material.dart';

class Kelompok extends StatelessWidget {
  final List<String> kelompok = [
    'Nauval Ghaina',
    'Andrean Rivan',
    'Azkal Azkiya'
  ];
  final List<String> nomorIndukMHS = ['124220069', '124220071', '124220085'];
  final List<String> profilePicture = [
    'images/nauval_doge.jpg',
    'images/andrean_padoru.gif',
    'images/azkal_kucing.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Anggota Kelompok'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: kelompok.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Image.asset(
                          profilePicture[index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Nama: ${kelompok[index]}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'NIM: ${nomorIndukMHS[index]}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
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
