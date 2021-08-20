import 'dart:convert';

import 'package:cards.io/api.dart';
import 'package:cards.io/screens/code_screen.dart';
import 'package:cards.io/screens/collection_screen.dart';
import 'package:cards.io/screens/components/collection.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:cards.io/screens/shop_screen.dart';
import 'package:flutter/material.dart';

/*class CollectionList extends StatelessWidget {
  CollectionList({ required this.id, required this.name, required this.player});

  final int id;
  final String name;
  final Player player;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.black87,
      ),
      body: CollectionsList(
        categoryId: id,
        player: player,
      ),
    );
  }
}*/

class CollectionsList extends StatefulWidget {
  CollectionsList({
    required this.categoryId,
    required this.player
  });

  final int categoryId;
  final Player player;

  @override
  createState() => _CollectionsListState(categoryId: categoryId, player: player);
}

class _CollectionsListState extends State {
  _CollectionsListState({
    required this.categoryId,
    required this.player
  });

  var collectionsList = [];
  final int categoryId;
  final Player player;
  int _selectedIndex = 0;
  
  _getCollections(categoryId) {
    API.getCollectionsOwnedByPlayer(player.username, player.password, categoryId).then((response) {
      setState(() {
        Iterable list = json.decode(utf8.decode(response.bodyBytes));
        collectionsList = list.map((model) => Collection.fromJson(model)).toList();
      });
    });
  }

  _getCollectionImage(index) {
    if (collectionsList[index].imageUrl != Null) {
      return NetworkImage(collectionsList[index].imageUrl);
    } else {
      return NetworkImage("https://cdn.pixabay.com/photo/2020/02/11/16/25/manarola-4840080_960_720.jpg");
    }
  }

  @override
  initState() {
    super.initState();
    _getCollections(categoryId);
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
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ShopScreen(player: player)));
    }
  }

  void collectionClicked(collection) {
    print(collection.id);
  }

  @override
  Widget build(BuildContext context) {
    int collectionLength = collectionsList.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des collections :"),
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
      body: ListView.builder(
        itemCount: collectionsList.length,
        itemExtent: 60,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _getCollectionImage(index),
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.dstATop),
                fit: BoxFit.cover
              )
            ),
            child: ListTile(
              title: Text(
                collectionsList[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionScreen(collection: collectionsList[index], player: player))),
            ),
          );
        }
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