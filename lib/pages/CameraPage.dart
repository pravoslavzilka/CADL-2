import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import 'AccountPage.dart';
import 'side_pages/SingleNewPage.dart';



class CameraPage extends StatelessWidget {

  final Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance.collection('articles').orderBy('Date').snapshots();
  final Stream<QuerySnapshot> _eventsStream = FirebaseFirestore.instance.collection('events').orderBy('Start').snapshots();


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
        return StreamBuilder(
          stream: _eventsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
            if (snapshot2.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Something went wrong..."),
                ),
              );
            }

            if (snapshot2.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: Text("Loading..."),
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
                            padding: EdgeInsets.only(top: 20,left: 10,),
                            child: Center(
                              child: Text(
                                "Zamračené 8°C",
                                style: TextStyle(
                                    fontSize: 30
                                ),
                              ),
                            )
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 50,bottom: 25, left:10),
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
                            children: snapshot2.data.docs.map((DocumentSnapshot document) {
                              return eventItem(
                                context, document.data()['Title'],document.data()['Location'],document.data()['Start'],document.data()['End'],document.data()['actual_start_time'],document.data()['actual_end_time']);
                            }).toList(),
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
        );
  }
}


Widget eventItem (context, String title, String location, String start, String end, String aStart, String aEnd) {
  String endTimeFinal;
  String dateSpace;
  if (end == "") {
    endTimeFinal = aStart;
    dateSpace = " ";
  } else {
    endTimeFinal = aEnd;
    dateSpace = " - ";
  }
  final Event event = Event(
    title: title,
    location: location,
    startDate: DateTime.parse(aStart),
    endDate: DateTime.parse(endTimeFinal)
  );
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
        onTap: () {
          Add2Calendar.addEvent2Cal(event);
        },
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
                      child: Text(start + dateSpace + end),
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