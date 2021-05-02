import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'endVisit.dart';

class VisitPage extends StatefulWidget {
  VisitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  Widget _labelTittle(String estacionamiento) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        estacionamiento,
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

  Widget _labelHora(String horaE) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        horaE,
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

  Widget _labelNivel(String nivel) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Nivel: $nivel',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelSector(String sector) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Sector: $sector',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelCajon(String noCajon) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'No. Cajón: $noCajon',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _submitButton(String entrada) {
    String salida = '${DateTime.now().hour}:${DateTime.now().minute}';
    var hSalida = int.parse(salida.split(':')[0]);
    int hEntrada = int.parse(entrada.split(':')[0]);
    int horas = hSalida - hEntrada;
    int montoTotal = 10 + horas * 15;

    return InkWell(
      onTap: () {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EndVisitPage(montoTotal)));
        });
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
    User user1 = FirebaseAuth.instance.currentUser;
    final height = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('visits')
          .where('activo', isEqualTo: 'on')
          .where('email', isEqualTo: user1.email)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Kisi user = Kisi.fromDocument(snapshot.data);
          return Scaffold(
            appBar: AppBar(
              title: Text('Estado de Visita'),
              backgroundColor: Color(0xff0C2431),
            ),
            drawer: MenuLateral(),
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
                              child: _labelTittle(user.nombreEstacionamiento),
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
                              child: _labelHora(user.hora),
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
                          _labelNivel(user.nivel),
                          _labelLineB2(),
                          _labelSector(user.sector),
                          _labelLineB2(),
                          _labelCajon(user.noCajon),
                          _labelLineB2(),
                          SizedBox(height: 84),
                          _submitButton(user.hora),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class Kisi {
  final String hora, sector, email, nivel, noCajon, nombreEstacionamiento;
  Kisi(
      {this.hora,
      this.sector,
      this.email,
      this.noCajon,
      this.nivel,
      this.nombreEstacionamiento});

  factory Kisi.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      listaDoc.add(doc);
    });

    return Kisi(
      sector: listaDoc[0].data()['sector'].toString(),
      hora: listaDoc[0].data()['hora'].toString(),
      noCajon: listaDoc[0].data()['noCajon'].toString(),
      nivel: listaDoc[0].data()['nivel'].toString(),
      nombreEstacionamiento:
          listaDoc[0].data()['nombreEstacionamiento'].toString(),
    );
  }
}
