import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DaftarRekomendasiPage extends StatefulWidget {
  @override
  _DaftarRekomendasiPageState createState() => _DaftarRekomendasiPageState();
}

class _DaftarRekomendasiPageState extends State<DaftarRekomendasiPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _toggleFavorite(String id, bool isFavorite) {
    firestore.collection('recommendations').doc(id).update({
      'isFavorite': !isFavorite,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rekomendasi'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('recommendations').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Recommendations Found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                bool isFavorite = doc['isFavorite'] ?? false;
                return ListTile(
                  leading: Image.network(doc['imageurl']),
                  title: Text(
                    doc['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    doc['description'],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () => _toggleFavorite(doc.id, isFavorite),
                  ),
                  onTap: () => _launchURL(doc['url']),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.black,
      ),
    );
  }
}
