import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:acra/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:acra/models/village.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/villagequest/batimentscreen.dart';
import 'package:acra/ui/villagequest/dangerscreen.dart';
import 'package:acra/ui/villagequest/latrinescreen.dart';
import 'package:acra/ui/villagequest/watercollectscreen.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/app_localization.dart';

class DetailVillage extends StatefulWidget {
  final Village village;
  final Setting setup;
  DetailVillage({this.village, this.setup});
  @override
  _DetailVillageState createState() => _DetailVillageState();
}

class _DetailVillageState extends State<DetailVillage> {
  List<DetailVillageItemData> villagedetailui = List();
  Stream<List<WaterData>> waterstream;
  Stream<List<BatimentPriveData>> batprivstream;
  Stream<List<BatimentPublicData>> batpubstream;
  Stream<List<LatrineData>> latrinesstream;
  Stream<List<DangerData>> dangerstream;

  bool isLoading = false;

  var nomlatrine = "";
  var nombatiment = "";
  var nompointeau = "";
  var nomdanger = "";

  var nbrwater = 0;
  var nbrbatpriv = 0;
  var nbrbatpub = 0;
  var nbrlatrine = 0;
  var nbrdanger = 0;

  void initStreams() {
    waterstream = DataBaseService.getWaterPlaces(widget.village, widget.setup);
    batprivstream =
        DataBaseService.getBatimentprives(widget.village, widget.setup);
    batpubstream =
        DataBaseService.getBatimentpublics(widget.village, widget.setup);
    latrinesstream = DataBaseService.getLatrines(widget.village, widget.setup);
    dangerstream = DataBaseService.getDangers(widget.village, widget.setup);

    waterstream.forEach((waters) {
      nbrwater = waters.length;
    });

    batprivstream.forEach((batprivs) {
      nbrbatpriv = batprivs.length;
    });

    batpubstream.forEach((batpubs) {
      nbrbatpub = batpubs.length;
    });

    latrinesstream.forEach((latrines) {
      nbrlatrine = latrines.length;
    });

    dangerstream.forEach((dangers) {
      nbrdanger = dangers.length;
    });
  }

