import 'package:flutter/material.dart';
import 'about.dart';
import 'endVisit.dart';

class VisitPage extends StatefulWidget {
  VisitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  Widget _labelTittle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Galerías Serdán',
        style: TextStyle(color: Colors.black87, fontSize: 24),
      ),
    );
  }

  Widget _labelAlfiler() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/alfiler.png"),
    );
  }

  Widget _labelHoraE() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Hora de entrada',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelHora() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '9:23',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelLine() {
    return Container(
      child: Text(
        ' ________________________________________________ ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _labelLineB2() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        ' _____________________________ ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _labelDatosAparcamiento() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Datos del aparcamiento',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelNivel() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Nivel: 02',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelSector() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Sector: B',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelCajon() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'No. Cajón: 12',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EndVisitPage()));
      },
      child: Container(
        width: 149,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xff91C499),
        ),
        child: Text(
          'REGISTRAR SALIDA',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Estado de Visita'),
        backgroundColor: Color(0xff0C2431),
      ),
      drawer: Drawer(
          child: new ListView(
        children: <Widget>[
          Container(
              child: InkWell(
            child: Text('Visita Actual',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff0C2431),
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VisitPage()));
            },
          )),
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
                "assets/high-shape.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 24),
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: _labelTittle(),
                      ),
                    ),
                    _labelLine(),
                    SizedBox(height: 24),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _labelHoraE(),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _labelHora(),
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: _labelAlfiler(),
                      ),
                    ),
                    SizedBox(height: 36),
                    _labelDatosAparcamiento(),
                    SizedBox(height: 36),
                    _labelNivel(),
                    _labelLineB2(),
                    _labelSector(),
                    _labelLineB2(),
                    _labelCajon(),
                    _labelLineB2(),
                    SizedBox(height: 84),
                    _submitButton(),
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
