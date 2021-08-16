import 'dart:convert';

import 'package:cards.io/api.dart';
import 'package:cards.io/screens/code_screen.dart';
import 'package:cards.io/screens/collection_list.dart';
import 'package:cards.io/screens/components/category.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:flutter/material.dart';

class CategoryListScreen extends StatefulWidget {
  CategoryListScreen({
    required this.player
  });

  final Player player;

  @override
  createState() => _CategoryListScreenState(player: player);
}

class _CategoryListScreenState extends State{
  _CategoryListScreenState({
    required this.player
  });

  final Player player;
  var categories = [];
  int _selectedIndex = 0;

  _getCategories() {
    API.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(utf8.decode(response.bodyBytes));
        categories = list.map((model) => Category.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getCategories();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories List"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(categories[index].imageUrl),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                fit: BoxFit.cover,
              )
            ),
            child: ListTile(
              title: Text(
                categories[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionsList(categoryId: categories[index].id, player: player))),
            ),
          );
        },
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
