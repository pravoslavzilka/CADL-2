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
        return Scaffold(
          appBar: AppBar(
            title: Text("Account"),
            backgroundColor: Colors.red,
            centerTitle: true,
          ),
          body:  Container(
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Center(
                      child: Text(
                          snapshot.data.docs[0]["full_name"],
                          style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top:50),
                      child: Card(
                        child: titleSection,
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10),
                    child: Card(
                      child: regionSection(snapshot.data.docs[0]["region"]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: const Card(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('About & Help'),
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: const Card(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('About region'),
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 50),
                    child: const Card(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('Terms of use'),
                          ),
                        )
                    ),
                  ),
                  Center(
                    child: matBut,
                  )
                ],
              ),
            ),
          )
        );
      },
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            Text(
              auth.currentUser.email,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.edit,
        color: Colors.red[500],
      ),
    ],
  ),
);


Widget regionSection(String region) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Region',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Text(
                region,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.edit,
          color: Colors.red[500],
        ),
      ],
    ),
  );
}

Widget matBut = ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Colors.blue,
  ),
  child: Text("Sign out"),
  onPressed: () async {
    await FirebaseAuth.instance.signOut();
  },
);
