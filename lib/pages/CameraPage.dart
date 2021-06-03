import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'package:google_fonts/google_fonts.dart';


class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.red,
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
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
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
                    children: <Widget>[
                      listItem,
                      Container(
                        width: 160.0,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 160.0,
                        color: Colors.green,
                      ),
                      Container(
                        width: 160.0,
                        color: Colors.yellow,
                      ),
                      Container(
                        width: 160.0,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

Widget listItem = Container(
  width: 250,
  margin: EdgeInsets.only(right:10, left: 10),
  child: Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print("hi");
      },
      child: SizedBox(
        child: Column(
          children: [
            ListTile(
              title: Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Text(
                  "Vodiči, pripravte si pevné nervy! Na bratislavských cestách sa zdržíte",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text("2.5. 2021"),
            ),
          ],
        ),
      ),
    ),
  ),
);