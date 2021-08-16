import 'package:cards.io/main.dart';
import 'package:cards.io/screens/category_list.dart';
import 'package:cards.io/screens/components/player.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cards.io/api.dart' as API; 

class LoginScreen extends StatelessWidget {
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
  var displayIncorrectIds = false;

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
    API.API.connectPlayer(pseudoController.text, passwordController.text).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Player player = Player.fromJson(json.decode(utf8.decode(response.bodyBytes)));
          displayIncorrectIds = false;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryListScreen(player: player)),
          );
        });
      } else {
        setState(() {
          displayIncorrectIds = true;
        });
      }
    });
  }

  Widget _displayWrongPassword () {
    if (displayIncorrectIds) {
      return const Text(
            "Pseudo ou mot de passe incorrect",
            style: TextStyle(
              color: Colors.red
            )
          );
    }

    return const Text("");
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Se connecter")
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
            child: const Text('Se connecter'),
          ),
          _displayWrongPassword(),
        ]
      )
    );
  }
}