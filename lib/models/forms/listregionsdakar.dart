// To parse this JSON data, do
//
//     final DataConverted = DataConvertedFromJson(jsonString);

import 'dart:convert';

ListRegionDakar ListRegionDakarFromJson(String str) =>
    ListRegionDakar.fromJson(json.decode(str));

String ListRegionDakarToJson(ListRegionDakar data) =>
    json.encode(data.toJson());

class ListRegionDakar {
  List<Region> regions = [];
  String nom;

  ListRegionDakar({this.regions, this.nom});

  factory ListRegionDakar.fromJson(Map<String, dynamic> json) =>
      ListRegionDakar(
        nom: json["nom"],
        regions:
            List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regions": List<dynamic>.from(regions.map((x) => x.toJson())),
      };
}

class Region {
  String nom = "";
  List<Departement> departements = List();

  Region({
    this.nom,
    this.departements,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        nom: json["nom"],
        departements: List<Departement>.from(
            json["departements"].map((x) => Departement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "departements": List<dynamic>.from(departements.map((x) => x.toJson())),
      };
}

class Departement {
  String nom = "";
  List<Arrondissement> arrondissements = List();

  Departement({
    this.nom,
    this.arrondissements,
  });

  factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        nom: json["nom"],
        arrondissements: List<Arrondissement>.from(
            json["arrondissements"].map((x) => Arrondissement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "arrondissements":
            List<dynamic>.from(arrondissements.map((x) => x.toJson())),
      };
}

class Arrondissement {
  String nom = "";
  List<Commune> communes = List();

  Arrondissement({
    this.nom,
    this.communes,
  });

  factory Arrondissement.fromJson(Map<String, dynamic> json) => Arrondissement(
        nom: json["nom"],
        communes: List<Commune>.from(
            json["communes"].map((x) => Commune.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "communes": List<dynamic>.from(communes.map((x) => x.toJson())),
      };
}

class Commune {
  String nom = "";

  Commune({
    this.nom,
  });

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        nom: json["nom"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
      };
}
