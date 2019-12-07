import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/foundation.dart';

class LatrineData with ChangeNotifier {
  String _latitude = "";
  String _longitude = "";
  String _nomproprio = "";
  String _numproprio = "";
  String _typelatrine = "";
  String _superstructure = "";
  String _dalle = "";
  bool _bonetatgeneral = false;
  bool _doublefosse = false;
  bool _siege = false;
  bool _ventilation = false;
  bool _porte = false;
  bool _fermeture = false;
  bool _toit = false;
  bool _couvercledefecation = false;
  bool _propre = false;
  bool _odeur = false;
  bool _slms = false;
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
  String get typelatrine => _typelatrine;
  String get superstructure => _superstructure;
  String get dalle => _dalle;
  bool get bonetatgeneral => _bonetatgeneral;
  bool get doublefosse => _doublefosse;
  bool get siege => _siege;
  bool get ventilation => _ventilation;
  bool get porte => _porte;
  bool get fermeture => _fermeture;
  bool get toit => _toit;
  bool get couvercledefecation => _couvercledefecation;
  bool get propre => _propre;
  bool get odeur => _odeur;
  bool get slms => _slms;
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

  set typelatrine(String value) {
    _typelatrine = value;
    notifyListeners();
  }

  set superstructure(String value) {
    _superstructure = value;
    notifyListeners();
  }

  set dalle(String value) {
    _dalle = value;
    notifyListeners();
  }

  set bonetatgeneral(bool value) {
    _bonetatgeneral = value;
    notifyListeners();
  }

  set doublefosse(bool value) {
    _doublefosse = value;
    notifyListeners();
  }

  set siege(bool value) {
    _siege = value;
    notifyListeners();
  }

  set ventilation(bool value) {
    _ventilation = value;
    notifyListeners();
  }

  set porte(bool value) {
    _porte = value;
    notifyListeners();
  }

  set fermeture(bool value) {
    _fermeture = value;
    notifyListeners();
  }

  set toit(bool value) {
    _toit = value;
    notifyListeners();
  }

  set couvercledefecation(bool value) {
    _couvercledefecation = value;
    notifyListeners();
  }

  set propre(bool value) {
    _propre = value;
    notifyListeners();
  }

  set odeur(bool value) {
    _odeur = value;
    notifyListeners();
  }

  set slms(bool value) {
    _slms = value;
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

  LatrineData(
      {latitude,
      longitude,
      nomproprio,
      numproprio,
      typelatrine,
      superstructure,
      dalle,
      bonetatgeneral,
      doublefosse,
      siege,
      ventilation,
      porte,
      fermeture,
      toit,
      couvercledefecation,
      propre,
      odeur,
      slms,
      note,
      partenaire,
      collecteur,
      typecollecte,
      region,
      departement,
      arrondissement,
      commune,
      village,
      pays,
      date});

  fromJson(Map<String, dynamic> json) {
    pays = json['pays'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nomproprio = json['nomproprio'];
    numproprio = json['numproprio'];
    typelatrine = json['typelatrine'];
    superstructure = json['superstructure'];
    dalle = json['dalle'];
    bonetatgeneral = json['bonetatgeneral'];
    doublefosse = json['doublefosse'];
    siege = json['siege'];
    ventilation = json['ventilation'];
    porte = json['porte'];
    fermeture = json['fermeture'];
    toit = json['toit'];
    couvercledefecation = json['couvercledefecation'];
    propre = json['propre'];
    odeur = json['odeur'];
    slms = json['slms'];
    note = json['note'];
    partenaire = json['partenaire'];
    collecteur = json['collecteur'];
    typecollecte = json['typecollecte'];
    region = json['region'];
    departement = json['departement'];
    arrondissement = json['arrondissement'];
    commune = json['commune'];
    village = json['village'];
    date = json['date'];
  }

  factory LatrineData.fromFireStore(DocumentSnapshot doc) {
    Map json = doc.data;

    LatrineData latrine = LatrineData();
    latrine.pays = json['pays'];
    latrine.latitude = json['latitude'];
    latrine.longitude = json['longitude'];
    latrine.nomproprio = json['nomproprio'];
    latrine.numproprio = json['numproprio'];
    latrine.typelatrine = json['typelatrine'];
    latrine.superstructure = json['superstructure'];
    latrine.dalle = json['dalle'];
    latrine.bonetatgeneral = json['bonetatgeneral'] ?? false;
    latrine.doublefosse = json['doublefosse'] ?? false;
    latrine.siege = json['siege'] ?? false;
    latrine.ventilation = json['ventilation'] ?? false;
    latrine.porte = json['porte'] ?? false;
    latrine.fermeture = json['fermeture'] ?? false;
    latrine.toit = json['toit'] ?? false;
    latrine.couvercledefecation = json['couvercledefecation'] ?? false;
    latrine.propre = json['propre'] ?? false;
    latrine.odeur = json['odeur'] ?? false;
    latrine.slms = json['slms'] ?? false;
    latrine.note = json['note'];
    latrine.partenaire = json['partenaire'];
    latrine.collecteur = json['collecteur'];
    latrine.typecollecte = json['typecollecte'];
    latrine.region = json['region'];
    latrine.departement = json['departement'];
    latrine.arrondissement = json['arrondissement'];
    latrine.commune = json['commune'];
    latrine.village = json['village'];
    latrine.date = convertStamp(json['date']) ?? DateTime.now();

    return latrine;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pays'] = pays;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['nomproprio'] = nomproprio;
    data['numproprio'] = numproprio;
    data['typelatrine'] = typelatrine;
    data['superstructure'] = superstructure;
    data['dalle'] = dalle;
    data['bonetatgeneral'] = bonetatgeneral;
    data['doublefosse'] = doublefosse;
    data['siege'] = siege;
    data['ventilation'] = ventilation;
    data['porte'] = porte;
    data['fermeture'] = fermeture;
    data['toit'] = toit;
    data['couvercledefecation'] = couvercledefecation;
    data['propre'] = propre;
    data['odeur'] = odeur;
    data['slms'] = slms;
    data['note'] = note;
    data['partenaire'] = partenaire;
    data['collecteur'] = collecteur;
    data['typecollecte'] = typecollecte;
    data['region'] = region;
    data['departement'] = departement;
    data['arrondissement'] = arrondissement;
    data['commune'] = commune;
    data['village'] = village;
    data['date'] = date;
    return data;
  }

  // LatrineData.fromFireStore(DocumentSnapshot doc)
  // {
  //   Map data = doc.data;

  //   return LatrineData(
  //   latitude : data['latitude'],
  //   longitude : data['longitude'],
  //   nomproprio : data['nomproprio'],
  //   numproprio : data['numproprio'],
  //   typelatrine : data['typelatrine'],
  //   superstructure : data['superstructure'],
  //   dalle : data['dalle'],
  //   bonetatgeneral : data['bonetatgeneral'],
  //   doublefosse : data['doublefosse'],
  //   siege : data['siege'],
  //   ventilation : data['ventilation'],
  //   porte : data['porte'],
  //   fermeture : data['fermeture'],
  //   toit : data['toit'],
  //   couvercledefecation : data['couvercledefecation'],
  //   propre : data['propre'],
  //   odeur : data['odeur'],
  //   slms : data['slms'],
  //   note : data['note'],
  //   partenaire : data['partenaire'],
  //   collecteur : data['collecteur'],
  //   typecollecte : data['typecollecte'],
  //   );
  // }

}
