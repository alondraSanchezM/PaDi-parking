import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padi_parking/src/status.dart';
import 'drawer.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'dart:math';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _qrScan() {
    User user = FirebaseAuth.instance.currentUser;

    return InkWell(
      child: PrettyQr(
          image: AssetImage('assets/PaDi-logo.png'),
          typeNumber: 3,
          size: 300,
          data: user.uid,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          roundEdges: true),
      onTap: () {
        addVisits();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VisitPage()));
      },
    );
  }

  void addVisits() async {
    String email;
    var idEstacionado;
    var nivel;
    var sector;
    var sectorL;
    String nombre;
    var noCajon;
    var activo = "on";
    var uid = getRandomString(7);
    var rng = new Random();
    var randf = 1 + rng.nextInt(2);

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        email = user.email;
        print(user.email);
      }
    });

    FirebaseFirestore.instance
        .collection('parking')
        .where('id_estacionamiento', isEqualTo: 'rho00${randf.toString()}')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        idEstacionado = doc;
        print(doc["niveles"]);
        print(doc["sectores"]);
        print(doc["total_cajones"]);

        nivel = 1 + rng.nextInt(idEstacionado["niveles"]);
        sector = 65 + rng.nextInt(idEstacionado["sectores"]);
        noCajon = 1 + rng.nextInt(idEstacionado["total_cajones"]);
        nombre = idEstacionado["nombre"];
        sectorL = String.fromCharCode(sector);
        print(idEstacionado["nombre"]);
        print(nivel);
        print(sector);
        print(sectorL);
        print(email);
        print(activo);
        print(noCajon);
        String dia =
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
        String hora = '${DateTime.now().hour}:${DateTime.now().minute}';
        FirebaseFirestore.instance.collection('visits').doc(uid).set({
          //add({
          'dia': dia,
          'hora': hora,
          'email': email,
          'nombreEstacionamiento': nombre,
          'nivel': nivel,
          'sector': sectorL,
          'noCajon': noCajon,
          'activo': activo,
          'uid': uid,
        });
      });
    });
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
      drawer: MenuLateral(),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 120, horizontal: 50),
                    child: _qrScan(),
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

String getRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
