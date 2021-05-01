import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();

  Future registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _pass.text,
      );
      User user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': _name.text,
        'lastName': _lastName.text
      });

      print(userCredential.user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (Route<dynamic> route) => false);
      _email.clear();
      _pass.clear();
      _name.clear();
      _lastName.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showDialogs("La contraseña es muy débil");
        _email.clear();
      } else if (e.code == 'email-already-in-use') {
        _showDialogs("Ya hay una cuenta registrada con este correo");
        _pass.clear();
        _name.clear();
        _lastName.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future _facebookLoginN() async {
    FacebookLoginResult _result = await _facebookLogin.logIn(['email']);
    switch (_result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken _accessToken = _result.accessToken;
        AuthCredential _credential =
            FacebookAuthProvider.credential(_accessToken.token);
        var a = await _auth.signInWithCredential(_credential);

        var graphResponse = await http.post(Uri.parse(
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,&access_token=${_accessToken.token}"));

        var profile = json.decode(graphResponse.body);
        print("DATOS" + profile.toString());

        setState(() async {
          User user = a.user;
          var arr = user.displayName.split(' ');
          
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'uid': user.uid,
            'email': user.email,
            'name': arr[0],
            'lastName': arr[1]
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomePage()),
              (Route<dynamic> route) => false);
        });
        break;
      default:
    }
  }

  Future<void> _showDialogs(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'PaDi dice ...',
            style: TextStyle(
              color: Color(0xe6000000),
              fontSize: 16,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(color: Color(0x99000000)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xff0C2431),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
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
    return InkWell(
      onTap: () {
        _facebookLoginN();
      },
      child: Container(
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
