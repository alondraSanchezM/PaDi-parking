import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'endVisit.dart';

class VisitPage extends StatefulWidget {      
  //Constructor de la clase como widget
  VisitPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  //Widgets de la vista status

  Widget _labelTittle(String estacionamiento) {
    //Label para el nombre del estacionamiento
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        estacionamiento,
        style: TextStyle(color: Colors.black87, fontSize: 24),
      ),
    );
  }

  Widget _labelAlfiler() {
    //Colocación de la imagen de alfiler como diseño
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Image.asset("assets/alfiler.png"),
    );
  }

  Widget _labelHoraE() {
    //Widget para el label de hora de entrada
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Hora de entrada',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelHora(String horaE) {
    //Widget para la variable hora
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        horaE,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelLine() {
    //Widget para dibujar una linea divisora
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
    //Widget para dibujar una lidea divisora
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        ' _____________________________ ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black12,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _labelDatosAparcamiento() {
    //Widget para el label de datos del apacarcamiento
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Datos del aparcamiento',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelNivel(String nivel) {
    //Widget para mostrar el nivel 
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Nivel: $nivel',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelSector(String sector) {
    //Widget para mostrar el sector
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Sector: $sector',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _labelCajon(String noCajon) {
    //Widget para el mostrar el num del cajón
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'No. Cajón: $noCajon',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _submitButton(String entrada) {
    //Widget para definir el botón de enviar

    //Definición de variables de manejo de horas y cuota de la visita
    String salida = '${DateTime.now().hour}:${DateTime.now().minute}';
    var hSalida = int.parse(salida.split(':')[0]);
    int hEntrada = int.parse(entrada.split(':')[0]);
    int horas = hSalida - hEntrada;
    int montoTotal = 10 + horas * 15;

    return InkWell(
      onTap: () {
        Future.delayed(Duration(seconds: 2), () {    //Se añade un delay de 2 segundos
          Navigator.push(     //Envio a la pagina de endVisitPage
              context,
              MaterialPageRoute(
                  builder: (context) => EndVisitPage(montoTotal)));
        });
      },
      //Diseño del botón
      child: Container(
        width: 149,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xff91C499),
        ),
        child: Text(
          'REGISTRAR SALIDA',
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
    //Widget contenedor principal

    //Manejo de sesión del usuario con FirebaseAuth
    User user1 = FirebaseAuth.instance.currentUser;
    final height = MediaQuery.of(context).size.height;
    
    return StreamBuilder(
      //Tratamientos de datos
      stream: FirebaseFirestore.instance
          .collection('visits')
          .where('activo', isEqualTo: 'on')
          .where('email', isEqualTo: user1.email)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Kisi user = Kisi.fromDocument(snapshot.data);
          return Scaffold(
            appBar: AppBar(
              title: Text('Estado de Visita'),
              backgroundColor: Color(0xff0C2431),
            ),
            drawer: MenuLateral(),
            body: Container(
              height: height,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      "assets/high-shape.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                  //Muestreo de información en pantalla, llamado de widgets
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 24),
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: _labelTittle(user.nombreEstacionamiento),
                            ),
                          ),
                          _labelLine(),
                          SizedBox(height: 24),
                          Container(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: _labelHoraE(),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: _labelHora(user.hora),
                            ),
                          ),
                          SizedBox(height: 24),
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: _labelAlfiler(),
                            ),
                          ),
                          SizedBox(height: 36),
                          _labelDatosAparcamiento(),
                          SizedBox(height: 36),
                          _labelNivel(user.nivel),
                          _labelLineB2(),
                          _labelSector(user.sector),
                          _labelLineB2(),
                          _labelCajon(user.noCajon),
                          _labelLineB2(),
                          SizedBox(height: 84),
                          _submitButton(user.hora),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

//Clase para el manejo de datos 
class Kisi {

  //Definición de variables
  final String hora, sector, email, nivel, noCajon, nombreEstacionamiento;

  //Creación del constructor
  Kisi(
      {this.hora,
      this.sector,
      this.email,
      this.noCajon,
      this.nivel,
      this.nombreEstacionamiento});

  factory Kisi.fromDocument(QuerySnapshot documentsSa) {
    //Adición de documentos
    List<DocumentSnapshot> listaDoc = [];

    documentsSa.docs.forEach((doc) {
      listaDoc.add(doc);
    });

    return Kisi(
      //Retorno de datos convertidos a String
      sector: listaDoc[0].data()['sector'].toString(),
      hora: listaDoc[0].data()['hora'].toString(),
      noCajon: listaDoc[0].data()['noCajon'].toString(),
      nivel: listaDoc[0].data()['nivel'].toString(),
      nombreEstacionamiento:
          listaDoc[0].data()['nombreEstacionamiento'].toString(),
    );
  }
}
