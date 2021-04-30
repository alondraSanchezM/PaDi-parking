import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padi_parking/src/welcome.dart';

class DataCard {
  final CollectionReference payment =
      FirebaseFirestore.instance.collection("payment");

  Future<void> createCard(String noTarjeta, String expiracion, String cvv,
      String pais, String codPostal) async {
    var uid = getRandomString(20);
    return await payment.doc(uid).set({
      'numero_tarjeta': noTarjeta,
      'expiracion': expiracion,
      'cvv': cvv,
      'pais': pais,
      'codigo_postal': codPostal,
      'uid': uid,
    });
  }
}
