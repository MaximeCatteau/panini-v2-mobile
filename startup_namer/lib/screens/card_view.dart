import 'dart:convert';

import 'package:cards.io/api.dart';
import 'package:cards.io/screens/collection_screen.dart';
import 'package:cards.io/screens/components/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'components/card.dart' as c;
import 'components/collection.dart';

class CardViewScreen extends StatefulWidget {
  CardViewScreen({
    required this.cards,
    required this.type,
    required this.player
  });

  final List<c.Card> cards;
  final String type;
  final Player player;

  @override
  createState() => _CardViewScreenState(cards: cards, type: type, player: player);
}

class _CardViewScreenState extends State<CardViewScreen> {

  CarouselController buttonCarouselController = CarouselController();

  _CardViewScreenState({
    required this.cards,
    required this.type,
    required this.player
  });

  List<c.Card> cards;
  final String type;
  final Player player;

  Widget _returnImageOrCarousel() {

    c.Card card = c.Card(id: cards[0].id, label: cards[0].label, imageUrl: cards[0].imageUrl, idInCollection: cards[0].idInCollection, collectionId: cards[0].collectionId, cardRarity: cards[0].cardRarity);

    if (type == "CARD") {
      c.Card card = cards[0];
      return GestureDetector(
        onTap: () => _onCardTapped(card.collectionId),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(card.imageUrl, width: 400, height: 600)
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(

      );
    }
  }

  void _onCardTapped(collectionId) {
    Collection collection;

    API.getCollectionById(collectionId).then((collec) {
      collection = Collection.fromJson(json.decode(utf8.decode(collec.bodyBytes)));
      Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionScreen(collection: collection, player: player)));
    });
  }

  @override
  void _onItemTapped() {

    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _returnImageOrCarousel()
      ],
    );
  }
}
