import 'package:flutter/material.dart';
import 'singup.dart';
import 'welcome.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  Widget _emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CORREO ELECTRÓNICO',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _email,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'yourdata@email.com',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CONTRASEÑA',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: '********',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
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
          'INICIAR SESIÓN',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _labelOr() {
    return Container(
        margin: EdgeInsets.only(top: 15, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
              'o con tu correo electrónico',
              style: TextStyle(color: Color(0xd9808F85), fontSize: 12),
            ),
          ],
        ));
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('INICIA SESIÓN CON FACEBOOK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¿Aún no tienes una cuenta?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Regístrate',
              style: TextStyle(
                  color: Color(0xffCFD11A),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  _dialogRecoverPassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recuperar contraseña',
            style: TextStyle(
              color: Color(0xe6000000),
              fontSize: 16,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Ingresa tu correo electrónico, te enviaremos un enlace para recuperar tu cuenta.',
                  style: TextStyle(color: Color(0x99000000)),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: 'tucorreo@email.com',
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCELAR',
                style: TextStyle(
                  color: Color(0xff0C2431),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                'ENVIAR',
                style: TextStyle(
                  color: Color(0xff0C2431),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Iniciar sesión'),
          backgroundColor: Color(0xff0C2431),
        ),
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
                      _facebookButton(),
                      _labelOr(),
                      SizedBox(height: 24),
                      _emailField(),
                      _passwordField(),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Text('¿Olvidaste la contraseña?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff0C2431),
                                )),
                            onTap: () {
                              Navigator.of(context)
                                  .restorablePush(_dialogRecoverPassword());
                            },
                          )),
                      SizedBox(height: 24),
                      _createAccountLabel(),
                      SizedBox(height: height * .14),
                      _submitButton(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
