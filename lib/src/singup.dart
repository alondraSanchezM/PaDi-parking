import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padi_parking/src/welcome.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _lastName = TextEditingController();

  Future registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //tambien deberia poner nombre y apellido
        email: _email.text,
        password: _pass.text,
      );
      print("Usuario registrado correctamente");
      print(userCredential.user);
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es muy débil.');
      } else if (e.code == 'email-already-in-use') {
        print('Ya hay una cuenta registrada con este correo');
      }
    } catch (e) {
      print(e);
    }
  }

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

  Widget _nameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'NOMBRE',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _name,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Juan',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _lastNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'APELLIDO',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0x99000000)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _lastName,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Miranda',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
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
            height: 6,
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

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Inicia sesión',
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
              child: Text('CREA UNA CUENTA CON FACEBOOK',
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

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        registerUser();
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
        'CREAR CUENTA',
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
        title: Text('Registro'),
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
                    _nameField(),
                    _lastNameField(),
                    _passwordField(),
                    _loginAccountLabel(),
                    SizedBox(height: height * .10),
                    _submitButton(),
                    SizedBox(height: 36),
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
