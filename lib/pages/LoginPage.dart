import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;
  String _password;

  Future<void> addUser(String fullName, String region) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({
      'full_name': fullName,
      'region': region,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> _createUser() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
      addUser("John", "Bratislava");
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> _loginUser() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } catch (error) {
      print("Error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 150, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Text("CADL",style: TextStyle(fontSize: 45)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter email'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                _password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'
              ),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: MaterialButton(
              onPressed: _loginUser,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          MaterialButton(
            onPressed: _createUser,
            child: Text(
              'Sign up',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}


