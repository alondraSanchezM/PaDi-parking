import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'complete.dart';
import 'endVisit.dart';
import 'paypalServices.dart';

// ignore: must_be_immutable
class PaypalPayment extends StatefulWidget {
  final String total;
  final String userID;
  PaypalPayment(this.total, this.userID);

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();
  EndVisitPage cambio = EndVisitPage();

  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "MXN ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "MXN"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  // = "20";

  @override
  void initState() {
    super.initState();
    String monto = "2";
    monto = widget.total;
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams(monto);
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        // ignore: deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  String itemName = 'Estacionamiento';
  int quantity = 1;

  Map<String, dynamic> getOrderParams(String monto) {
    String itemPrice = monto;
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": itemPrice,
            "currency": defaultCurrency["currency"],
          },
          "description": "Pago del estacionamiento.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              actStatus(widget.userID, widget.total);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => CompleteTransaction()),
                  (Route<dynamic> route) => false);
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
