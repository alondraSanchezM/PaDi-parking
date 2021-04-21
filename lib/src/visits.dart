import 'package:flutter/material.dart';
import 'drawer.dart';

class VisitsPage extends StatefulWidget {
  VisitsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VisitsPageState createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  Widget _datos() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _datosWidget(),
            Divider(
              color: Color.fromARGB(255, 203, 202, 202),
            ),
            _datosWidget(),
            Divider(
              color: Color.fromARGB(255, 203, 202, 202),
            ),
            _datosWidget(),
            Divider(
              color: Color.fromARGB(255, 203, 202, 202),
            ),
          ],
        ));
  }

  Widget _datosWidget() {
    return Text.rich(TextSpan(
      children: <InlineSpan>[
        WidgetSpan(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('05/01/21, 10:08 am \n',
                  style: TextStyle(color: Color(0xFF303030), fontSize: 20)),
              Text(
                'MX 55.00\n',
                style: TextStyle(color: Color(0xFF757575), fontSize: 12),
              ),
            ],
          ),
        ),
        TextSpan(
            text: 'Galerias Plaza \n',
            style:
                TextStyle(color: Color(0xFF757575), fontSize: 14, height: 0)),
        TextSpan(
            text: 'Nivel 02  |  Sector B  |  No. Cajón 12',
            style: TextStyle(color: Color(0xFF757575), fontSize: 14, height: 2))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Tus visitas'),
          backgroundColor: Color(0xff0C2431),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      _datos(),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: InkWell())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
