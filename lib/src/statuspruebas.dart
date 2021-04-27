import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // new

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuestBook(
                  addMessage: (String message) =>
                      appState.addMessageToGuestBook(message),
                  messages: appState.guestBookMessages, // new
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _guestBookSubscription = FirebaseFirestore.instance
          .collection('visit')
          .where('activo', isEqualTo: 'on')
          // .where('id_estacionamiento', isEqualTo: 'rho00${randf.toString()}')
          .snapshots()
          .listen((snapshot) {
        _guestBookMessages = [];
        snapshot.docs.forEach((document) {
          String nombreD = document["nombreEstacionamiento"].toString();
          String messageD = document["nivel"].toString();

          _guestBookMessages.add(
            GuestBookMessage(
              name: nombreD,
              message: messageD,
            ),
          );
        });

        notifyListeners();
      });

      // to here
    } else {
      _guestBookMessages = [];
      _guestBookSubscription?.cancel();
    }
    notifyListeners();
  }

  // Add from here
  StreamSubscription<QuerySnapshot> _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;
  // to here.

  Future<DocumentReference> addMessageToGuestBook(String message) {
    return FirebaseFirestore.instance.collection('visits').add({
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser.displayName,
      'userId': FirebaseAuth.instance.currentUser.uid,
    });
  }
}

class GuestBookMessage {
  GuestBookMessage({this.name, this.message});
  final String name;
  final String message;
}

class GuestBook extends StatefulWidget {
  // Modify the following line
  GuestBook({this.addMessage, this.messages});

  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages; // new

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  // Modify from here
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // to here.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
        // Modify from here
        SizedBox(height: 8),
        // ignore: unused_local_variable
        for (var message in widget.messages)
          // Paragraph('${message.name}: ${message.message}'),
          SizedBox(height: 8),
        // to here.
      ],
    );
  }
}
