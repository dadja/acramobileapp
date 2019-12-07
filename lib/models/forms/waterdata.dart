//si pompe manuelle choiisr le type de pompe et definir la profondeur
//si puit definir couvercle / et type puits
//si forage definir profondeur / et tete forage protegee / choisir source alimentation
//si source definir source et amenage en plus

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/foundation.dart';
import 'package:acra/ui/uitest/multiselectchip.dart';

class WaterData with ChangeNotifier {
  String _nompointeau = "";
  String _typepointeau = "";
  String _modelepompe = "";
  String _profondeur = "";

  bool _couverclepuit = false;
  String _typepuit = "";
  DateTime _puitdateexploitation = DateTime.now().toUtc();
  // List<String> _puitusage = List();
  String _puitusage = "";
  String _puitdebithorairepompe = "";
  String _puitdureejournalierepompage = "";
  String _puitvolumemensuelpreleve = "";
  String _puitnombrejourpompage = "";
  String _puitniveaustatiquepuit = "";
  String _puitpotentielhydraulique = "";
  String _puittemperature = "";
  String _puitconductiviteelectrique = "";

// 2-Usages de l’eau (Question à choix multiple)
// - Consommation
// - Agriculture
// - Elevage
// - Autres

// 3-Débit horaire effectif de la pompe (m3/h)
// 4-Durée journalière de pompage (h)
// 5-Nombre de jour de pompage (j)
// 6-Volume mensuel prélevé (m3/an)
// 7-Niveau statique (NS)
// 8-Potentiel hydraulique (pH)
// 9-Température (T°)
// 10-Conductivité Electrique (CE)

  bool _forageteteprotege = false;
  String _foragesourcealimentation = "";
  bool _foragecloture = false;
  DateTime _foragedateexploitation = DateTime.now().toUtc();
  // List<String> _forageusage = List();
  String _forageusage = "";
  String _foragedebithorairepompe = "";
  String _foragedureejournalierepompage = "";
  String _foragevolumemensuelpreleve = "";
  String _foragenombrejourpompage = "";
  String _forageniveaustatiqueforage = "";
  String _foragepotentielhydraulique = "";
  String _foragetemperature = "";
  String _forageconductiviteelectrique = "";

  String _sourcenote = "";
  bool _sourceamenage = false;
  String _autretypepointeau = "";
  String _latitude = "";
  String _longitude = "";
  bool _bonetatgeneral = false;
  bool _cloture = false;
  bool _drainage = false;
  bool _amenage = false;
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

  void resetpuitdata() {
    _puitdateexploitation = DateTime.now().toUtc();
    _puitusage = "";
    _puitdebithorairepompe = "";
    _puitdureejournalierepompage = "";
    _puitvolumemensuelpreleve = "";
    _puitnombrejourpompage = "";
    _puitniveaustatiquepuit = "";
    _puitpotentielhydraulique = "";
    _puittemperature = "";
    _puitconductiviteelectrique = "";
    _puittemperature = "";
    _puitconductiviteelectrique = "";
    _typepuit = "";
    _couverclepuit = false;
  }

  void resetforagedata() {
    _forageteteprotege = false;
    _foragesourcealimentation = "";
    _foragecloture = false;
    _foragedateexploitation = DateTime.now().toUtc();
    _forageusage = "";
    _foragedebithorairepompe = "";
    _foragedureejournalierepompage = "";
    _foragevolumemensuelpreleve = "";
    _foragenombrejourpompage = "";
    _forageniveaustatiqueforage = "";
    _foragepotentielhydraulique = "";
    _foragetemperature = "";
    _forageconductiviteelectrique = "";
  }

  void resetpompemanuelledata() {
    _drainage = false;
    _modelepompe = "";
  }

  void resetsourcedata() {
    _sourcenote = "";
    _amenage = false;
  }

  void resetautrepointeaudata() {
    _autretypepointeau = "";
  }

  String get pays => _pays;
  String get nompointeau => _nompointeau;
  String get typepointeau => _typepointeau;
  String get modelepompe => _modelepompe;
  String get profondeur => _profondeur;
  bool get couverclepuit => _couverclepuit;
  String get typepuit => _typepuit;

  DateTime get puitdateexploitation => _puitdateexploitation;
  String get puitusage => _puitusage;
  String get puitdebithorairepompe => _puitdebithorairepompe;
  String get puitdureejournalierepompage => _puitdureejournalierepompage;
  String get puitvolumemensuelpreleve => _puitvolumemensuelpreleve;
  String get puitnombrejourpompage => _puitnombrejourpompage;
  String get puitniveaustatiquepuit => _puitniveaustatiquepuit;
  String get puitpotentielhydraulique => _puitpotentielhydraulique;
  String get puittemperature => _puittemperature;
  String get puitconductiviteelectrique => _puitconductiviteelectrique;

