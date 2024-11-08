import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('recommendations')
              .where('isFavorite', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text('No Favorites Found',
                      style: TextStyle(color: Colors.white)));
            }

            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return ListTile(
                  leading: Image.network(doc['imageurl']),
                  title:
                      Text(doc['name'], style: TextStyle(color: Colors.white)),
                  subtitle: Text(doc['description'],
                      style: TextStyle(color: Colors.white)),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () {
                      firestore
                          .collection('recommendations')
                          .doc(doc.id)
                          .update({
                        'isFavorite': false,
                      });
                    },
                  ),
                  onTap: () => _launchURL(doc['url']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
