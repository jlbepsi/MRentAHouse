
import '../models/location.dart';

abstract class LocationApiClient {
  Future<List<Location>> getLocations();
  Future<Location> getLocation(int id);
}