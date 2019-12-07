import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/ui/villagequest/details/detail_batpriv.dart';
import 'package:acra/ui/villagequest/details/detail_batpub.dart';
import 'package:acra/ui/villagequest/details/detail_latrine.dart';
import 'package:acra/ui/villagequest/details/detail_water.dart';
import 'package:acra/ui/villagequest/details/detail_danger.dart';

class Lang {
  static const String fr = "fr";
  static const String en = "en";
}

showDoneDialog(BuildContext context, String title, String content, Color color,
    Function whattodo) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            color: color,
            child: new Text(
              "Ok!",
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (whattodo != null) whattodo();
            },
          ),
        ],
      );
    },
  );
}

DateTime convertStamp(Timestamp _stamp) {
  if (_stamp != null) {
    // return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    if (Platform.isIOS) {
      return _stamp.toDate();
    } else {
      return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
    }
  } else {
    return null;
  }
}

String setupDate(DateTime date) {
  var dateFormat = new DateFormat('dd-MMMM-yyyy');
  return dateFormat.format(date);
}

showMyCustomDialog(BuildContext context, String msg) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

class CollecteActions {
  static rightpicture(DocumentSnapshot doc) {
    switch (doc['typecollecte']) {
      case TypeCollecte.collectdanger:
        return DataDanger.imgpath;
      case TypeCollecte.collectebatimentprive:
        return DataBatimentPrive.imgpath;
      case TypeCollecte.collectebatimentpublic:
        return DataBatimentPublic.imgpath;
      case TypeCollecte.collectelatrines:
        return DataLatrines.imgpath;
      case TypeCollecte.collectepointeau:
        return DataPointEau.imgpath;
    }
  }

  static righthue(DocumentSnapshot doc) {
    switch (doc['typecollecte']) {
      case TypeCollecte.collectdanger:
        return HSLColor.fromColor(DataDanger.dangercolordark).hue;
        break;
      case TypeCollecte.collectebatimentprive:
        return HSLColor.fromColor(DataBatimentPrive.batprivcolordark).hue;
        break;
      case TypeCollecte.collectebatimentpublic:
        return HSLColor.fromColor(DataBatimentPublic.batpubcolordark).hue;
        break;
      case TypeCollecte.collectelatrines:
        return HSLColor.fromColor(DataLatrines.latrinecolordark).hue;
        break;
      case TypeCollecte.collectepointeau:
        return HSLColor.fromColor(DataPointEau.watercolordark).hue;
        break;
    }
  }

  static rightpagetogoto(DocumentSnapshot doc, BuildContext context) {
    Route goto;
    switch (doc['typecollecte']) {
      case TypeCollecte.collectdanger:
        goto = MaterialPageRoute(
            builder: (context) => DetailDanger(
                  realdanger: DangerData.fromFireStore(doc),
                )); //Enrolme
        break;
      case TypeCollecte.collectebatimentprive:
        goto = MaterialPageRoute(
            builder: (context) => DetailBatimentPrive(
                  batpriv: BatimentPriveData.fromFireStore(doc),
                )); //Enrolme
        break;
      case TypeCollecte.collectebatimentpublic:
        goto = MaterialPageRoute(
            builder: (context) => DetailBatimentPublic(
                  batpub: BatimentPublicData.fromFireStore(doc),
                )); //Enrolme

        break;
      case TypeCollecte.collectelatrines:
        goto = MaterialPageRoute(
            builder: (context) => DetailLatrine(
                  latrine: LatrineData.fromFireStore(doc),
                ));
        break;
      case TypeCollecte.collectepointeau:
        goto = MaterialPageRoute(
            builder: (context) => DetailWater(
                  water: WaterData.fromFireStore(doc),
                ));
        break;
    }

    Navigator.of(context).pushReplacement(goto);
  }

  static rightcolor(DocumentSnapshot doc) {
    switch (doc['typecollecte'] as String) {
      case TypeCollecte.collectdanger:
        return DataDanger.dangercolordark;
        break;
      case TypeCollecte.collectebatimentprive:
        return DataBatimentPrive.batprivcolordark;
        break;
      case TypeCollecte.collectebatimentpublic:
        return DataBatimentPublic.batpubcolordark;
        break;
      case TypeCollecte.collectelatrines:
        return DataLatrines.latrinecolordark;
        break;
      case TypeCollecte.collectepointeau:
        return DataPointEau.watercolordark;
        break;
    }
  }

  static righttitle(DocumentSnapshot doc) {
    switch (doc['typecollecte']) {
      case TypeCollecte.collectepointeau:
        return "${doc['typecollecte']} (${doc['typepointeau']})";
      default:
        return doc['typecollecte'];
    }
  }

