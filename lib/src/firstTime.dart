import 'package:flutter/material.dart';

import 'login.dart';
import 'singup.dart';

class FirstTime extends StatefulWidget {
  //Constructor de la clase como widget
  FirstTime({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  //Widgets de la vista FirstTime

  //Botón para registrarse
  Widget _submitButton() { 
    return InkWell(
      onTap: () {
        Navigator.push(   //Envio a la vista de registro
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xffCFD11A)),
        child: Text(
          'REGÍSTRATE GRATIS',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  //Botón para iniciar sesión
  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(   //Envio a la vista de iniciar sesión
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Text(
          'INICIAR SESIÓN',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xffCFD11A)),
        ),
      ),
    );
    
  }

  Widget _label() {
    //Mostrar label mensaje de cuenta
    return Container(
        margin: EdgeInsets.only(top: 15, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ));
  }
  
  Widget _labelWelcome() {
    //Mostrar label mensaje de bienvenida
    return Container(
        margin: EdgeInsets.only(top: 180, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Bienvenido a PaDi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    //Mostrar label slogan PaDi
    return Container(
        margin: EdgeInsets.only(top: 20, right: 27, bottom: 205),
        child: Column(
          children: <Widget>[
            Text(
              'Valoramos tu tiempo. Cuidamos tu salud.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    //Widget contenedor principal
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/parking.png"), 
                  fit: BoxFit.cover),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _title(),
                _submitButton(),
                _label(),
                _signUpButton(),
                SizedBox(
                  height: 30,
                ),
                _labelWelcome()
              ],
            ),
          ),
      ),
    );
  }
}