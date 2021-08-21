import 'dart:convert';

import 'package:cards.io/main.dart';
import 'package:http/http.dart' as http;

class API {
  static const baseUrl = "https://young-waters-05741.herokuapp.com";
  //static const baseUrl = "http://192.168.1.15:8080";

  static Future getCategories() {
    var url = baseUrl + "/categories";

    return http.get(Uri.parse(url));
  }

  static Future getCollectionsByCategoryId(categoryId) {
    var url = baseUrl + "/collections/category";

    final queryParameters = {
      'categoryId': categoryId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.get(Uri.parse(url));
  }

  static Future connectPlayer(pseudo, password) {
    var url = baseUrl + "/signin";

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      )
    );
  }

  static Future registerPlayer(pseudo, password) {
    var url = baseUrl + "/signup";

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      )
    );
  }

  static Future getCardsOfCollection(collectionId) {
    var url = baseUrl + "/cards/collection";

    final queryParameters = {
      'collectionId': collectionId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.get(Uri.parse(url));
  }

  static Future getCollectionById(collectionId) {
    var url = baseUrl + "/collections";

    final queryParameters = {
      'collectionId': collectionId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.get(Uri.parse(url));
  }

  static Future getCollectionsUnpaidByPlayer(pseudo, password) {
    var url = baseUrl + "/collections/notAlreadyPaid";

    return http.post(Uri.parse(url), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      )
    );
  }

  static Future getCollectionsOwnedByPlayer(pseudo, password, categoryId) {
    var url = baseUrl + "/collections/owned";

    final queryParameters = {
      'categoryId': categoryId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.post(Uri.parse(url), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      )
    );
  }

  static Future getPlayerCardsOfCollection(pseudo, password, collectionId) {
    var url = baseUrl + "/player/cards/collection";

    final queryParameters = {
      'collectionId': collectionId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      )
    );
  }

  static Future consumeCode(code, pseudo, password) {
    var url = baseUrl + "/consume";

    final queryParameters = {
      'code': code.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      ));
  }

  static Future buyCollection(pseudo, password, collectionId) {
    var url = baseUrl + "/collections/buy";

    final queryParameters = {
      'collectionId': collectionId.toString()
    };

    final uri = Uri(queryParameters: queryParameters).query;

    url += '?' + uri;

    return http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String> {
          'username': pseudo,
          'password': password
        }
      ));
  }
}