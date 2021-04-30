import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'datacard.dart';
import 'drawer.dart';
import 'payment.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController _noCardController = TextEditingController();
  TextEditingController _expController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _codController = TextEditingController();
  String _pais = 'México';

  Widget _entryFieldCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "NÚMERO DE TARJETA",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: _noCardController,
            validator: (value) {
              if (value.length == 16) {
                return null;
              } else
                return 'No. tarjeta no válido';
            },
            decoration: InputDecoration(
                hintText: "1234 5678 9012 3456",
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _entryFieldCod() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "CÓDIGO POSTAL",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 6,
          ),
          TextFormField(
            controller: _codController,
            validator: (value) {
              if (value.length == 16) {
                return null;
              } else
                return 'No. tarjeta no válido';
            },
            decoration: InputDecoration(
                hintText: "123456",
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _blockFieldCVV() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "CVV",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          TextFormField(
            controller: _cvvController,
            validator: (value) {
              if (value.length == 3) {
                return null;
              } else
                return 'CVV no válido';
            },
            decoration: InputDecoration(
                hintText: "123",
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _blockFieldExp() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "FECHA DE EXP.",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          TextFormField(
            controller: _expController,
            validator: (value) {
              if (value.length == 3) {
                return 'Expiración no válido';
              } else
                return null;
            },
            decoration: InputDecoration(
                hintText: "MM/YY",
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _dropDownList() {
    String _chosenValue;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "PAÍS",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 6,
          ),
          DropdownButtonHideUnderline(
              child: Container(
                  color: Color(0x0a000000),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    isExpanded: true,
                    elevation: 5,
                    style: TextStyle(fontSize: 16, color: Color(0x99000000)),
                    items: <String>[
                      'Alemania',
                      'Francia',
                      'Inglaterra',
                      'Irlanda',
                      'Colombia',
                      'Cuba',
                      'Paises bajos',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                        _pais = value;
                      });
                    },
                    hint: Text(_pais,
                        style:
                            TextStyle(fontSize: 16, color: Color(0x99000000))),
                  ))),
        ],
      ),
    );
  }

  Widget _formWidget() {
    return Column(
      children: <Widget>[
        _entryFieldCard(),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Flexible(child: _blockFieldExp()),
            SizedBox(width: 20),
            Flexible(child: _blockFieldCVV()),
          ],
        ),
        SizedBox(height: 10),
        _dropDownList(),
        SizedBox(height: 10),
        _entryFieldCod(),
      ],
    );
  }

  Widget _submitButton() {
    User user = FirebaseAuth.instance.currentUser;
    return InkWell(
      onTap: () async {
        await DataCard().createCard(
            user.uid,
            _noCardController.text,
            _expController.text,
            _cvvController.text,
            _pais.toString(),
            _codController.text);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PaymentPage()),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 24),
                    _formWidget(),
                    SizedBox(height: height * .10),
                    _submitButton(),
                    SizedBox(height: 24),
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
