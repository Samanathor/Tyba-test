import "package:http/http.dart" as http;
import 'dart:convert';

class Restaurant {
  final String name;
  final String image;
  final String location;
  final String address;

  const Restaurant(
      {required this.name,
      required this.image,
      required this.location,
      required this.address});

  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
        name: json['name'],
        address: json['address'] != null ? json['address'] : "Sin dirección",
        image: json['photo']?['images']?['small']?['url'] != null
            ? json['photo']['images']['small']['url']
            : 'https://www.freeiconspng.com/thumbs/restaurant-icon-png/pink-restaurants-icon-19.png',
        location: json['location_string'] != null
            ? json['location_string']
            : "Sin locación");
  }
}

class RestaurantProvider {
  Future<List<Restaurant>> getRestaurants(
      {required String lat, required String lng}) async {
    List<Restaurant> restaurants = [];
    final Uri uri = Uri.parse(
        'https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=$lat&longitude=$lng&limit=30&currency=USD&distance=2&open_now=false&lunit=km&lang=es_ES');
    final response = await http.get(uri, headers: {
      'x-rapidapi-key': 'US4BA2ydYLmshSAxhrTBkK3fFrxop19tuQsjsniIAcV3y5FiFO',
      'x-rapidapi-host': 'travel-advisor.p.rapidapi.com',
      "content-type": "application/json; charset=UTF-8"
    });

    Map<String, dynamic> decodedResponse = json.decode(response.body);
    List responses = decodedResponse['data'];
    responses.forEach((element) {
      if (element['name'] != null) {
        Restaurant restaurant = Restaurant.fromJson(element);
        restaurants.add(restaurant);
      }
    });

    return restaurants;
  }
}
