import 'package:cadl_2/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pages/AccountPage.dart';
import 'pages/PostsPage.dart';
import 'pages/CameraPage.dart';
import 'pages/LoginPage.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      themeMode: ThemeMode.dark,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;

                if (user == null) {
                  return LoginPage();
                } else {
                  return MyBottomNavigationBar();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("Authenticating..."),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connecting..."),
          ),
        );
      },
    );
  }
}


class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();

}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AccountPage(),
    CameraPage(),
    PostsPage(),
  ];
  final PageController controller = PageController(initialPage: 1);

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      controller.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  PageView(
        children: _pages,
        scrollDirection: Axis.horizontal,
        controller: controller,

        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
            controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },

      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: onTappedBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "Posts",
          ),
        ],
      ),
    );
  }
}