  bool get forageteteprotege => _forageteteprotege;
  String get foragesourcealimentation => _foragesourcealimentation;
  bool get foragecloture => _foragecloture;
  DateTime get foragedateexploitation => _foragedateexploitation;
  String get forageusage => _forageusage;
  String get foragedebithorairepompe => _foragedebithorairepompe;
  String get foragedureejournalierepompage => _foragedureejournalierepompage;
  String get foragevolumemensuelpreleve => _foragevolumemensuelpreleve;
  String get foragenombrejourpompage => _foragenombrejourpompage;
  String get forageniveaustatiqueforage => _forageniveaustatiqueforage;
  String get foragepotentielhydraulique => _foragepotentielhydraulique;
  String get foragetemperature => _foragetemperature;
  String get forageconductiviteelectrique => _forageconductiviteelectrique;

  String get sourcenote => _sourcenote;
  bool get sourceamenage => _sourceamenage;
  String get autretypepointeau => _autretypepointeau;
  String get latitude => _latitude;
  String get longitude => _longitude;
  bool get bonetatgeneral => _bonetatgeneral;
  bool get cloture => _cloture;
  bool get drainage => _drainage;
  bool get amenage => _amenage;
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

// setters

  set pays(String value) {
    _pays = value;
    notifyListeners();
  }

  set nompointeau(String value) {
    _nompointeau = value;
    notifyListeners();
  }

  set typepointeau(String value) {
    _typepointeau = value;
    notifyListeners();
  }

  set modelepompe(String value) {
    _modelepompe = value;
    notifyListeners();
  }

  set profondeur(String value) {
    _profondeur = value;
    notifyListeners();
  }

  set couverclepuit(bool value) {
    _couverclepuit = value;
    notifyListeners();
  }

  set typepuit(String value) {
    _typepuit = value;
    notifyListeners();
  }

  set puitdateexploitation(DateTime value) {
    _puitdateexploitation = value;
    notifyListeners();
  }

  set puitusage(String value) {
    _puitusage = value;
    notifyListeners();
  }

  set puitdebithorairepompe(String value) {
    _puitdebithorairepompe = value;
    notifyListeners();
  }

  set puitdureejournalierepompage(String value) {
    _puitdureejournalierepompage = value;
    notifyListeners();
  }

  set puitvolumemensuelpreleve(String value) {
    _puitvolumemensuelpreleve = value;
    notifyListeners();
  }

  set puitnombrejourpompage(String value) {
    _puitnombrejourpompage = value;
    notifyListeners();
  }

  set puitniveaustatiquepuit(String value) {
    _puitniveaustatiquepuit = value;
    notifyListeners();
  }

  set puitpotentielhydraulique(String value) {
    _puitpotentielhydraulique = value;
    notifyListeners();
  }

  set puittemperature(String value) {
    _puittemperature = value;
    notifyListeners();
  }

  set puitconductiviteelectrique(String value) {
    _puitconductiviteelectrique = value;
    notifyListeners();
  }

  set forageteteprotege(bool value) {
    _forageteteprotege = value;
    notifyListeners();
  }

  set foragesourcealimentation(String value) {
    _foragesourcealimentation = value;
    notifyListeners();
  }

  set foragecloture(bool value) {
    _foragecloture = value;
    notifyListeners();
  }

  set foragedateexploitation(DateTime value) {
    _foragedateexploitation = value;
    notifyListeners();
  }

  set forageusage(String value) {
    _forageusage = value;
    notifyListeners();
  }

  set foragedebithorairepompe(String value) {
    _foragedebithorairepompe = value;
    notifyListeners();
  }

  set foragedureejournalierepompage(String value) {
    _foragedureejournalierepompage = value;
    notifyListeners();
  }

  set foragevolumemensuelpreleve(String value) {
    _foragevolumemensuelpreleve = value;
    notifyListeners();
  }

  set foragenombrejourpompage(String value) {
    _foragenombrejourpompage = value;
    notifyListeners();
  }

  set forageniveaustatiqueforage(String value) {
    _forageniveaustatiqueforage = value;
    notifyListeners();
  }

  set foragepotentielhydraulique(String value) {
    _foragepotentielhydraulique = value;
    notifyListeners();
  }

