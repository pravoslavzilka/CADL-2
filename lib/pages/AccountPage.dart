import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth auth = FirebaseAuth.instance;

class AccountPage extends StatelessWidget {


  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users')
      .where("uid",isEqualTo: auth.currentUser.uid).snapshots();


  Future<void> addRecord() {
    CollectionReference records = FirebaseFirestore.instance.collection('records');
    print(users.where("uid",isEqualTo: auth.currentUser.uid).get());
    return records
        .add({
      'title': "title 1",
      'region': "bratislava",
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        print(snapshot.data.docs[0]["region"]);
        return Scaffold(
          body: Column(
            children: [
              Center(
                child: Text(
                  snapshot.data.docs[0]["full_name"],
                  style: TextStyle(height:3,fontSize: 55),
                ),
              ),
              cusCon,
              Container(
                padding: EdgeInsets.only(top: 65.0),
                child: emailLabel,
              )
            ],
          )
        );
      },
    );
  }
}

Widget cusCon = Container(
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
      color: Colors.teal[100],
      border: Border.all(
          color: Colors.teal[100], // Set border color
          width: 3.0),   // Set border width
      borderRadius: BorderRadius.all(
          Radius.circular(10.0)), // Set rounded corner radius
      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
  ),
  child: Text("My demo styling"),
);

Widget emailLabel = Container(
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.teal[100],
      border: Border.all(
          width: 3.0,
        color: Colors.teal[100]
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(25)
      ),
      boxShadow: [BoxShadow(blurRadius: 2,color: Colors.black,offset: Offset(1,3))]
    ),
    child: Text(
      auth.currentUser.email,
      style: TextStyle(
          fontSize: 16
      ),
    )
);


Widget matBut = MaterialButton(
  child: Text("Sign out"),
  onPressed: () async {
    await FirebaseAuth.instance.signOut();
  },
);
