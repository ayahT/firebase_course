
//ctrl+shift+l to select multiple word
//statefulw to make a statefullwidget

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
 late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "Enter your Email"),
                      controller: _email,
                      obscureText: false, //hiding text
                      enableSuggestions: true,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Enter your password"),
                      controller: _password,
                      obscureText: true, //hiding text
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                        },
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                );
              default:
                return Text("loading ");
            }
          }),
    );
  }

}
