import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userEmail = "";

  _getUserData() async {
    await Firebase.initializeApp();
    var auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser!;

    setState(() {
      _userEmail = currentUser.email!;
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp"),
      ),
      body: Container(),
    );
  }
}
