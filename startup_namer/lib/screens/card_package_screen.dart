import 'package:cards.io/screens/card_view.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/card.dart' as c;

class CardPackageScreen extends StatefulWidget {
  CardPackageScreen({
    required this.cards,
    required this.player
  });

  final List<c.Card> cards;
  final Player player;

  @override
  createState() => _CardPackageScreenState(cards: cards, player: player);
}

class _CardPackageScreenState extends State<CardPackageScreen> {

  _CardPackageScreenState({
    required this.cards,
    required this.player
  });

  final List<c.Card> cards;
  final Player player;
  
  final String cardPackageImageUrl = "https://i.ibb.co/x3zPVv9/paquet-carte.png";

  @override
  void _onItemTapped() {
    if (cards.length == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CardViewScreen(cards: cards, type: "CARD", player: player)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _onItemTapped,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(cardPackageImageUrl, width: 400, height: 600)
            ],
          ),
        ),
      ),
    );
  }
}