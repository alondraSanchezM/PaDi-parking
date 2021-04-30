import 'package:flutter/material.dart';
import 'drawer.dart';
import 'welcome.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _datos() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/user.png',
            width: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('NOMBRE\n',
                  style: TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 10,
                      letterSpacing: 1)),
              Text('Deisy',
                  style: TextStyle(color: Color(0xFF303030), fontSize: 16)),
              Divider(
                color: Color.fromARGB(255, 203, 202, 202),
              ),
              Text('APELLIDO\n',
                  style: TextStyle(
                      color: Color(0xFF303030),
                      fontSize: 10,
                      letterSpacing: 1)),
              Text('    Gonzalez',
                  style: TextStyle(color: Color(0xFF303030), fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _datosTelefono() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('NÚMERO DE TELÉFONO',
                  style: TextStyle(
                      color: Color(0xDD000000),
                      fontSize: 10,
                      letterSpacing: 1)),
              Text('222 345 1223',
                  style: TextStyle(
                      color: Color(0xDD000000), fontSize: 16, height: 2)),
            ],
          )
        ],
      ),
    );
  }

  Widget _datosCorreo() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('CORREO ELECTRÓNICO\n',
                  style: TextStyle(
                      color: Color(0xDD000000),
                      fontSize: 10,
                      letterSpacing: 1)),
              Text('dedagoto@gmailcom',
                  style: TextStyle(
                      color: Color(0xDD000000), fontSize: 16, height: 1))
            ],
          ),
        ],
      ),
    );
  }

  Widget _datosPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('NÚMERO DE TELÉFONO',
                  style: TextStyle(
                      color: Color(0xDD000000),
                      fontSize: 10,
                      letterSpacing: 1)),
              Text('222 345 1223',
                  style: TextStyle(
                      color: Color(0xDD000000), fontSize: 16, height: 2)),
            ],
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          toolbarHeight: 58,
          title: Padding(
            padding: const EdgeInsets.only(top: 45, bottom: 7),
            child: Text('Editar perfil'),
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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 24),
                    _datos(),
                    Divider(
                      color: Color.fromARGB(255, 203, 202, 202),
                    ),
                    _datosTelefono(),
                    Divider(
                      color: Color.fromARGB(255, 203, 202, 202),
                    ),
                    _datosCorreo(),
                    Divider(
                      color: Color.fromARGB(255, 203, 202, 202),
                    ),
                    _datosPassword(),
                    Divider(
                      color: Color.fromARGB(255, 203, 202, 202),
                    ),
                    SizedBox(height: 120),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _google(),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _facebook(),
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

  Widget _google() {
    return InkWell(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _imageGoogle(),
          ),
        ),
        _labelGoogle(),
      ],
    ));
  }

  Widget _labelGoogle() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 5),
      alignment: Alignment.topRight,
      child: Text(
        ' Añadir cuenta de Google',
        style: TextStyle(
            color: Color.fromARGB(255, 145, 196, 153),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _imageGoogle() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/search.png"),
    );
  }

  Widget _facebook() {
    return InkWell(
        child: Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _imageFacebook(),
          ),
        ),
        _labelFacebook(),
      ],
    ));
  }

  Widget _labelFacebook() {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 5),
      alignment: Alignment.topRight,
      child: Text(
        '  Añadir cuenta de Google',
        style: TextStyle(
            color: Color.fromARGB(255, 145, 196, 153),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _imageFacebook() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/facebook.png"),
    );
  }
}
