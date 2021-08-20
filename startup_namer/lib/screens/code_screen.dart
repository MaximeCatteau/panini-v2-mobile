import 'dart:convert';

import 'package:cards.io/api.dart';
import 'package:cards.io/screens/card_package_screen.dart';
import 'package:cards.io/screens/category_list.dart';
import 'package:cards.io/screens/components/card.dart' as c;
import 'package:cards.io/screens/components/player.dart';
import 'package:cards.io/screens/register_screen.dart';
import 'package:cards.io/screens/shop_screen.dart';
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

  Player player;
  int _selectedIndex = 1;
  final codeController = TextEditingController();

  void _checkCode(code) {
    List<c.Card> cards = [];
    API.consumeCode(code, player.username, player.password).then((response) => {
      if (response.statusCode == 200) {
        setState(() {
          Iterable list = json.decode(utf8.decode(response.bodyBytes));
          cards = list.map((model) => c.Card.fromJson(model)).toList();
        }),
        Navigator.push(context, MaterialPageRoute(builder: (context) => CardPackageScreen(cards: cards, player: player)))
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CodeScreen(player: player)))
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
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopScreen(player: player)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Code de carte"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
            children: [
              Icon(
                Icons.savings,
                color: Colors.yellow.shade600,
              ),
              Text(player.cashCard.toString())
            ]),
          ),
        ],
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