import '../models/habitation.dart';
import '../models/typehabitat.dart';
import '../repositories/habitation_api_data_impl.dart';

class HabitationService {
  final HabitationApiData habitationApiClient;

  HabitationService() :
        habitationApiClient = HabitationApiData();

  Future<List<TypeHabitat>> getTypeHabitats() {
    return habitationApiClient.getTypeHabitats();
  }

  Future<List<Habitation>> getHabitationsTop10() {
    return habitationApiClient.getHabitationsTop10();
  }

  Future<List<Habitation>> getMaisons() {
    return habitationApiClient.getMaisons();
  }

  Future<List<Habitation>> getAppartements() {
    return habitationApiClient.getAppartements();
  }

  Future<List<Habitation>> getHabitations(List<int> habitationsIds) {
    return habitationApiClient.getHabitationsById(habitationsIds);
  }
}