  @override
  void initState() {
    print("Init Page Villages");
    initStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nomlatrine = AppLocalizations.of(context)
        .translate('detail_village_screen_nomlatrine');
    nomdanger = AppLocalizations.of(context)
        .translate('detail_village_screen_nomdanger');
    nombatiment = AppLocalizations.of(context)
        .translate('detail_village_screen_nombatiments');
    nompointeau = AppLocalizations.of(context)
        .translate('detail_village_screen_nompointeau');

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate('detail_village_screen_appbartitle')),
      ),
      // body: Container(
      //   child: Center(
      //     child: Text(
      //         "danger $nbrdanger latrines $nbrlatrine batpriv $nbrbatpriv batpub $nbrbatpub water $nbrwater"),
      //   ),
      // ),
      body: StreamBuilder<List<WaterData>>(
        stream: waterstream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) print("no data water found");
          nbrwater = (snapshot.hasData) ? snapshot.data.length : 0;
          print("Builder Page Villages nbrwater $nbrwater");
          return StreamBuilder<List<BatimentPriveData>>(
            stream: batprivstream,
            builder: (context, snapshot) {
              nbrbatpriv = (snapshot.hasData) ? snapshot.data.length : 0;
              print("Builder Page Villages nbrbatpriv $nbrbatpriv");
              return StreamBuilder<List<BatimentPublicData>>(
                stream: batpubstream,
                builder: (context, snapshot) {
                  nbrbatpub = (snapshot.hasData) ? snapshot.data.length : 0;
                  print("Builder Page Villages nbrbatpub $nbrbatpub");
                  return StreamBuilder<List<LatrineData>>(
                    stream: latrinesstream,
                    builder: (context, snapshot) {
                      nbrlatrine =
                          (snapshot.hasData) ? snapshot.data.length : 0;
                      print("Builder Page Villages nbrlatrine $nbrlatrine");
                      return StreamBuilder<List<DangerData>>(
                        stream: dangerstream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) print("no data danger found");
                          nbrdanger =
                              (snapshot.hasData) ? snapshot.data.length : 0;
                          print("Builder Page Villages nbrdanger $nbrdanger");
                          ObjectCount obj = ObjectCount(
                              (nbrbatpriv + nbrbatpub),
                              nbrwater,
                              nbrdanger,
                              nbrlatrine);

                          return makeBody(
                              villagedetailui,
                              widget.village,
                              widget.setup,
                              obj,
                              nombatiment,
                              nomdanger,
                              nomlatrine,
                              nompointeau);
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

//TODO problem solved ti be checked  ..
void selectrightaction(DetailVillageItemData detailvillagedata,
    Village selectedvillage, Setting setus, BuildContext context) {
  print("selected village is ${selectedvillage.region}");

  if (detailvillagedata.refid == DataBatiment.refid) {
    Route gotoaction = MaterialPageRoute(
        builder: (context) => BatimentScreen(
              village: selectedvillage,
              setup: setus,
            ));
    Navigator.of(context).push(gotoaction);
  }
  if (detailvillagedata.refid == DataPointEau.refid) {
    Route gotoaction = MaterialPageRoute(
        builder: (context) => WaterScreen(
              village: selectedvillage,
              setup: setus,
            ));
    Navigator.of(context).push(gotoaction);
  }
  if (detailvillagedata.refid == DataLatrines.refid) {
    Route gotoaction = MaterialPageRoute(
        builder: (context) => LatrineScreen(
              village: selectedvillage,
              setup: setus,
            ));
    Navigator.of(context).push(gotoaction);
  }
  if (detailvillagedata.refid == DataDanger.refid) {
    Route gotoaction = MaterialPageRoute(
        builder: (context) => DangerScreen(
              village: selectedvillage,
              setup: setus,
            ));
    Navigator.of(context).push(gotoaction);
  }
}

//  void godotherigghtaction(T rightpage,BuildContext context)
//  {
//        Route gotoaction = MaterialPageRoute(builder: (context) => rightpage);
//        Navigator.of(context).push(gotoaction);
//  }

Widget makeCard(DetailVillageItemData villageitemdata, Village village,
    Setting setus, BuildContext context) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
          color:
              villageitemdata.villagecolor), //Color.fromRGBO(64, 75, 96, .9))
      child: makeListTile(villageitemdata, village, setus, context),
    ),
  );
}

Widget makeListTile(DetailVillageItemData action, Village village,
    Setting setus, BuildContext context) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
        border: new Border(
          right: new BorderSide(width: 1.0, color: Colors.white24),
        ),
      ),
      child: Image.asset(action.imgpath),
    ),
    title: Text(
      "${action.nom} ",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    trailing: Text(
      "${action.number}",
      style: TextStyle(color: Colors.white),
    ),
    onTap: () {
      selectrightaction(action, village, setus, context);
    },
  );
}

Widget makeBody(
    List<DetailVillageItemData> villagedetailcollecte,
    Village village,
    Setting setus,
    ObjectCount count,
    String batiment,
    String danger,
    String latrine,
    String pointeau) {
  villagedetailcollecte.clear();
  villagedetailcollecte.add(DetailVillageItemData(batiment, count.nbrbatiments,
      DataBatiment.refid, DataBatiment.imgpath, UIData.batprivcolordark));
  villagedetailcollecte.add(DetailVillageItemData(latrine, count.nbrlatrines,
      DataLatrines.refid, DataLatrines.imgpath, UIData.latrinecolordark));
  villagedetailcollecte.add(DetailVillageItemData(pointeau, count.nbrwaters,
      DataPointEau.refid, DataPointEau.imgpath, UIData.watercolordark));
  villagedetailcollecte.add(DetailVillageItemData(danger, count.nbrdangers,
      DataDanger.refid, DataDanger.imgpath, UIData.dangercolordark));

  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: villagedetailcollecte.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(villagedetailcollecte[index], village, setus, context);
      },
    ),
  );
}

class DetailVillageItemData {
  String nom;
  int number;
  int refid;
  String imgpath;
  Color villagecolor;

  DetailVillageItemData(
      this.nom, this.number, this.refid, this.imgpath, this.villagecolor);
}
