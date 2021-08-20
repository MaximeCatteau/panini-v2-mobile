import 'dart:convert';

import 'package:cards.io/api.dart';
import 'package:cards.io/screens/category_list.dart';
import 'package:cards.io/screens/code_screen.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/collection.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({
    required this.player
  });

  final Player player;

  @override
  createState() => _ShopScreenState(player: player);
}

class _ShopScreenState extends State<ShopScreen> {

  _ShopScreenState({
    required this.player
  });

  final Player player;
  int _selectedIndex = 2;

  var collections = [];

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryListScreen(player: player)));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CodeScreen(player: player)));
    }
  }

  _getCollections() {
    API.getCollectionsUnpaidByPlayer(player.username, player.password).then((response) {
      setState(() {
        Iterable list = json.decode(utf8.decode(response.bodyBytes));
        collections = list.map((model) => Collection.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getCollections();
  }

  _buildDataTable() {
    return DataTable(
      columns: _buildDataColumns(), 
      rows: _buildDataRows()
    );
  }

  _buildDataColumns() {
    return [
      const DataColumn(
        label: Text(
          "Collection",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) 
        )
      ),
      const DataColumn(
        label: Text(
          "Prix",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) 
        )
      ),
      const DataColumn(
        label: Text(
          "Achat",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) 
        )
      )
    ];
  }

  _buildDataRows() {
    List<DataRow> data = [];
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent)
    );

    for (var c in collections) {
      data.add(
        DataRow(
          cells: [
            DataCell(Text(c.name)),
            DataCell(Text(c.price.toString())),
            DataCell(ElevatedButton(style: buttonStyle, onPressed: () => _buyCollection(c), child: const Text("Acheter")))
          ])
      );
    }

    return data;
  }

  _buyCollection(Collection collection) {
    _checkEnoughMoney(collection);
  }

  _buildConfirmationDialog(collectionName, context) {
    return AlertDialog(
      title: const Text("Achat confirmé !"),
      content: Text("Vous venez d'acheter la collection $collectionName."),
      actions: [
        TextButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text("OK"))
      ],
    );
  }

  _showConfirmationDialog(collectionName) {
    return showDialog(context: context, builder: (BuildContext context) {
      return _buildConfirmationDialog(collectionName, context);
    });
  }

  _checkEnoughMoney(Collection collection) {
    if (collection.price <= player.cashCard) {
      print("Enough money !");
      API.buyCollection(player.username, player.password, collection.id).then((response) => {
        if (response.statusCode == 200) {
          setState(() {
            Collection c = Collection.fromJson(json.decode(utf8.decode(response.bodyBytes)));

            player.cashCard = player.cashCard- c.price;
            _showConfirmationDialog(c.name);
          })
        }
      });
    } else {
      print("Not enough money");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Boutique de collections"),
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
        children: <Widget>[
          _buildDataTable()
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