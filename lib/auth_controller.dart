import 'dart:convert';

import 'package:ab_jokes/JokesModel.dart';
import 'package:http/http.dart' as http;

class ApiController {
  List<JokesModel> jokeList = [];

  Future<JokesModel> getApiRequest() async {
    String url = 'https://hindi-jokes-api.onrender.com/jokes/10';
    String apiKey = '4c9808d7cfe0d6a04074b47abc91';
    try {
      final response =
          await http.get(Uri.parse('$url?api_key=$apiKey'), headers: {
        'authorization': 'Bearer $apiKey',
      });
       jokeList = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print(jokeList);
        return JokesModel.fromJson(jokeList as Map<String, dynamic>);
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $e');
      throw e;
    }
  }
}