  set foragetemperature(String value) {
    _foragetemperature = value;
    notifyListeners();
  }

  set forageconductiviteelectrique(String value) {
    _forageconductiviteelectrique = value;
    notifyListeners();
  }

  set sourcenote(String value) {
    _sourcenote = value;
    notifyListeners();
  }

  set sourceamenage(bool value) {
    _sourceamenage = value;
    notifyListeners();
  }

  set autretypepointeau(String value) {
    _autretypepointeau = value;
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

  set bonetatgeneral(bool value) {
    _bonetatgeneral = value;
    notifyListeners();
  }

  set cloture(bool value) {
    _cloture = value;
    notifyListeners();
  }

  set drainage(bool value) {
    _drainage = value;
    notifyListeners();
  }

  set amenage(bool value) {
    _amenage = value;
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

  WaterData(
      {nompointeau,
      typepointeau,
      modelepompe,
      profondeur,
      couverclepuit,
      typepuit,
      puitdateexploitation,
      puitusage,
      puitdebithorairepompe,
      puitdureejournalierepompage,
      puitvolumemensuelpreleve,
      puitnombrejourpompage,
      puitniveaustatiquepuit,
      puitpotentielhydraulique,
      puittemperature,
      puitconductiviteelectrique,
      forageteteprotege,
      foragesourcealimentation,
      foragecloture,
      foragedateexploitation,
      forageusage,
      foragedebithorairepompe,
      foragedureejournalierepompage,
      foragevolumemensuelpreleve,
      foragenombrejourpompage,
      forageniveaustatiqueforage,
      foragepotentielhydraulique,
      foragetemperature,
      forageconductiviteelectrique,
      sourcenote,
      sourceamenage,
      autretypepointeau,
      latitude,
      longitude,
      bonetatgeneral,
      cloture,
      drainage,
      amenage,
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

  fromJson(Map<String, dynamic> json) {
    pays = json['pays'];
    nompointeau = json['nompointeau'];
    typepointeau = json['typepointeau'];
    modelepompe = json['modelepompe'];
    profondeur = json['profondeur'];
    couverclepuit = json['couverclepuit'] ?? false;
    typepuit = json['typepuit'];
    forageteteprotege = json['forageteteprotege'];
    foragesourcealimentation = json['foragesourcealimentation'];
    foragecloture = json['foragecloture'];
    sourcenote = json['sourcenote'];
    sourceamenage = json['sourceamenage'];
    autretypepointeau = json['autretypepointeau'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bonetatgeneral = json['bonetatgeneral'];

    foragedateexploitation = json['foragedateexploitation'];
    forageusage = json['forageusage'];
    foragedebithorairepompe = json['foragedebithorairepompe'];
    foragedureejournalierepompage = json['foragedureejournalierepompage'];
    foragevolumemensuelpreleve = json['foragevolumemensuelpreleve'];
    foragenombrejourpompage = json['foragenombrejourpompage'];
    forageniveaustatiqueforage = json['forageniveaustatiqueforage'];
    foragepotentielhydraulique = json['foragepotentielhydraulique'];
    foragetemperature = json['foragetemperature'];
    forageconductiviteelectrique = json['forageconductiviteelectrique'];
    puitdateexploitation = json['puitdateexploitation'];
    puitusage = json['puitusage'];
    puitdebithorairepompe = json['puitdebithorairepompe'];
    puitdureejournalierepompage = json['puitdureejournalierepompage'];
    puitvolumemensuelpreleve = json['puitvolumemensuelpreleve'];
    puitnombrejourpompage = json['puitnombrejourpompage'];
    puitniveaustatiquepuit = json['puitniveaustatiquepuit'];
    puitpotentielhydraulique = json['puitpotentielhydraulique'];
    puittemperature = json['puittemperature'];
    puitconductiviteelectrique = json['puitconductiviteelectrique'];

    cloture = json['cloture'];
    drainage = json['drainage'];
    amenage = json['amenage'];
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

  factory WaterData.fromFireStore(DocumentSnapshot doc) {
    Map json = doc.data;
    WaterData water = WaterData();
    water.pays = json['pays'];
    water.nompointeau = json['nompointeau'];
    water.typepointeau = json['typepointeau'];
    water.modelepompe = json['modelepompe'];
    water.profondeur = json['profondeur'];
    water.couverclepuit = json['couverclepuit'];
    water.typepuit = json['typepuit'];
    water.forageteteprotege = json['forageteteprotege'] ?? false;
    water.foragesourcealimentation = json['foragesourcealimentation'];
    water.foragecloture = json['foragecloture'];
    water.sourcenote = json['sourcenote'];
    water.sourceamenage = json['sourceamenage'];
    water.autretypepointeau = json['autretypepointeau'];
    water.latitude = json['latitude'];
    water.longitude = json['longitude'];
    water.bonetatgeneral = json['bonetatgeneral'];
    water.foragedateexploitation =
        convertStamp(json['foragedateexploitation']) ?? DateTime.now();
    water.forageusage = json['forageusage'];
    water.foragedebithorairepompe = json['foragedebithorairepompe'];
    water.foragedureejournalierepompage = json['foragedureejournalierepompage'];
    water.foragevolumemensuelpreleve = json['foragevolumemensuelpreleve'];
    water.foragenombrejourpompage = json['foragenombrejourpompage'];
    water.forageniveaustatiqueforage = json['forageniveaustatiqueforage'];
    water.foragepotentielhydraulique = json['foragepotentielhydraulique'];
    water.foragetemperature = json['foragetemperature'];
    water.forageconductiviteelectrique = json['forageconductiviteelectrique'];
    water.puitdateexploitation =
        convertStamp(json['puitdateexploitation']) ?? DateTime.now();
    water.puitusage = json['puitusage'];
    water.puitdebithorairepompe = json['puitdebithorairepompe'];
    water.puitdureejournalierepompage = json['puitdureejournalierepompage'];
    water.puitvolumemensuelpreleve = json['puitvolumemensuelpreleve'];
    water.puitnombrejourpompage = json['puitnombrejourpompage'];
    water.puitniveaustatiquepuit = json['puitniveaustatiquepuit'];
    water.puitpotentielhydraulique = json['puitpotentielhydraulique'];
    water.puittemperature = json['puittemperature'];
    water.puitconductiviteelectrique = json['puitconductiviteelectrique'];
    water.cloture = json['cloture'];
    water.drainage = json['drainage'];
    water.amenage = json['amenage'];
    water.date = convertStamp(json['date']) ?? DateTime.now();
    water.note = json['note'];
    water.partenaire = json['partenaire'];
    water.collecteur = json['collecteur'];
    water.typecollecte = json['typecollecte'];
    water.region = json['region'];
    water.departement = json['departement'];
    water.arrondissement = json['arrondissement'];
    water.commune = json['commune'];
    water.village = json['village'];

    return water;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pays'] = pays;
    data['nompointeau'] = nompointeau;
    data['typepointeau'] = typepointeau;
    data['modelepompe'] = modelepompe;
    data['profondeur'] = profondeur;
    data['couverclepuit'] = couverclepuit;
    data['typepuit'] = typepuit;
    data['forageteteprotege'] = forageteteprotege;
    data['foragesourcealimentation'] = foragesourcealimentation;
    data['foragecloture'] = foragecloture;
    data['foragedateexploitation'] = foragedateexploitation;
    data['forageusage'] = forageusage;
    data['foragedebithorairepompe'] = foragedebithorairepompe;
    data['foragedureejournalierepompage'] = foragedureejournalierepompage;
    data['foragevolumemensuelpreleve'] = foragevolumemensuelpreleve;
    data['foragenombrejourpompage'] = foragenombrejourpompage;
    data['forageniveaustatiqueforage'] = forageniveaustatiqueforage;
    data['foragepotentielhydraulique'] = foragepotentielhydraulique;
    data['foragetemperature'] = foragetemperature;
    data['forageconductiviteelectrique'] = forageconductiviteelectrique;
    data['puitdateexploitation'] = puitdateexploitation;
    data['puitusage'] = puitusage;
    data['puitdebithorairepompe'] = puitdebithorairepompe;
    data['puitdureejournalierepompage'] = puitdureejournalierepompage;
    data['puitvolumemensuelpreleve'] = puitvolumemensuelpreleve;
    data['puitnombrejourpompage'] = puitnombrejourpompage;
    data['puitniveaustatiquepuit'] = puitniveaustatiquepuit;
    data['puitpotentielhydraulique'] = puitpotentielhydraulique;
    data['puittemperature'] = puittemperature;
    data['puitconductiviteelectrique'] = puitconductiviteelectrique;

    data['sourcenote'] = sourcenote;
    data['sourceamenage'] = sourceamenage;
    data['autretypepointeau'] = autretypepointeau;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['bonetatgeneral'] = bonetatgeneral;
    data['cloture'] = cloture;
    data['drainage'] = drainage;
    data['amenage'] = amenage;
    data['date'] = date;
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
}
