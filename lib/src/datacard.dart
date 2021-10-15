import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padi_parking/src/welcome.dart';

class DataCard {  //Clase que contiene los métodos para la creación de tarjetas
  //Referencia a la colección payment de la base de datos
  final CollectionReference payment = FirebaseFirestore.instance.collection("payment");  

  Future<void> createCard(String user, String noTarjeta, String expiracion, //Método para crear la tarjeta
      String cvv, String pais, String codPostal) async {
    var uid = getRandomString(20);
    return await payment.doc(uid).set({   //LLenado del documento de la colección
      'user': user,
      'numero_tarjeta': noTarjeta,
      'expiracion': expiracion,
      'cvv': cvv,
      'pais': pais,
      'codigo_postal': codPostal,
      'uid': uid,
    });
  }

  Future<void> deleteCard(String uid) async {  //Método para eliminar la tarjeta de la base de datos
    return await payment.doc(uid).delete();
  }
}
