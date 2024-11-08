import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas2/loginPage.dart';

class BantuanPage extends StatefulWidget {
  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    await _auth.signOut();
    SnackBar snackBar = SnackBar(content: Text("Logout Berhasil!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text('Bantuan')),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cara Penggunaan Aplikasi',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 25),
              Text(
                'Daftar Anggota\n',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Berisi daftar identitas anggota kelompok\n',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Stopwatch\n',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Menu penghitung waktu\n',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Daftar Situs Rekomendasi\n',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Berisi tentang daftar website-website yang kami rekomendasikan\n',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Favorite\n',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Berisi website yang difavoritkan\n',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
