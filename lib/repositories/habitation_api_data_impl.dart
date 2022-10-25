

import '../models/habitation.dart';
import '../models/habitations_data.dart';
import '../models/typehabitat.dart';
import '../models/typehabitat_data.dart';
import 'habitation_api_client.dart';

class HabitationApiData implements HabitationApiClient {
  final List<Habitation> _habitations = HabitationsData.buildList();

  @override
  Future<List<TypeHabitat>> getTypeHabitats() {
    return Future.delayed(
        const Duration(seconds: 1),
            () => TypehabitatData.buildList()
    );
  }


  @override
  Future<List<Habitation>> getHabitations() {
    return Future.delayed(
        const Duration(seconds: 1),
        () => _habitations
    );
  }

  @override
  Future<Habitation> getHabitation(int id) {
    return Future.delayed(
        const Duration(seconds: 1),
            () => _habitations.where((element) => element.id == id).first
    );
  }



  @override
  Future<List<Habitation>> getHabitationsTop10() {
    return Future.delayed(
        const Duration(seconds: 1),
        () => _habitations
        .where((element) => element.id%2 == 1)
        .take(10)
        .toList()
    );
  }

  @override
  Future<List<Habitation>> getMaisons() {
    return _getHabitations(isHouse: true);
  }
  @override
  Future<List<Habitation>> getAppartements() {
    return _getHabitations(isHouse: false);
  }

  @override
  Future<List<Habitation>> getHabitationsById(List<int> habitationsIds) {
    return Future.delayed(
        const Duration(seconds: 1),
        () => _habitations.takeWhile((value) => habitationsIds.contains(value.id)).toList()
    );
  }

  Future<List<Habitation>> _getHabitations({bool isHouse = true}) {
    return Future.delayed(
        const Duration(seconds: 1),
        () => _habitations
        .where((element) => element.typeHabitat.id == (isHouse ? 1 : 2))
        .toList()
    );
  }

}