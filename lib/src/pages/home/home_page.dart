import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tyba/src/providers/city_provider.dart';
import 'package:tyba/src/providers/restaurant_provider.dart';
import 'package:tyba/src/providers/transactions_provider.dart';

import 'package:tyba/src/widgets/menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cityProvider = CityProvider();
  final restauranProvider = RestaurantProvider();
  final transactionProvider = TransactionProvider();
  List<Restaurant> restaurants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscador de restaurantes"),
      ),
      drawer: menuWidget(context),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _searchInput(),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: _resultsList(),
          ),
          SizedBox(
            height: 20,
          ),
          _buttonGeo()
        ],
      ),
    );
  }

  Widget _searchInput() {
    return TypeAheadField<City?>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
              labelText: "Ingrese la ciudad para buscar restaurantes")),
      suggestionsCallback: cityProvider.getCitySuggestions,
      animationStart: 0.25,
      itemBuilder: (context, City? suggestion) {
        final city = suggestion!;
        return ListTile(
          title: Text(city.name),
        );
      },
      onSuggestionSelected: (City? suggestion) {
        var now = new DateTime.now();

        final city = suggestion!;
        final transaction = Transaction(
            date: now.toString(),
            detail: "Se ha realizado una busqueda de la ciudad: ${city.name}",
            userId: "user");
        transactionProvider.uploadTransaction(transaction);
        restauranProvider
            .getRestaurants(lat: city.lat, lng: city.lng)
            .then((value) => {
                  setState(() {
                    restaurants = value;
                  })
                });
      },
    );
  }

  Widget _resultsList() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: restaurants
          .map((e) => ListTile(
                leading: Image.network(
                  e.image,
                  width: 50.0,
                ),
                title: Text(e.name),
                subtitle: Text('${e.address}'),
              ))
          .toList(),
    );
  }

  Widget _buttonGeo() {
    return TextButton(
        onPressed: handleButtonGeo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.gps_fixed),
            SizedBox(
              width: 20,
            ),
            Text('Obtener con mi ubicación actual')
          ],
        ));
  }

  void handleButtonGeo() {
    cityProvider.determinePosition().then((value) {
      var now = new DateTime.now();

      transactionProvider.uploadTransaction(Transaction(
          date: now.toString(),
          detail:
              "Se ha hecho una busqueda por gps en las coordenadas: LAT: ${value.latitude} , LNG: ${value.longitude}",
          userId: 'userId'));
      restauranProvider
          .getRestaurants(
              lat: value.latitude.toString(), lng: value.longitude.toString())
          .then((value) => {
                setState(() {
                  restaurants = value;
                })
              });
      ;
    });
  }
}