  static rightsubtitle(DocumentSnapshot doc) {
    switch (doc['typecollecte']) {
      case TypeCollecte.collectdanger:
        return doc['nom'];
      case TypeCollecte.collectebatimentprive:
        return doc['nomproprio'];
      case TypeCollecte.collectebatimentpublic:
        return doc['nombatiment'];
      case TypeCollecte.collectelatrines:
        return doc['nomproprio'];
      case TypeCollecte.collectepointeau:
        return "${doc['nompointeau']}";
    }
  }
}

class SharePrefsData {
  static const String dbname = "acra";
  static const String deviceconfig = "devicesetup";

  // static Future<Setting> readDeviceSetupFromPrefs() async {
  //   Setting user;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString(SharePrefsData.deviceconfig) != null &&
  //       prefs.getString(SharePrefsData.deviceconfig).isNotEmpty) {
  //     var userdata =
  //         await json.decode(prefs.getString(SharePrefsData.deviceconfig));

  //     if (userdata != null) {
  //       user = Setting.fromJson(userdata as Map<String, dynamic>);
  //       print("DeviceSetup locally read is ${user.toJson().toString()}");
  //     }
  //   }

  //   return user;
  // }

  static Future<Setting> readDeviceSetupFromPrefs() async {
    Setting user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(SharePrefsData.deviceconfig) != null &&
        prefs.getString(SharePrefsData.deviceconfig).isNotEmpty) {
      String settingdata = prefs.get(SharePrefsData.deviceconfig);

      if (settingdata != null) {
        var settingsplit = settingdata.split("-");
        user = Setting(
            deviceId: settingsplit[0],
            partnerId: settingsplit[1],
            collectorId: settingsplit[2]);
        print("DeviceSetup locally read is ${user.toSettingString()}");
      }
    }

    return user;
  }

  static saveDeviceSetupToPrefs(Setting user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString(
    //     SharePrefsData.deviceconfig, json.encode(user.toJson().toString()));

    await prefs.setString(SharePrefsData.deviceconfig, user.toSettingString());

    print("DeviceSetup locally saved");
  }

  removeDeviceSetup() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharePrefsData.deviceconfig);
  }
}

class UIData {
  static const latrinecolorlight = Color(0xFFDFD9D8); //0xFF=#
  static const latrinecolordark = Color(0xFFAFA5A1); //0xFF=#
  static const dangercolorlight = Color(0xFFF9C29D);
  static const dangercolordark = Color(0xFFEA5A0B);
  static const batpubcolorlight = Color(0xFFD0E3EE);
  static const batpubcolordark = Color(0xFF8ABAD3);
  static const batprivcolorlight = Color(0xFFDBE3AC);
  static const batprivcolordark = Color(0xFFA2BB0C);
  static const watercolorlight = Color(0xFFD7DBF0);
  static const watercolordark = Color(0xFF133D69);

  static const acraorangecolor = Color(0xFFF26513);
  static const acragraycolor = Color(0xFFF2F2F2);

  static const String dialogCollecteOverTitle = "Collecte Enregistree";
  static const String dialogCollecteOverContent =
      "Collecte enregistre cliquer le bouton \n ci dessus pour collecter a nouveau";
}

class TypeCollecte {
  static const String postcollecte = "collecte";
  static const String queryfield = "typecollecte";
  static const String collectdanger = "danger";
  static const String collectebatimentpublic = "batimentpublic";
  static const String collectebatimentprive = "batimentprive";
  static const String collectelatrines = "latrine";
  static const String collectepointeau = "pointeau";
}

class DataPointEau {
  static const int refid = 5;
  static const String nom = "Point d'eau";
  static const String imgpath = "assets/water.png";
  static const watercolorlight = Color(0xFFD7DBF0);
  static const watercolordark = Color(0xFF133D69);
  static const typeusageeau = [
    {"display": "Consommation"},
    {"display": "Agriculture"},
    {"display": "Elevage"},
    {"display": "Autres"}
  ];

  static const typeusageeau_en = [
    {"display": "Consumption"},
    {"display": "Agriculture"},
    {"display": "Breeding"},
    {"display": "Others"}
  ];
  static const typeusageeaustring = [
    "Consommation",
    "Agriculture",
    "Elevage",
    "Autres",
  ];

  static const typeusageeaustring_en = [
    "Consumption",
    "Agriculture",
    "Breeding",
    "Others",
  ];

