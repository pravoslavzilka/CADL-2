import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


const _url = 'https://flutter.dev';

class SingleNewPage extends StatelessWidget {

  SingleNewPage(this.title,this.content);

  final String title;
  final String content;

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

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
              onPressed: _launchURL,
            ),
          )
        ],
      ),
    );
  }
}
