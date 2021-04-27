import 'package:flutter/material.dart';
import 'welcome.dart';

class CompleteTransaction extends StatefulWidget {
  _CompleteTransactionState createState() => _CompleteTransactionState();
}

class _CompleteTransactionState extends State<CompleteTransaction> {
  Color _color = Color.fromARGB(255, 207, 209, 26);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 10,
              ),
              height: 100.0,
              width: 100.0,
            ),
            Text(
              'Transacción\ncompleta',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
