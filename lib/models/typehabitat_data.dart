import 'package:locations/models/typehabitat.dart';

class TypehabitatData {
  static final data = [
    {"id": 1, "libelle": "Maison"},
    {"id": 2, "libelle": "Appartement"}
  ];

  static List<TypeHabitat> buildList() {
    return data.map((item) => TypeHabitat.fromJson(item)).toList();
  }
}
