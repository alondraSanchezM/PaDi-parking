import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'visits.dart';
import 'about.dart';
import 'firstTime.dart';
import 'payment.dart';
import 'profile.dart';

class MenuLateral extends StatelessWidget {
  Widget build(BuildContext context) {
    User user1 = FirebaseAuth.instance.currentUser;
    
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
                    'Perfil',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Visitas',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VisitsPage()));
                  },
                ),
                ListTile(
                  title: Text(
                    'Métodos de pago',
                    style: TextStyle(
                        color: Color.fromARGB(255, 12, 36, 49), fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstTime()));
                        },
                      ),
                      InkWell(
                        child: Text('Acerca de     v1.12',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
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
  UsuarioData(
      {this.name,
      this.email});

  factory UsuarioData.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      print(doc.data()['user'].toString());
      listaDoc.add(doc);
    });


    return UsuarioData(
      name: listaDoc[0].data()['name'].toString() +' '+ listaDoc[0].data()['lastName'].toString(),
      email: listaDoc[0].data()['email'].toString(),
    );
  }
}
