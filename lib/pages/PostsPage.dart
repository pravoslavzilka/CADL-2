import 'package:flutter/material.dart';


class PostsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text("Sent"),
            ],
          ),
          Row(
            children: [

            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0,right: 30.0),
        child: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue[900],
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                  ),
                  builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Send email'),
                          onTap: () {
                            print('Send email');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Call phone'),
                          onTap: () {
                            print('Call phone');
                          },
                        ),

                      ],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}