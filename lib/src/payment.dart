import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addCard.dart';
import 'datacard.dart';
import 'welcome.dart';
import 'drawer.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Widget _datos(TarjVisit datosTarje) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            for (DocumentSnapshot doc in datosTarje.listaDoc) _datosWidget(doc),
          ],
        ));
  }

  Widget _datosWidget(DocumentSnapshot doc) {
    String numCard = '${doc.data()['numero_tarjeta'].toString()}';
    String card = numCard.substring(numCard.length - 6);
    String asterisco = '***********';
    String cardFin = asterisco + card;
    return Column(children: <Widget>[
      _master(cardFin, '${doc.data()['uid'].toString()}'),
      SizedBox(height: 30),
    ]);
  }

  Widget _master(String numero, String uidTarj) {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imageMaster(),
          ),
        ),
        SizedBox(width: 5),
        _labelMetodo1(numero),
        Expanded(
          child: Align(
            child: _imageEliminar(uidTarj),
          ),
        ),
      ],
    ));
  }

  Widget _imageEliminar(String uidTarj) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Image.asset("assets/tache.png"),
      ),
      onTap: () {
        DataCard().deleteCard(uidTarj);
      },
    );
  }

  Widget _imageMaster() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/master.png"),
    );
  }

  Widget _labelMetodo1(String numero) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 30),
      alignment: Alignment.topLeft,
      child: Text(
        numero, //'****2217',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(left: 218),
      child: Text(
        ' _______________',
        style: TextStyle(
          color: Colors.black12,
          //color: Color.fromARGB(255, 145, 196, 153),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _addMetodoDePago() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCard()));
      },
      child: Text(
        'Añadir tarjeta     ', //'Añadir método de pago   ',
        style: TextStyle(
            color: Color.fromARGB(255, 145, 196, 153),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomePage())); //VisitPage()));
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
          'GUARDAR',
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
    User user1 = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payment')
            .where('user', isEqualTo: user1.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TarjVisit tarjList = TarjVisit.fromDocument(snapshot.data);

            return Scaffold(
              appBar: PreferredSize(
                child: AppBar(
                  toolbarHeight: 58,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 45, bottom: 7),
                    child: Text('Editar métodos de pago'),
                  ),
                  backgroundColor: Color(0xff0C2431),
                ),
                preferredSize: Size.fromHeight(75.0),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 24),
                            _datos(tarjList),
                            SizedBox(height: 300),
                            _divider(),
                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: _addMetodoDePago(),
                              ),
                            ),
                            SizedBox(height: 70),
                            _submitButton(),
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
        });
  }
}

class TarjVisit {
  final List<DocumentSnapshot> listaDoc;
  TarjVisit({
    this.listaDoc,
  });

  factory TarjVisit.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDocpre = [];

    documentsSa.docs.forEach((doc) {
      listaDocpre.add(doc);
    });

    return TarjVisit(listaDoc: listaDocpre);
  }
}
