import "package:http/http.dart" as http;

import 'dart:convert';

import 'package:tyba/src/settings/settings.dart';

class UserProvider {
  final userSettings = new UserSettings();
  final String _urlFirebase = 'identitytoolkit.googleapis.com';
  final String _apiFirebase = 'AIzaSyD8v6rf7tndxFgV52rcsYjLgxfwO4xSzq4';

  void logoutAuth() {
    userSettings.token = '';
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      "email": email,
      'password': password,
      "returnSecureToke": true
    };
    final Uri url = Uri.https(
        _urlFirebase, 'v1/accounts:signInWithPassword', {"key": _apiFirebase});

    final response = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      userSettings.token = decodedResponse['idToken'];
      userSettings.userId = decodedResponse['localId'];
      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(
      {required String email, required String password}) async {
    final authData = {
      "email": email,
      'password': password,
      "returnSecureToke": true
    };
    final Uri url =
        Uri.https(_urlFirebase, 'v1/accounts:signUp', {"key": _apiFirebase});

    final response = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      userSettings.token = decodedResponse['idToken'];
      userSettings.userId = decodedResponse['localId'];
      return {'ok': true, 'token': decodedResponse['idToken']};
    } else {
      return {'ok': false, 'message': decodedResponse['error']['message']};
    }
  }
}
