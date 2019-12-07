import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/foundation.dart';

class BatimentPublicData with ChangeNotifier {
  String _latitude = "";
  String _longitude = "";
  String _nombatiment = "";
  DateTime _date = DateTime.now().toUtc();
  String _soustypebatiment = "";
  String _typebatiment = "";
  bool _robinetexistant = false;
  bool _robinetfonctionnel = false;
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
  String get nombatiment => _nombatiment;
  DateTime get date => _date;
  String get soustypebatiment => _soustypebatiment;
  String get typebatiment => _typebatiment;
  bool get robinetexistant => _robinetexistant;
  bool get robinetfonctionnel => _robinetfonctionnel;
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

  set nombatiment(String value) {
    _nombatiment = value;
    notifyListeners();
  }

  set date(DateTime value) {
    _date = value;
    notifyListeners();
  }

  set soustypebatiment(String value) {
    _soustypebatiment = value;
    notifyListeners();
  }

  set typebatiment(String value) {
    _typebatiment = value;
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

  BatimentPublicData(
      {latitude,
      longitude,
      nombatiment,
      date,
      soustypebatiment,
      typebatiment,
      robinetexistant,
      robinetfonctionnel,
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

  fromJson(Map<String, dynamic> json) {
    pays = json['pays'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nombatiment = json['nombatiment'];
    date = json['date'];
    soustypebatiment = json['soustypebatiment'];
    typebatiment = json['typebatiment'];
    robinetexistant = json['robinetexistant'];
    robinetfonctionnel = json['robinetfonctionnel'];
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

  factory BatimentPublicData.fromFireStore(DocumentSnapshot doc) {
    Map json = doc.data;
    BatimentPublicData batpub = BatimentPublicData();
    batpub.pays = json['pays'];
    batpub.latitude = json['latitude'];
    batpub.longitude = json['longitude'];
    batpub.nombatiment = json['nombatiment'];
    batpub.date = convertStamp(json['date']) ?? DateTime.now();
    batpub.soustypebatiment = json['soustypebatiment'];
    batpub.typebatiment = json['typebatiment'];
    batpub.robinetexistant = json['robinetexistant'] ?? false;
    batpub.robinetfonctionnel = json['robinetfonctionnel'] ?? false;
    batpub.note = json['note'];
    batpub.partenaire = json['partenaire'];
    batpub.collecteur = json['collecteur'];
    batpub.typecollecte = json['typecollecte'];
    batpub.region = json['region'];
    batpub.departement = json['departement'];
    batpub.arrondissement = json['arrondissement'];
    batpub.commune = json['commune'];
    batpub.village = json['village'];

    return batpub;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = latitude;
    data['pays'] = pays;
    data['longitude'] = longitude;
    data['nombatiment'] = nombatiment;
    data['date'] = date;
    data['soustypebatiment'] = soustypebatiment;
    data['typebatiment'] = typebatiment;
    data['robinetexistant'] = robinetexistant;
    data['robinetfonctionnel'] = robinetfonctionnel;
    data['note'] = note;
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

  // factory BatimentPublicData.fromFireStore(DocumentSnapshot doc)
  //  {
  //    Map data = doc.data;
  //     return BatimentPublicData(
  //      latitude : data['latitude'],
  //      longitude : data['longitude'],
  //      nombatiment : data['nombatiment'],
  //      date : data['date'],
  //      soustypebatiment : data['soustypebatiment'],
  //      typebatiment : data['typebatiment'],
  //      robinetexistant : data['robinetexistant'],
  //      robinetfonctionnel : data['robinetfonctionnel'],
  //      note : data['note'],
  //      partenaire : data['partenaire'],
  //      collecteur : data['collecteur'],
  //      typecollecte : data['typecollecte'],
  //     );
  //  }

}
