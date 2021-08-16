import 'package:cards.io/main.dart';
import 'package:cards.io/screens/category_list.dart';
import 'package:cards.io/screens/components/player.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cards.io/api.dart' as API; 

class RegisterScreen extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
   return MaterialApp(
     title: 'Text inputs',
     home: RegisterForm(),
   );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _checkFinalValues() {
    API.API.registerPlayer(pseudoController.text, passwordController.text).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Player player = Player.fromJson(json.decode(utf8.decode(response.bodyBytes)));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryListScreen(player: player)),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'inscrire")
      ),
      body: Column(
        children: <Widget>[ 
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Pseudo'
            ),
            controller: pseudoController
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Mot de passe',
            ),
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: (){
              _checkFinalValues();
            }, 
            child: const Text("S'inscrire"),
          ),
        ]
      )
    );
  }
}