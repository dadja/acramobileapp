import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/foundation.dart';

class BatimentPriveData with ChangeNotifier {
  String _latitude = "";
  String _longitude = "";
  String _nomproprio = "";
  String _numproprio = "";
  int _nbradultes = 0;
  int _nbrvieux = 0;
  int _nbrenfants = 0;
  bool _robinetexistant = false;
  bool _robinetfonctionnel = false;
  DateTime _date = DateTime.now().toUtc();
  String _note = "";
  String _partenaire = "";
  String _collecteur = "";
  String _typecollecte = "";
  String _region = "";
  String _departement = "";
  String _arrondissement = "";
  String _commune = "";
  String _village = "";
  String _pays = "";

  String get pays => _pays;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get nomproprio => _nomproprio;
  String get numproprio => _numproprio;
  int get nbradultes => _nbradultes;
  int get nbrvieux => _nbrvieux;
  int get nbrenfants => _nbrenfants;
  bool get robinetexistant => _robinetexistant;
  bool get robinetfonctionnel => _robinetfonctionnel;
  DateTime get date => _date;
  String get note => _note;
  String get partenaire => _partenaire;
  String get collecteur => _collecteur;
  String get typecollecte => _typecollecte;
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

  set nomproprio(String value) {
    _nomproprio = value;
    notifyListeners();
  }

  set numproprio(String value) {
    _numproprio = value;
    notifyListeners();
  }

  set nbradultes(int value) {
    _nbradultes = value;
    notifyListeners();
  }

  set nbrvieux(int value) {
    _nbrvieux = value;
    notifyListeners();
  }

  set nbrenfants(int value) {
    _nbrenfants = value;
    notifyListeners();
  }

  set robinetexistant(bool value) {
    _robinetexistant = value;
    notifyListeners();
  }

  set robinetfonctionnel(bool value) {
    _robinetfonctionnel = value;
    notifyListeners();
  }

  set date(DateTime value) {
    _date = value;
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

  BatimentPriveData(
      {latitude,
      longitude,
      nomproprio,
      numproprio,
      nbradultes,
      nbrvieux,
      nbrenfants,
      robinetexistant,
      robinetfonctionnel,
      date,
      note,
      partenaire,
      collecteur,
      typecollecte,
      region,
      departement,
      arrondissement,
      commune,
      village,
      pays});

  // _convertStamp(data['createdAt']) ?? DateTime.now()

  factory BatimentPriveData.fromFireStore(DocumentSnapshot doc) {
    Map json = doc.data;

    BatimentPriveData batpriv = BatimentPriveData();
    batpriv.pays = json['pays'];
    batpriv.latitude = json['latitude'] ?? '';
    batpriv.longitude = json['longitude'] ?? '';
    batpriv.nomproprio = json['nomproprio'] ?? '';
    batpriv.numproprio = json['numproprio'] ?? '';
    batpriv.nbradultes = json['nbradultes'] ?? 0;
    batpriv.nbrvieux = json['nbrvieux'] ?? 0;
    batpriv.nbrenfants = json['nbrenfants'] ?? 0;
    batpriv.robinetexistant = json['robinetexistant'] ?? false;
    batpriv.robinetfonctionnel = json['robinetfonctionnel'] ?? false;
    batpriv.date = convertStamp(json['date']) ?? DateTime.now();
    batpriv.note = json['note'] ?? '';
    batpriv.partenaire = json['partenaire'] ?? '';
    batpriv.collecteur = json['collecteur'] ?? '';
    batpriv.typecollecte = json['typecollecte'] ?? '';
    batpriv.region = json['region'] ?? '';
    batpriv.departement = json['departement'] ?? '';
    batpriv.arrondissement = json['arrondissement'] ?? '';
    batpriv.commune = json['commune'] ?? '';
    batpriv.village = json['village'] ?? '';

    return batpriv;
  }

  fromJson(Map<String, dynamic> json) {
    pays = json['pays'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nomproprio = json['nomproprio'];
    numproprio = json['numproprio'];
    nbradultes = json['nbradultes'];
    nbrvieux = json['nbrvieux'];
    nbrenfants = json['nbrenfants'];
    robinetexistant = json['robinetexistant'];
    robinetfonctionnel = json['robinetfonctionnel'];
    date = json['date'];
    note = json['note'];
    partenaire = json['partenaire'];
    collecteur = json['collecteur'];
    typecollecte = json['typecollecte'];
    region = json['region'];
    departement = json['departement'];
    arrondissement = json['arrondissement'];
    commune = json['commune'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['pays'] = this.pays;
    data['longitude'] = this.longitude;
    data['nomproprio'] = this.nomproprio;
    data['numproprio'] = this.numproprio;
    data['nbradultes'] = this.nbradultes;
    data['nbrvieux'] = this.nbrvieux;
    data['nbrenfants'] = this.nbrenfants;
    data['robinetexistant'] = this.robinetexistant;
    data['robinetfonctionnel'] = this.robinetfonctionnel;
    data['date'] = this.date;
    data['note'] = this.note;
    data['partenaire'] = this.partenaire;
    data['collecteur'] = this.collecteur;
    data['typecollecte'] = this.typecollecte;
    data['region'] = this.region;
    data['departement'] = this.departement;
    data['arrondissement'] = this.arrondissement;
    data['commune'] = this.commune;
    data['village'] = this.village;
    return data;
  }
}
