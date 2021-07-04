import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:tyba/src/providers/transactions_provider.dart';

class City {
  final String name;
  final String lat;
  final String lng;

  const City({required this.name, required this.lat, required this.lng});

  static City fromJson(Map<String, dynamic> json) {
    return City(
        name: json['formatted'],
        lat: json['geometry']['lat'].toString(),
        lng: json['geometry']['lng'].toString());
  }
}

class CityProvider {
  TransactionProvider transactionProvider = TransactionProvider();
  Future<List<City>> getCitySuggestions(String query) async {
    List<City> resp = [];
    final String url =
        'https://api.opencagedata.com/geocode/v1/json?key=cc27a12e3998456fbeb11d0c8d7bc3dc&q=${query}';
    final Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      List responses = decodedResponse['results'];
      responses.forEach((element) {
        City city = City.fromJson(element);
        resp.add(city);
      });

      return resp;
    } else {
      throw Exception();
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
