import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AccountPage extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addRecord() {
    CollectionReference records = FirebaseFirestore.instance.collection('records');
    return records
        .add({
      'title': "title 1",
      'region': "bratislava",
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Center(
            child:MaterialButton(
              child: Text("Sign out ${auth.currentUser.email}"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ),
          MaterialButton(
            child: Text("create a record"),
            onPressed: addRecord,
          )
        ],
      ),
    );
  }
}