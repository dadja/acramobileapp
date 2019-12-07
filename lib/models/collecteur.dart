import 'package:flutter/foundation.dart';

class Collecteur with ChangeNotifier {
  String _deviceId;
  int _deviceNumber;
  String _email;
  String _nom;
  String _partenaire;
  String _prenom;
  int _tel;

  String get deviceId => _deviceId;
  int get deviceNumber => _deviceNumber;
  String get email => _email;
  String get nom => _nom;
  String get partenaire => _partenaire;
  String get prenom => _prenom;
  int get tel => _tel;

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map["nom"] = nom;
    map["email"] = email;
    map["deviceNumber"] = deviceNumber;
    map["partenaire"] = partenaire;
    map["prenom"] = prenom;
    map["tel"] = tel;
    map["deviceId"] = deviceId;
    return map;
  }

  static Collecteur fromJson(Map<String, dynamic> json) {
    // print("JSON OBJECT IS $json");
    Collecteur collecteur = Collecteur();

    collecteur.nom = json["nom"];
    collecteur.prenom = json["prenom"];
    collecteur.deviceId = json["deviceId"];
    collecteur.deviceNumber = json["deviceNumber"];
    collecteur.partenaire = json["partenaire"];
    collecteur.tel = json["tel"];
    collecteur.email = json["email"];

    return collecteur;
  }

  set nom(String value) {
    _nom = value;
    notifyListeners();
  }

  set prenom(String value) {
    _prenom = value;
    notifyListeners();
  }

  set deviceId(String value) {
    _deviceId = value;
    notifyListeners();
  }

  set deviceNumber(int value) {
    _deviceNumber = value;
    notifyListeners();
  }

  set partenaire(String value) {
    _partenaire = value;
    notifyListeners();
  }

  set tel(int value) {
    _tel = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}
