import 'package:acra/models/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/models/village.dart';
import 'package:acra/models/collecteur.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class ObjectCount {
  int nbrbatiments = 0;
  int nbrwaters = 0;
  int nbrdangers = 0;
  int nbrlatrines = 0;

  ObjectCount(
      this.nbrbatiments, this.nbrwaters, this.nbrdangers, this.nbrlatrines);
}

class DataBaseService {
  static final Firestore db = Firestore.instance;
  static final String collectionpartners = "partenaires";
  static final String collectioncollecteurs = "collecteur";

  static Future<DocumentSnapshot> loginFuture(
      String email, String password) async {
    var user = await db.collection(collectionpartners).document(email).get();
    // .where("mdp", isEqualTo: password)
    // .getDocuments();

    if (user.data['mdp'] == password)
      return user;
    else
      return null;
  }

  // static Stream<List<Marker>> getallCollecte() {
  //   var snap = db
  //       .collection(TypeCollecte.postcollecte)
  //       .limit(20)
  //       // .where(TypeCollecte.queryfield, isEqualTo: TypeCollecte.collectdanger)
  //       .snapshots();
  //   //     .map((collecte) {
  //   //   LatLng pos = LatLng(double.parse(collecte['latitude']),
  //   //       double.parse(collecte['longitude']));
  //   //   Marker m = Marker();
  //   // }).toList();

  //   List<Marker> markers = [];

  //   snap.forEach((data) {
  //     LatLng pos = LatLng(
  //         double.parse(data['latitude']), double.parse(data['longitude']));
  //     Marker m = Marker();
  //   });

  //   // for (DocumentSnapshot data in snap.) {
  //   //   dangers.add(DangerData.fromJson(dangerdoc.data));
  //   // }

  //   return markers;
  // }

  static streamgetmyallCollecte(Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .snapshots();
  }

  // // Future
  static Future<QuerySnapshot> getallCollecte(Setting setup) {
    var data = db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .getDocuments();
    return data;
  }

