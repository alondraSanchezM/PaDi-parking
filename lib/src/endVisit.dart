import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padi_parking/src/addCard.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'paypalPayment.dart';
import 'drawer.dart';
import 'complete.dart';

class EndVisitPage extends StatefulWidget {
  //Constructor de la clase como widget

  final int montoTotal;
  EndVisitPage(this.montoTotal, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EndVisitPageState createState() => _EndVisitPageState();
}

class _EndVisitPageState extends State<EndVisitPage> {
  //Clase principal

  //Declaración de variables
  int montoTotal;
  Razorpay _razorpay;
  String userID = "";
  String entrada = "";
  String salida = "";

  @override
  void initState() {
    super.initState();

    //Inicialización de Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  //Cierre de razorpay
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  //Mpetodo para ingrezar los datos del checkout
  void openCheckout() async {
    User user = FirebaseAuth.instance.currentUser;
    var options = {
      'key': 'rzp_test_fhBLfRFIdAgUHh',
      'amount': montoTotal * 100,
      'name': 'Padi - Parking',
      'description': 'Pagar estacionamiento',
      'prefill': {
        'contact': '2227136470',
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

  //Mpetodo para transación relizada exitosamente
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
    actStatus(userID, montoTotal.toString());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CompleteTransaction()),
        (Route<dynamic> route) => false);
  }

  //Método para recibir error del pago 
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'ERROR: ' + response.code.toString() + " _" + response.message);
  }

  //Método para mandar a un externo
  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL WALLET " + response.walletName);
  }

  //Widgets de la vista status

  Widget _labelTotalAPagar() {
    //Mostrar información total a pagar
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
  //Mostrar el monto total a pagar
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
    //Mostrar label de métodos de pago
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
    //Mostrar línea divisora
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
    //Otra línea divisora
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
    //Mostrar imagen de opción de pago Razorpay
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/payrazor.png"),
    );
  }

  Widget _imagePayPal() {
    //Mostrar imagen de opción de pago Paypal
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/paypal.png"),
    );
  }

  Widget _labelRazorpay() {
    //Mostrar label de opción de pago Razorpay
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
    //Mostrar label de opción de pago Razorpay
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
    //Botón para añadir nuevo método de pago
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
    //Widget contenedor principal

    //Manejo del estado de la visita
    montoTotal = widget.montoTotal;
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
            entrada = user.hora;
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
                                        builder: (context) => PaypalPayment(
                                              montoTotal.toString(),
                                              userID,
                                            )));
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

//Clase para el manejo de datos 
class Kisi {

  //Declaración de variables
  final String uid, hora, sector, email, nivel, noCajon, nombreEstacionamiento;
  
  //Constructor del método
  Kisi(
      {this.uid,
      this.hora,
      this.sector,
      this.email,
      this.noCajon,
      this.nivel,
      this.nombreEstacionamiento});

  factory Kisi.fromDocument(QuerySnapshot documentsSa) {
    //Manejo de documento
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      print(doc.data()['sector'].toString());
      listaDoc.add(doc);
    });

    print(listaDoc[0].data()['sector'].toString());
    print('listaDoc.length');

    print(listaDoc.length);

    //Retorno de información
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

//Método para actualizar el estado de la visita
void actStatus(String userID, String total) async {
  FirebaseFirestore.instance.collection('visits').doc(userID).update({
    "activo": "off",
    "monto": total,
  }).then((_) {});
}