  static const typespointeau = [
    {"display": "Pompe manuelle"},
    {"display": "Puits"},
    {"display": "Forage"},
    {"display": "Source"},
    {"display": "Autre type de point d'eau"}
  ];

  static const typespointeau_en = [
    {"display": "Manual pump"},
    {"display": "Well"},
    {"display": "Borehole"},
    {"display": "Source"},
    {"display": "Other type of water point"}
  ];

  static const marquepompes = [
    {"display": "AFRIDEV"},
    {"display": "BUSH"},
    {"display": "INDIAN MARK ||"},
    {"display": "INDIAN MARK |||"},
    {"display": "JIBON"},
    {"display": "MALDA"},
    {"display": "NIRA AF85"},
    {"display": "ROPE"},
    {"display": "TARA"},
    {"display": "U3M"},
    {"display": "VERGNET"},
    {"display": "VOLANTA"},
    {"display": "Autre"},
  ];

  static const marquepompes_en = [
    {"display": "AFRIDEV"},
    {"display": "BUSH"},
    {"display": "INDIAN MARK ||"},
    {"display": "INDIAN MARK |||"},
    {"display": "JIBON"},
    {"display": "MALDA"},
    {"display": "NIRA AF85"},
    {"display": "ROPE"},
    {"display": "TARA"},
    {"display": "U3M"},
    {"display": "VERGNET"},
    {"display": "VOLANTA"},
    {"display": "Other"},
  ];

  static const sourcealimentation = [
    {"display": "Générateur"},
    {"display": "Réseau Electrique"},
    {"display": "Solaire"},
    {"display": "Eolienne"},
    {"display": "Autre"}
  ];

  static const sourcealimentation_en = [
    {"display": "Generator"},
    {"display": "Electrical Network"},
    {"display": "Solar"},
    {"display": "Wind turbine"},
    {"display": "Other"}
  ];

  static const typepuit = [
    {"display": "Traditionel"},
    {"display": "Moderne"}
  ];

  static const typepuit_en = [
    {"display": "Traditional"},
    {"display": "Modern"}
  ];
}

class DataLatrines {
  static const int refid = 4;
  static const String nom = "Latrines";
  static const String imgpath = "assets/toilet.png";

  static const latrinecolorlight = Color(0xFFDFD9D8); //0xFF=#
  static const latrinecolordark = Color(0xFFAFA5A1); //0xFF=#

  static const typeusageeau = [
    {"display": "Domestique"},
    {"display": "Agriculture"},
    {"display": "Elevage"},
    {"display": "Industrie(s)"},
    {"display": "Mine(s)"},
    {"display": "Autres"},
  ];

  static const typeusageeau_en = [
    {"display": "Domestic"},
    {"display": "Agriculture"},
    {"display": "Breeding"},
    {"display": "Industry(ies)"},
    {"display": "Mine(s)"},
    {"display": "Others"},
  ];

  static const typeslatrines = [
    {"display": "Traditionnelle"},
    {"display": "SanPlat"},
    {"display": "VIP"},
    {"display": "LV"},
    {"display": "TCM"},
    {"display": "LFTE"},
    {"display": "ECOSAN"},
    {"display": "Fosse sceptique"},
    {"display": "Autre"}
  ];

  static const typeslatrines_en = [
    {"display": "Traditional"},
    {"display": "SanPlat"},
    {"display": "VIP"},
    {"display": "LV"},
    {"display": "TCM"},
    {"display": "LFTE"},
    {"display": "ECOSAN"},
    {"display": "Sceptic tank"},
    {"display": "Other"}
  ];

  static const superstructure = [
    {"display": "Branchage"},
    {"display": "Bache"},
    {"display": "Bambou"},
    {"display": "Paille"},
    {"display": "Brique"},
    {"display": "Crépit"},
    {"display": "Pagne"},
    {"display": "Planche de bois"},
    {"display": "Plastique"},
    {"display": "Terre battue"},
    {"display": "Tole"},
    {"display": "Autre"},
    {"display": "Aucune"}
  ];

  static const superstructure_en = [
    {"display": "Branchage"},
    {"display": "Tarpaulin"},
    {"display": "Bamboo"},
    {"display": "Chaff"},
    {"display": "Brick"},
    {"display": "Crackling"},
    {"display": "Pagne"},
    {"display": "Wooden board"},
    {"display": "Plastic"},
    {"display": "Battered clay"},
    {"display": "Metal sheet"},
    {"display": "Other"},
    {"display": "None of them"}
  ];

  static const dalles = [
    {"display": "Ciment"},
    {"display": "Céramique"},
    {"display": "Carrelage"},
    {"display": "Terre Battue"},
    {"display": "Planche de bois"},
    {"display": "Plastique"},
    {"display": "Autre"}
  ];

