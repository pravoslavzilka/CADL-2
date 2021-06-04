import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountPage.dart';
import 'side_pages/SingleNewPage.dart';



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
                    children: <Widget>[
                      listItem(context,"Vodiči, pripravte si pevné nervy! Na bratislavských cestách sa zdržíte"),
                      listItem(context,"Ako bude Bratislava parkovať od októbra"),
                      listItem(context,"Otázniky nad Vallovým magistrátom"),
                      listItem(context,"Otvorili novú časť nultého obchvatu Bratislavy, prepojí Raču a Svätý Jur"),
                      listItem(context,"V Bratislave pribudli staré fotografie mesta ako pocta Antonovi Šmotlákovi"),
                    ],
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


Widget listItem (context, String title) {
  String content = "Nábeh bude určite postupný. Naraz sa to ani nedá spustiť – žiadne mesto na svete nespustilo parkovaciu politiku naraz. Sme v úzkom kontakte s mestami, ktoré spúšťali parkovaciu politiku na Slovensku – komunikujeme s Trenčínom, ktorý má momentálne spustených osem zón, v Česku má s parkovacou politikou skúsenosti mnoho miest… Napríklad v Brne spúšťajú zóny každého štvrť roka. Komunikujeme aj s mestom Praha, s Budapešťou, Ľubľanou, Viedňou, ktorá práve ohlasovala rozšírenie zón.";
  return Container(
    width: 250,
    margin: EdgeInsets.only(right: 10, left: 10),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNewPage(title, content)),
          );
        },
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                title: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    title,
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
}