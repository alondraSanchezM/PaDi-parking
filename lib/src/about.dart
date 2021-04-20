import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  Widget _labelTittle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'PaDi',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 48,
        ),
      ),
    );
  }

  Widget _labelLogo() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Image.asset("assets/logo.png"),
    );
  }
  
  Widget _labelVersion() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Versión  1.12',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }


  Widget _labelLine() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        ' _____________________________________ ',
                textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

    Widget _labelDisenado() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Diseñado por:',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }
  
    Widget _labelDisenadoP() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Alondra Sánchez',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }


    Widget _labelProgramado() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Programado por:',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }
  
    Widget _labelProgramadoP() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Alondra Sánchez \nDeisy D. Gonzalez \n Mark A. López',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

   Widget _labelDerechos() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Copyright © 2021 \n Todos los derechos reservados',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
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
              padding: EdgeInsets.symmetric(horizontal: 62),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 24),
                    _labelTittle(),
                    _labelLogo(),
                    _labelVersion(),
                    SizedBox(height: 14),
                    _labelLine(),
                    _labelDisenado(),
                    _labelDisenadoP(),
                    _labelProgramado(),
                    _labelProgramadoP(),
                    _labelLine(),
                    SizedBox(height: 14),
                    _labelDerechos(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}