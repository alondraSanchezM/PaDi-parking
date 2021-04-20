import 'package:flutter/material.dart';
import 'about.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _qrScan() {
    return Center(
      child: Image.asset(
        "assets/qr.png",
      ),
    );
  }

  Widget _labelWelcome() {
    return Container(
        margin: EdgeInsets.only(top: 70),
        child: Column(
          children: <Widget>[
            Text(
              'Bienvenido a PaDi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanea tu código'),
        backgroundColor: Color(0xff0C2431),
      ),
      drawer: Drawer(
          child: new ListView(
        children: <Widget>[
          Container(
              child: InkWell(
            child: Text('Acerca de',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff0C2431),
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
          )),

          //Menu deisy
        ],
      )),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/low-shape.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 150),
                    child: Column(
                      children: <Widget>[
                        _qrScan(),
                      ],
                    ),
                  ),
                  _labelWelcome(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
