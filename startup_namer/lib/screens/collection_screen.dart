import 'dart:convert';
import 'package:cards.io/api.dart';
import 'package:cards.io/screens/code_screen.dart';
import 'package:cards.io/screens/components/collection.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cards.io/screens/components/card.dart' as Card;

class CollectionScreen extends StatefulWidget {
  CollectionScreen({
    required this.collection,
    required this.player
  });

  final Collection collection;
  final Player player;

  @override
  createState() => _CollectionScreenState(collection: collection, player: player);
}

class _CollectionScreenState extends State {
  _CollectionScreenState({
    required this.collection,
    required this.player
  });

  final Collection collection;
  final Player player;
  List<Card.Card> cardsOfCollection = [];
  List<Card.Card> playerCardsOfCollection = [];
  final String defaultCardUrl = "https://i.ibb.co/RNBJD9f/default-card.png";
  int _selectedIndex = 0;

  _getCardsOfCollectionByCollectionId(collectionId) {
    API.getCardsOfCollection(collectionId).then((response) {
      setState(() {
        Iterable list = json.decode(utf8.decode(response.bodyBytes));
        cardsOfCollection = list.map((model) => Card.Card.fromJson(model)).toList();
      });
    });
  }

  _getPlayerCardsByCollectionId(collectionId) {
    API.getPlayerCardsOfCollection(player.username, player.password, collectionId).then((response) {
      setState(() {
        Iterable list = json.decode(utf8.decode(response.bodyBytes));
        playerCardsOfCollection = list.map((model) => Card.Card.fromJson(model)).toList();
      });
    });
  }

  _buildPlayerCards() {
    for (int i = 0; i < cardsOfCollection.length; i++) {
      var found = false;
      for (int j = 0; j < playerCardsOfCollection.length; j++) {
        if (cardsOfCollection[i].id == playerCardsOfCollection[j].id) {
          found = true;
          break;
        }
      }

      if (found == false) {
        cardsOfCollection[i].imageUrl = defaultCardUrl;
      }
    }
  }

  @override
  initState() {
    super.initState();
    _getCardsOfCollectionByCollectionId(collection.id);
    _getPlayerCardsByCollectionId(collection.id);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CodeScreen(player: player)));
    } 
  }

  @override
  build(context) {
    _buildPlayerCards();
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      body: Container (
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: cardsOfCollection.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0
          ),
          itemBuilder: (BuildContext context, index) {
            return Image.network(cardsOfCollection[index].imageUrl);
          },
        ),
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