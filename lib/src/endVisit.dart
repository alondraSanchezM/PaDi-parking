import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padi_parking/src/addCard.dart';
import 'drawer.dart';
import 'complete.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'paypalPayment.dart';

class EndVisitPage extends StatefulWidget {
  EndVisitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EndVisitPageState createState() => _EndVisitPageState();
}

class _EndVisitPageState extends State<EndVisitPage> {
  int montoTotal = 55; //razor
  String total = "60"; //paypal
  Razorpay _razorpay;
  String userID = "";

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    User user = FirebaseAuth.instance.currentUser;
    var options = {
      'key': 'rzp_test_fhBLfRFIdAgUHh',
      'amount': montoTotal * 100,
      'name': 'Padi - Parking',
      'description': 'Pagar estacionamiento',
      'prefill': {
        'contact': '2227136470', // '',
        'email': user.email,
      },
      'external': {'wallets': 'paytm'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
    actStatus(userID, montoTotal.toString());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CompleteTransaction()),
        (Route<dynamic> route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'ERROR: ' + response.code.toString() + " _" + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL WALLET " + response.walletName);
  }

  Widget _labelTotalAPagar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Total a pagar',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelTotalAPagarCantidad() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'MX \$$montoTotal.00',
        style: TextStyle(
            color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w200),
      ),
    );
  }

  Widget _labelMetodos() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Tus métodos de pago',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
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
      child: Text(
        ' __________________________________________ ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _imageRazorpay() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/master.png"),
    );
  }

  Widget _imagePayPal() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/paypal.png"),
    );
  }

  Widget _labelRazorpay() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Razorpay',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelMetodo3() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Paypal',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
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
        'Añadir método de pago',
        style: TextStyle(
            color: Color(0xffCFD11A),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user1 = FirebaseAuth.instance.currentUser; //user.email
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
            userID = user.uid;
            return Scaffold(
              appBar: AppBar(
                  title: Text('Termina tu visita'),
                  backgroundColor: Color(0xff0C2431)),
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
                            SizedBox(height: 24),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: _labelTotalAPagar(),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: _labelTotalAPagarCantidad(),
                                  ),
                                ),
                              ],
                            ),
                            _labelLine(),
                            SizedBox(height: 60),
                            _labelMetodos(),
                            SizedBox(height: 16),
                            _labelLineB2(),
                            SizedBox(height: 24),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 80),
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: _imageRazorpay(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: _labelRazorpay(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                openCheckout();
                              },
                            ),
                            SizedBox(height: 24),
                            _labelLineB2(),
                            SizedBox(height: 24),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 100),
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: _imagePayPal(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: _labelMetodo3(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaypalPayment(total, userID)));
                              },
                            ),
                            SizedBox(height: 24),
                            _labelLineB2(),
                            SizedBox(height: 24),
                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: _addMetodoDePago(),
                              ),
                            ),
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

class Kisi {
  final String uid, hora, sector, email, nivel, noCajon, nombreEstacionamiento;
  Kisi(
      {this.uid,
      this.hora,
      this.sector,
      this.email,
      this.noCajon,
      this.nivel,
      this.nombreEstacionamiento});

  factory Kisi.fromDocument(QuerySnapshot documentsSa) {
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      print(doc.data()['sector'].toString());
      listaDoc.add(doc);
    });

    print(listaDoc[0].data()['sector'].toString());
    print('listaDoc.length');

    print(listaDoc.length);

    return Kisi(
        sector: listaDoc[0].data()['sector'].toString(),
        hora: listaDoc[0].data()['hora'].toString(),
        noCajon: listaDoc[0].data()['noCajon'].toString(),
        nivel: listaDoc[0].data()['nivel'].toString(),
        nombreEstacionamiento:
            listaDoc[0].data()['nombreEstacionamiento'].toString(),
        uid: listaDoc[0].data()['uid'].toString());
  }
}

void actStatus(String userID, String total) async {
  FirebaseFirestore.instance
      .collection('visits')
      .doc(userID)
      .update({"activo": "off", "monto": total}).then((_) {});
}