  static Future<QuerySnapshot> getallCollecteByPartner(String partnerId) {
    var data = db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: partnerId)
        .getDocuments();
    return data;
  }

  static Future<Collecteur> getCollecteur(Setting setup) async {
    print(
        "Setup Test Infos deviceNumber => ${setup.deviceId} collecteur=> ${setup.collectorId} partner => ${setup.partnerId}");
    var docs = await db
        .collection(collectioncollecteurs)
        .where("partenaire", isEqualTo: setup.partnerId.toString())
        .where("email", isEqualTo: setup.collectorId.toString())
        .where("deviceNumber", isEqualTo: int.parse(setup.deviceId))
        .getDocuments();
    if (docs.documents.length != 0) {
      // .elementAt(0)
      print("Setup Test Infos we got data ${docs.documents[0].data}");
      return Collecteur.fromJson(docs.documents[0].data);
    } else {
      print("Setup Test Infos No data Acquired");
      return null;
    }
  }

  // Future
  static Stream<List<DangerData>> getDangers(Village village, Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .where("region", isEqualTo: village.region)
        .where("departement", isEqualTo: village.departement)
        .where("arrondissement", isEqualTo: village.arrondissement)
        .where("commune", isEqualTo: village.commune)
        .where("village", isEqualTo: village.nom)
        .where(TypeCollecte.queryfield, isEqualTo: TypeCollecte.collectdanger)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => DangerData.fromFireStore(doc))
            .toList());
  }

  static Future<DangerData> getDanger(String id) async {
    var snap =
        await db.collection(TypeCollecte.postcollecte).document(id).get();
    return DangerData.fromFireStore(snap);
  }

  static Stream<List<LatrineData>> getLatrines(Village village, Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .where("region", isEqualTo: village.region)
        .where("departement", isEqualTo: village.departement)
        .where("arrondissement", isEqualTo: village.arrondissement)
        .where("commune", isEqualTo: village.commune)
        .where("village", isEqualTo: village.nom)
        .where(TypeCollecte.queryfield,
            isEqualTo: TypeCollecte.collectelatrines)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => LatrineData.fromFireStore(doc))
            .toList());
  }

  static Future<LatrineData> getLatrine(String id) async {
    var snap =
        await db.collection(TypeCollecte.postcollecte).document(id).get();
    return LatrineData.fromFireStore(snap);
  }

  static Stream<List<BatimentPublicData>> getBatimentpublics(
      Village village, Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .where("region", isEqualTo: village.region)
        .where("departement", isEqualTo: village.departement)
        .where("arrondissement", isEqualTo: village.arrondissement)
        .where("commune", isEqualTo: village.commune)
        .where("village", isEqualTo: village.nom)
        .where(TypeCollecte.queryfield,
            isEqualTo: TypeCollecte.collectebatimentpublic)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => BatimentPublicData.fromFireStore(doc))
            .toList());
  }

  static Future<BatimentPublicData> getBatimentpublic(String id) async {
    var snap =
        await db.collection(TypeCollecte.postcollecte).document(id).get();
    return BatimentPublicData.fromFireStore(snap);
  }

  static Stream<List<BatimentPriveData>> getBatimentprives(
      Village village, Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .where("region", isEqualTo: village.region)
        .where("departement", isEqualTo: village.departement)
        .where("arrondissement", isEqualTo: village.arrondissement)
        .where("commune", isEqualTo: village.commune)
        .where("village", isEqualTo: village.nom)
        .where(TypeCollecte.queryfield,
            isEqualTo: TypeCollecte.collectebatimentprive)
        .snapshots()
        .map((list) => list.documents
            .map((doc) => BatimentPriveData.fromFireStore(doc))
            .toList());
  }

  static Future<BatimentPriveData> getBatimentprive(String id) async {
    var snap =
        await db.collection(TypeCollecte.postcollecte).document(id).get();
    return BatimentPriveData.fromFireStore(snap);
  }

  static Stream<List<WaterData>> getWaterPlaces(
      Village village, Setting setup) {
    return db
        .collection(TypeCollecte.postcollecte)
        .where("partenaire", isEqualTo: setup.partnerId)
        .where("collecteur", isEqualTo: setup.collectorId)
        .where("region", isEqualTo: village.region)
        .where("departement", isEqualTo: village.departement)
        .where("arrondissement", isEqualTo: village.arrondissement)
        .where("commune", isEqualTo: village.commune)
        .where("village", isEqualTo: village.nom)
        .where(TypeCollecte.queryfield,
            isEqualTo: TypeCollecte.collectepointeau)
        .snapshots()
        .map((list) =>
            list.documents.map((doc) => WaterData.fromFireStore(doc)).toList());
  }

  static Future<WaterData> getWaterPlace(String id) async {
    var snap =
        await db.collection(TypeCollecte.postcollecte).document(id).get();
    return WaterData.fromFireStore(snap);
  }

  static void addLatrine(LatrineData latrine) {
    db
        .collection(TypeCollecte.postcollecte)
        .add(latrine.toJson())
        .catchError((error) {
      print("latrine post error $error");
    });
  }

  static void addPointeau(WaterData water) {
    db
        .collection(TypeCollecte.postcollecte)
        .add(water.toJson())
        .catchError((error) {
      print("pointeau post error $error");
    });
  }

  static void addBatimenpublic(BatimentPublicData batimentpublic) {
    //  Firestore.instance.enablePersistence(true);
    db
        .collection(TypeCollecte.postcollecte)
        .add(batimentpublic.toJson())
        .then((value) {
      print("we got value");
    }).catchError((error) {
      print("batimentpublic post error $error");
    });
  }

  static void addBatimentPrive(BatimentPriveData batimentprive) {
    db
        .collection(TypeCollecte.postcollecte)
        .add(batimentprive.toJson())
        .catchError((error) {
      print("batimentprive post error $error");
    });
  }

  static void addDanger(DangerData danger) {
    db
        .collection(TypeCollecte.postcollecte)
        .add(danger.toJson())
        .catchError((error) {
      print("danger post error $error");
    });
  }
}
