import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/foundation.dart';

class DangerData with ChangeNotifier {
  String _latitude = "";
  String _longitude = "";
  String _nom = "";
  String _type = "";
  String _note = "";
  String _partenaire = "";
  String _collecteur = "";
  String _typecollecte = "";
  DateTime _date = DateTime.now().toUtc();
  String _region = "";
  String _departement = "";
  String _arrondissement = "";
  String _commune = "";
  String _village = "";
  String _pays = '';

  String get pays => _pays;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get nom => _nom;
  String get type => _type;
  String get note => _note;
  String get partenaire => _partenaire;
  String get collecteur => _collecteur;
  String get typecollecte => _typecollecte;
  DateTime get date => _date;
  String get region => _region;
  String get departement => _departement;
  String get arrondissement => _arrondissement;
  String get commune => _commune;
  String get village => _village;
  //setters

  set pays(String value) {
    _pays = value;
    notifyListeners();
  }

  set latitude(String value) {
    _latitude = value;
    notifyListeners();
  }

  set longitude(String value) {
    _longitude = value;
    notifyListeners();
  }

  set nom(String value) {
    _nom = value;
    notifyListeners();
  }

  set type(String value) {
    _type = value;
    notifyListeners();
  }

  set note(String value) {
    _note = value;
    notifyListeners();
  }

  set partenaire(String value) {
    _partenaire = value;
    notifyListeners();
  }

  set collecteur(String value) {
    _collecteur = value;
    notifyListeners();
  }

  set typecollecte(String value) {
    _typecollecte = value;
    notifyListeners();
  }

  set date(DateTime value) {
    _date = value;
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

  set arrondissement(String value) {
    _arrondissement = value;
    notifyListeners();
  }

  set commune(String value) {
    _commune = value;
    notifyListeners();
  }

  set village(String value) {
    _village = value;
    notifyListeners();
  }

  DangerData(
      {latitude,
      longitude,
      nom,
      type,
      note,
      date,
      partenaire,
      collecteur,
      typecollecte,
      region,
      departement,
      arrondissement,
      commune,
      village,
      pays});

  fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    nom = json['nom'];
    pays = json['pays'];
    type = json['type'];
    note = json['note'];
    date = json['date'];
    partenaire = json['partenaire'];
    collecteur = json['collecteur'];
    typecollecte = json['typecollecte'];
    region = json['region'];
    departement = json['departement'];
    arrondissement = json['arrondissement'];
    commune = json['commune'];
    village = json['village'];
  }

  factory DangerData.fromFireStore(DocumentSnapshot doc) {
    Map json = doc.data;

    DangerData danger = DangerData();
    danger.latitude = json['latitude'];
    danger.longitude = json['longitude'];
    danger.nom = json['nom'];
    danger.type = json['type'];
    danger.note = json['note'];
    danger.pays = json['pays'];
    danger.date = convertStamp(json['date']) ?? DateTime.now();
    danger.partenaire = json['partenaire'];
    danger.collecteur = json['collecteur'];
    danger.typecollecte = json['typecollecte'];
    danger.region = json['region'];
    danger.departement = json['departement'];
    danger.arrondissement = json['arrondissement'];
    danger.commune = json['commune'];
    danger.village = json['village'];

    return danger;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['nom'] = nom;
    data['type'] = type;
    data['note'] = note;
    data['date'] = date;
    data['partenaire'] = partenaire;
    data['collecteur'] = collecteur;
    data['typecollecte'] = typecollecte;
    data['region'] = region;
    data['departement'] = departement;
    data['arrondissement'] = arrondissement;
    data['commune'] = commune;
    data['village'] = village;

    return data;
  }

  // factory DangerData.fromFireStore(DocumentSnapshot doc)
  //  {
  //    Map data = doc.data;
  //     return DangerData(
  //       nom: data['nom'],
  //       type: data['type'],
  //       latitude: data['latitude'],
  //       longitude: data['longitude'],
  //       note: data['note'],
  //       date: data['date']
  //     );
  //  }

}
