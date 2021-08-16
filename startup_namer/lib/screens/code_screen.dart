import 'package:cards.io/api.dart';
import 'package:cards.io/screens/category_list.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:cards.io/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeScreen extends StatefulWidget {
  CodeScreen({
    required this.player
  });

  final Player player;

  @override
  createState() => _CodeScreenState(player: player);
}

class _CodeScreenState extends State<CodeScreen> {

  _CodeScreenState({
    required this.player
  });

  final Player player;
  int _selectedIndex = 1;
  final codeController = TextEditingController();

  void _checkCode(code) {
    API.consumeCode(code, player.username, player.password).then((response) => {
      if (response.statusCode == 200) {
        print(response)
      }
    });
  }

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryListScreen(player: player)));
    } 
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Code de carte"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Code'
            ),
            controller: codeController
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: (){
              _checkCode(codeController.text);
            }, 
            child: const Text('Valider')
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin),
            label: 'Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Boutique',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}