import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:locations/models/location.dart';

import 'location_api_client.dart';

class LocationApiClientImpl implements LocationApiClient {
  static const String uri = 'http://10.0.2.2/api/';

  @override
  Future<List<Location>> getLocations() async {
    List<Location> list = [];

    try {
      final response = await http.get(Uri.parse('$uri/locations/locations.json'));
      if (response.statusCode == 200) {
        // var json = jsonDecode(response.body); --> problèmes avec les accents
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for(final value in json) {
          list.add(Location.fromJson(value));
        }

      } else {
        throw Exception('Impossible de récupérer les locations');
      }
    } catch(e) {
      rethrow;
    }

    return list;
  }

  @override
  Future<Location> getLocation(int id) async {
    try {
      final response = await http.get(Uri.parse('$uri/locations/location.json'));
      if (response.statusCode == 200) {
        // var json = jsonDecode(response.body); --> problèmes avec les accents
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        return Location.fromJson(json);

      } else {
        throw Exception('Impossible de récupérer la location $id');
      }
    } catch(e) {
      rethrow;
    }

  }
}