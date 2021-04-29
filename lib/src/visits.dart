import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class VisitsPage extends StatefulWidget {
  VisitsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VisitsPageState createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  Widget _datos(DocVisit datosVisit) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children:  <Widget> [
            for (DocumentSnapshot doc in datosVisit.listaDoc)
            _datosWidget(doc),
          ],
        ));
  }

  Widget _datosWidget(DocumentSnapshot doc) {

    return Column(
      children: <Widget>[
    Text.rich(TextSpan(
      children: <InlineSpan>[
        WidgetSpan(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${doc.data()['dia'].toString()}, ${doc.data()['hora'].toString()} \n',
                  style: TextStyle(color: Color(0xFF303030), fontSize: 20)),
              Text(
                'MX \$ ${doc.data()['monto'].toString()}.00\n',
                style: TextStyle(color: Color(0xFF757575), fontSize: 12),
              ),
            ],
          ),
        ),
        TextSpan(
            text: '${doc.data()['nombreEstacionamiento'].toString()} \n',
            style:
                TextStyle(color: Color(0xFF757575), fontSize: 14, height: 0)),
        TextSpan(
            text: 'Nivel ${doc.data()['nivel'].toString()}  |  Sector ${doc.data()['sector'].toString()}  |  No. Cajón ${doc.data()['noCajon'].toString()}',
            style: TextStyle(color: Color(0xFF757575), fontSize: 14, height: 2))
      ],
    )),            
    Divider(
              color: Color.fromARGB(255, 203, 202, 202),
            ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    User user1 = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('visits')
          .where('activo', isEqualTo: 'off')
          .where('email', isEqualTo: user1.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocVisit docList = DocVisit.fromDocument(snapshot.data);

          return Scaffold(
              appBar: AppBar(
                title: Text('Tus visitas'),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            _datos(docList),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerRight,
                                child: InkWell())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class DocVisit {
  final List<DocumentSnapshot> listaDoc;
  DocVisit({
    this.listaDoc,
  });

  factory DocVisit.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDocpre = [];

    documentsSa.docs.forEach((doc) {
      listaDocpre.add(doc);
    });

    return DocVisit(listaDoc: listaDocpre);
  }
}
