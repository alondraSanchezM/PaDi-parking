import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  Widget _entryField(String title, String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 6,
          ),
          TextField(
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _blockField(String title, String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
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
                    hint: Text("México",
                        style:
                            TextStyle(fontSize: 16, color: Color(0x99000000))),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ))),
        ],
      ),
    );
  }

  Widget _formWidget() {
    return Column(
      children: <Widget>[
        _entryField("NÚMERO DE TARJETA", "1234 5678 9012 3456"),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Flexible(child: _blockField("FECHA DE EXP.", "MM/YY")),
            SizedBox(width: 20),
            Flexible(child: _blockField("CVV", "123")),
          ],
        ),
        SizedBox(height: 10),
        _dropDownList(),
        SizedBox(height: 10),
        _entryField("CÓDIGO POSTAL", "123456"),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          toolbarHeight: 128,
          title: new Padding(
            padding: const EdgeInsets.only(top: 78),
            child: new Text('Añadir tarjeta'),
          ),
          backgroundColor: Color(0xff0C2431),
        ),
        preferredSize: Size.fromHeight(128.0),
      ),
      drawer: Drawer(
          child: new ListView(
        children: <Widget>[
          Text('Primero elemento!'),
          //Menu deisy
        ],
      )),
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
