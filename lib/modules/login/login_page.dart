import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/models/User.dart';
import 'package:whatsapp_flutter/modules/home/home_page.dart';
import 'package:whatsapp_flutter/modules/sign_up/sign_up_page.dart';
import 'package:whatsapp_flutter/shared/themes/app_colors.dart';
import 'package:whatsapp_flutter/shared/themes/app_images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _errorMessage = "";

  void _validateFields() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty) {
      setState(() {
        _errorMessage = "E-mail obrigatório";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _errorMessage = "Senha obrigatória";
      });
      return;
    }

    var user = UserModel();
    user.email = email;
    user.password = password;

    _loginUser(user);
  }

  void _loginUser(UserModel user) async {
    await Firebase.initializeApp();

    var auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((firebaseUser) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }).catchError((error) {
      setState(() {
        _errorMessage =
            "Error ao autenticar, verifique os campos e tente novamente";
      });
    });
  }

  void _checkAuthenticatedUser() async {
    await Firebase.initializeApp();
    var auth = FirebaseAuth.instance;

    User authenticatedUser = auth.currentUser!;

    if (authenticatedUser != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  void initState() {
    _checkAuthenticatedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _emailController,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: AppColors.backgroundInput,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: AppColors.backgroundInput,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                    child: const Text("Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      _validateFields();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: const Text(
                      "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
