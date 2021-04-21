import 'package:flutter/material.dart';
import 'addCard.dart';
import 'drawer.dart';

class AddPaymentPage extends StatefulWidget {
  AddPaymentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddPaymentPageState createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  Widget _tarjeta() {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
            child: InkWell(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imageTarjeta(),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddCard()));
          },
        )),
        Container(
            child: InkWell(
          child: Align(
            alignment: Alignment.topLeft,
            child: _labelTarjeta(),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddCard()));
          },
        )),
      ],
    ));
  }

  Widget _paypal() {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
            child: InkWell(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imagePayPal(),
          ),
          /*onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddCard()));
          },*/
        )),
        Container(
            child: InkWell(
          child: Align(
            alignment: Alignment.topLeft,
            child: _labelPayPal(),
          ),
          /*onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddCard()));
          },*/
        )),
      ],
    ));
  }

  Widget _imageTarjeta() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/tarjeta.png"),
    );
  }

  Widget _imagePayPal() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/paypal.png"),
    );
  }

  Widget _labelTarjeta() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20),
      alignment: Alignment.topRight,
      child: Text(
        'Tarjeta de crédito o débito',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelPayPal() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20),
      child: Text(
        'Paypal',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          toolbarHeight: 58,
          title: Padding(
            padding: const EdgeInsets.only(top: 45, bottom: 7),
            child: Text('Añadir métodos de pago'),
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
                    _tarjeta(),
                    SizedBox(height: 24),
                    _paypal(),
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
