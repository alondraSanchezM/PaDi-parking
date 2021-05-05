import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:padi_parking/src/status.dart';

import 'visits.dart';
import 'about.dart';
import 'firstTime.dart';
import 'payment.dart';
import 'welcome.dart';

class MenuLateral extends StatelessWidget {
  Widget build(BuildContext context) {
    User user1 = FirebaseAuth.instance.currentUser;
    FirebaseAuth _auth = FirebaseAuth.instance;
    FacebookLogin _facebookLogin = FacebookLogin();

    signOut() async {
      await _auth.signOut();
      await _facebookLogin.logOut();
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user1.email)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UsuarioData user = UsuarioData.fromDocument(snapshot.data);

          return Drawer(
            child: ListView(
              //padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name,
                    style: TextStyle(color: Color(0xFF303030), fontSize: 20),
                  ),
                  accountEmail: Text(
                    user.email,
                    style: TextStyle(color: Color(0x99000000), fontSize: 16),
                  ),
                  
                  currentAccountPicture: Image.asset('assets/avatar.png'),
                  decoration: BoxDecoration(
                    color: Color(0x3DFFFFFF),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Inicio',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    User user1 = FirebaseAuth.instance.currentUser;
                    FirebaseFirestore.instance
                        .collection('visits')
                        .where('activo', isEqualTo: 'on')
                        .where('email', isEqualTo: user1.email)
                        .limit(1)
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      if (querySnapshot.docs.length == 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                            (Route<dynamic> route) => false);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => VisitPage()),
                            (Route<dynamic> route) => false);
                      }
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Visitas',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => VisitsPage()),
                        (Route<dynamic> route) => false);
                  },
                ),
                ListTile(
                  title: Text(
                    'Métodos de pago',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                        (Route<dynamic> route) => false);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 300, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Text('Cerrar sesión',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            )),
                        onTap: () {
                          signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => FirstTime()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                      InkWell(
                        child: Text('Acerca de     v1.02',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            )),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class UsuarioData {
  final String name, email;
  UsuarioData({this.name, this.email});

  factory UsuarioData.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      listaDoc.add(doc);
    });

    return UsuarioData(
      name: listaDoc[0].data()['name'].toString() +
          ' ' +
          listaDoc[0].data()['lastName'].toString(),
      email: listaDoc[0].data()['email'].toString(),
    );
  }
}
