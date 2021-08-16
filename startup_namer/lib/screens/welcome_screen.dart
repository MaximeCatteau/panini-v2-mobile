import 'package:cards.io/screens/register_screen.dart';
import 'package:cards.io/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }, 
            child: const Text('Se connecter'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  RegisterScreen()),
              );
            }, 
            child: const Text('S\'inscrire')
          )
        ],
      ),

    );
  }
}