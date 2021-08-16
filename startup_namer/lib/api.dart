import 'dart:convert';

import 'package:cards.io/main.dart';
import 'package:http/http.dart' as http;

class API {
  static const baseUrl = "https://young-waters-05741.herokuapp.com/";

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
    print(code);
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
}