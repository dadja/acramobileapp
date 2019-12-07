import 'package:flutter/foundation.dart';

class Village /*extends Equatable*/ with ChangeNotifier {
  int id;
  String _nom = "nom";
  String _pays = "";
  String _region = "";
  String _departement = "";
  String _commune = "";
  String _arrondissement = "";

  String get nom => _nom;
  String get pays => _pays;
  String get region => _region;
  String get departement => _departement;
  String get commune => _commune;
  String get arrondissement => _arrondissement;

  // Village({nom, region, departement, arrondissement, commune});

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map["nom"] = nom;
    map["pays"] = pays;
    map["region"] = region;
    map["departement"] = departement;
    map["arrondissement"] = arrondissement;
    map["commune"] = commune;
    return map;
  }

  static Village fromJson(Map<String, dynamic> json) {
    // print("JSON OBJECT IS $json");
    Village village = Village();

    village.id = json["id"];
    village.nom = json["nom"];
    village.pays = json["pays"];
    village.region = json["region"];
    village.departement = json["departement"];
    village.arrondissement = json["arrondissement"];
    village.commune = json["commune"];

    return village;
  }

  set nom(String value) {
    _nom = value;
    notifyListeners();
  }

  set pays(String value) {
    _pays = value;
    notifyListeners();
  }

  set region(String value) {
    _region = value;
    notifyListeners();
  }

  set departement(String value) {
    _departement = value;
    notifyListeners();
  }

  set commune(String value) {
    _commune = value;
    notifyListeners();
  }

  set arrondissement(String value) {
    _arrondissement = value;
    notifyListeners();
  }
}
