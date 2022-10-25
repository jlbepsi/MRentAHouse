
import 'location.dart';

class User {
  final int id;
  final String mail;
  final String nom;
  final String adresse;

  int nbLocations = 0;

  User(this.mail, {this.id = 0, this.nom = '', this.adresse = ''});

  bool isEmpty() {
    return mail == '-';
  }
  static User empty = User('-');
}
