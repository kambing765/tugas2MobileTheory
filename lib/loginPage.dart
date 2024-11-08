import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugas2/homePage.dart';
import 'package:tugas2/registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool show = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '', _password = '';

  Future<void> _login() async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      SnackBar snackBar = SnackBar(content: Text("Login Berhasil!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await Future.delayed(Duration(seconds: 1));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text("Login Gagal!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Login'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 121, 0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/2769/2769493.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon:
                      Icon(Icons.people_alt_rounded, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Icon(show ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
              obscureText: show,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              child: Text('Login'),
              onPressed: _login,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              child: Text('Register'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
