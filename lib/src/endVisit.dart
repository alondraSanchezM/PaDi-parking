import 'package:flutter/material.dart';
import 'package:padi_parking/src/payment.dart';
import 'drawer.dart';
import 'complete.dart';

class EndVisitPage extends StatefulWidget {
  EndVisitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EndVisitPageState createState() => _EndVisitPageState();
}

class _EndVisitPageState extends State<EndVisitPage> {
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
        'MX\$55.00',
        style: TextStyle(
            color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w200),
      ),
    );
  }

  Widget _imageMaster() {
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

  Widget _imageVisa() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/visa.png"),
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

  Widget _labelMetodo1() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '****2217',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelMetodo2() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '****5693',
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
            context,
            MaterialPageRoute(
                builder: (context) => PaymentPage())); //AddCard()));
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

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompleteTransaction()));
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
          'CONTINUAR',
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
        title: Text('Termina tu visita'),
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: _imageMaster(),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: _labelMetodo1(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    _labelLineB2(),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: _imageVisa(),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: _labelMetodo2(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    _labelLineB2(),
                    SizedBox(height: 24),
                    Container(
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
                    SizedBox(height: 24),
                    _labelLineB2(),
                    SizedBox(height: 24),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _addMetodoDePago(),
                      ),
                    ),
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
