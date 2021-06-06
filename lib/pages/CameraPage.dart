import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';

import 'AccountPage.dart';
import 'side_pages/SingleNewPage.dart';



class CameraPage extends StatelessWidget {

  final Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance.collection('articles').orderBy('Date').snapshots();
  final Stream<QuerySnapshot> _recordsStream = FirebaseFirestore.instance.collection('records').snapshots();


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _articlesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Something went wrong..."),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Text("Loading...")
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Home"),
              backgroundColor: Colors.red[800],
              centerTitle: true,
            ),
            drawer: Container(
              width: 250,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top:20),
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.account_circle),
                            Container(
                              margin: EdgeInsets.only(left:20),
                              child:Text("Your account"),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AccountPage()),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Help'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Terms of use'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: SafeArea(
                child: ListView(
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.only(top: 40,bottom: 25, left:10),
                      child: Text(
                        "News in Region",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Times",
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.docs.map((DocumentSnapshot document) {
                          return listItem(
                              context, document.data()['Title'],document.data()['Content'],document.data()['Date'],document.data()['url_address'],);
                        }).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40,bottom: 25, left:10),
                      child: Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Times",
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          eventItem(context, "Vianočné trhy", "25.5. 2021","Sad Janka Kráľa"),
                          eventItem(context, "Vinobranie", "30.8. 2021","Vajnory"),
                          eventItem(context, "Veľké hody", "2.10. 2021 - 7.10. 2021","Rača")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}

Widget eventItem (context, String title, String date, String location) {
  return Container(
    width: 250,
    margin: EdgeInsets.only(right: 10, left: 10),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: new BorderSide(color: Colors.amber, width: 2.0),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: SizedBox(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.schedule),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(date),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.place),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(location),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}


Widget listItem (context, String title, String content, String date, String url) {

  return Container(
    width: 250,
    margin: EdgeInsets.only(right: 10, left: 10),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
          side: new BorderSide(color: Colors.blue, width: 2.0),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNewPage(title, content, date, url)),
          );
        },
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                title: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                subtitle: Text(date),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}