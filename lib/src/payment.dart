import 'package:flutter/material.dart';
import 'welcome.dart';
import 'addPayment.dart';
import 'drawer.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Widget _master() {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imageMaster(),
          ),
        ),
        _labelMetodo1(),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _imageEliminar(),
          ),
        ),
      ],
    ));
  }

  Widget _visa() {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imageVisa(),
          ),
        ),
        _labelMetodo2(),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _imageEliminar(),
          ),
        ),
      ],
    ));
  }

  Widget _paypal() {
    return Container(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: _imagePayPal(),
          ),
        ),
        _labelMetodo3(),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _imageEliminar(),
          ),
        ),
      ],
    ));
  }

  Widget _imageEliminar() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Image.asset("assets/tache.png"),
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

  Widget _labelMetodo1() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 90),
      alignment: Alignment.topLeft,
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
      margin: EdgeInsets.only(top: 10, right: 90),
      alignment: Alignment.topLeft,
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
      margin: EdgeInsets.only(top: 10, right: 90),
      child: Text(
        'Paypal',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(left: 150),
      child: Text(
        ' ___________________________',
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
            context, MaterialPageRoute(builder: (context) => AddPaymentPage()));
      },
      child: Text(
        'Añadir método de pago   ',
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
                    _master(),
                    SizedBox(height: 24),
                    _visa(),
                    SizedBox(height: 24),
                    _paypal(),
                    SizedBox(height: 230),
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
  }
}