  static const dalles_en = [
    {"display": "Cement"},
    {"display": "Ceramic"},
    {"display": "Tiling"},
    {"display": "Battered Earth"},
    {"display": "Wooden board"},
    {"display": "Plastic"},
    {"display": "Other"}
  ];
}

class DataBatimentPublic {
  static const int refid = 2;
  static const String nom = "Habitations publiques";
  static const String imgpath = "assets/homehouse.png";
  static const batpubcolorlight = Color(0xFFD0E3EE);
  static const batpubcolordark = Color(0xFF8ABAD3);

  static const typebatiments = [
    {"display": "Ecole"},
    {"display": "Structure sanitaire"},
    {"display": "Structure réligieuse"},
    {"display": "Divers"},
  ];
  static const typebatiments_en = [
    {"display": "School"},
    {"display": "Health structure"},
    {"display": "Religious structure"},
    {"display": "Various"},
  ];

  static const batreligieux = [
    {"display": "Eglise"},
    {"display": "Mosquée"},
    {"display": "Autre"}
  ];
  static const batreligieux_en = [
    {"display": "Church"},
    {"display": "Mosque"},
    {"display": "Other"}
  ];

  static const batecoles = [
    {"display": "Primaire maternelle"},
    {"display": "Primaire élémentaire"},
    {"display": "Secondaire"},
    {"display": "Professionnelle"},
    {"display": "Apprentissage"},
    {"display": "Supérieure"},
    {"display": "Autre"}
  ];
  static const batecoles_en = [
    {"display": "Primary Maternity"},
    {"display": "Elementary Primary"},
    {"display": "Secondary school"},
    {"display": "Professional"},
    {"display": "Apprenticeship"},
    {"display": "Superior"},
    {"display": "Other"}
  ];

  static const batsante = [
    {"display": "Centre de Santé"},
    {"display": "Maternité"},
    {"display": "Hopital"},
    {"display": "Autre"}
  ];
  static const batsante_en = [
    {"display": "Health Center"},
    {"display": "Maternity"},
    {"display": "Hospital"},
    {"display": "Other"}
  ];
}

class DataBatimentPrive {
  static const int refid = 3;
  static const String nom = "Habitations privées";
  static const String imgpath = "assets/building.png";
  static const batprivcolorlight = Color(0xFFDBE3AC);
  static const batprivcolordark = Color(0xFFA2BB0C);
}

class DataBatiment {
  static const int refid = 1;
  static const String nom = "Habitations";
  static const String imgpath = "assets/building.png";
  // static const typebatiments=["Ecole","Structure sanitaire","Structure religieuse","Divers"];
  // static const batreligieux=["Eglise","Mosquee","Autre"];
  // static const batecoles=["Primaire maternelle","Primaire elementaire","Secondaire","Professionnelle","Apprentissage","Superieure","Autre"];
  // static const batsante=["Centre de Sante","Maternite","Hopital","Autre"];

}

class DataDanger {
  static const int refid = 0;
  static const String nom = "Dangers(WSP)";
  static const String imgpath = "assets/danger.png";
  static const dangercolorlight = Color(0xFFF9C29D);
  static const dangercolordark = Color(0xFFEA5A0B);

  static const typedangers = [
    {"display": "Traversée de route"},
    {"display": "Traversée de fleuve"},
    {"display": "Début de zone agricole"},
    {"display": "Fin de zone agricole"},
    {"display": "Début de zone industrielle"},
    {"display": "Fin de zone industrielle"},
    {"display": "Début de Zone inondable"},
    {"display": "Fin de zone inondable"},
    {"display": "Cimétière"},
    {"display": "Abattoir"},
    {"display": "Bassin de lagunage"},
    {"display": "Site de compostage"},
    {"display": "Décharge"},
    {"display": "Autre"}
  ];

  static const typedangers_en = [
    {"display": "Road crossing"},
    {"display": "River crossing"},
    {"display": "Beginning of agricultural zone"},
    {"display": "End of agricultural zone"},
    {"display": "Start of industrial zone"},
    {"display": "End of industrial zone"},
    {"display": "Beginning of Floodplain Area"},
    {"display": "End of flood zone"},
    {"display": "Cemetery"},
    {"display": "Slaughterhouse"},
    {"display": "Lagoon basin"},
    {"display": "Composting site"},
    {"display": "Discharge"},
    {"display": "Other"}
  ];
}

class FireStorePaths {
  static const String pathtocollect = "";
}
