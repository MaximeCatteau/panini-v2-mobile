import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardsBottomNavigationBar extends StatefulWidget {
  const CardsBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CardsBottomNavigationBar> createState() => _CardsBottomNavigationBarState();
}

class _CardsBottomNavigationBarState extends State<CardsBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        print("INDEX : $index");
      });
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin),
            label: 'Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Options',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}