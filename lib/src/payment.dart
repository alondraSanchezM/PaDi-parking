import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'addCard.dart';
import 'datacard.dart';
import 'welcome.dart';
import 'drawer.dart';

class PaymentPage extends StatefulWidget {
  //Constructor de la clase como widget
  PaymentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  //Widgets de la vista payment

  Widget _datos(TarjVisit datosTarje) {
    //Contenedor para los datos de la tarjeta
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            for (DocumentSnapshot doc in datosTarje.listaDoc) _datosWidget(doc),
          ],
        ));
  }

  Widget _datosWidget(DocumentSnapshot doc) {
    //Datos de las tarjetas
    String numCard = '${doc.data()['numero_tarjeta'].toString()}';
    String card = numCard.substring(numCard.length - 6);
    String asterisco = '***********';
    String cardFin = asterisco + card;
    return Column(children: <Widget>[
      _tarjeta(cardFin, '${doc.data()['uid'].toString()}'),
      SizedBox(height: 30),
    ]);
  }

  Widget _tarjeta(String numero, String uidTarj) {
    //Widget con la información de la tarjeta
    Random random = new Random();
    int opc = random.nextInt(2);
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imageMaster(opc),
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
    //Botón para eliminar la tarjeta
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

  Widget _imageMaster(int opc) {
    //Tipo de imagen a mostrar (mastercard o visa)
    if (opc == 1) {
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: Image.asset("assets/master.png"),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 10),
        child: Image.asset("assets/visa.png"),
      );
    }
  }

  Widget _labelMetodo1(String numero) {
    //Widget para el label del método
    return Container(
      margin: EdgeInsets.only(top: 10, right: 30),
      alignment: Alignment.topLeft,
      child: Text(
        numero,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _divider() {
    //Línea divisora
    return Container(
      margin: EdgeInsets.only(left: 218),
      child: Text(
        ' _______________',
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _addMetodoDePago() {
    //Método para añadir un nuevo método de pago
    return InkWell(
      onTap: () {
        Navigator.push(   //Redirección a la vista añadir tarjeta
            context, MaterialPageRoute(builder: (context) => AddCard()));
      },
      child: Text(
        'Añadir tarjeta     ',
        style: TextStyle(
            color: Color(0xffCFD11A), //(255, 145, 196, 153),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _submitButton() {
    //Botón para guardar cambios
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomePage()),
            (Route<dynamic> route) => false);
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
    //Contenedor principal 
    final height = MediaQuery.of(context).size.height;
    User user1 = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      //Lectura de la base de datos
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
                            SizedBox(height: 220),
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
  //Clase para el manejo de documentos en la aplicación 

  final List<DocumentSnapshot> listaDoc; //Variable global

  //Constructor 
  TarjVisit({
    this.listaDoc,
  });

  //Método para añadir documento
  factory TarjVisit.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDocpre = [];

    documentsSa.docs.forEach((doc) {
      listaDocpre.add(doc);
    });

    return TarjVisit(listaDoc: listaDocpre);
  }
}
