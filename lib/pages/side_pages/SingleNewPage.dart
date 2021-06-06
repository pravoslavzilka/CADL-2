import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class SingleNewPage extends StatelessWidget {

  SingleNewPage(this.title,this.content,this.date,this.urlAddress);

  final String title;
  final String content;
  final String date;
  final String urlAddress;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novelty"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "Times",
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(23),
              child: Text(
                content,
                style: TextStyle(
                    fontFamily: "Times"
                ),
              ),
            ),
          Center(
            child: MaterialButton(
              child: Text("View full article"),
              onPressed: () {
                launch(urlAddress);
              },
            ),
          )
        ],
      ),
    );
  }
}
