import 'package:acra/resources/db.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/material.dart';
import 'package:acra/models/village.dart';
import 'package:acra/ui/detailvillagescreen.dart';
import 'package:acra/ui/villagequest/forms/villageform.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'mapscreen.dart';
import 'package:acra/models/settings.dart';
import 'package:acra/database/db_helper.dart';
import 'package:acra/app_localization.dart';
import 'package:acra/login.dart';
import 'package:acra/app_localization.dart';

class VillageScreen extends StatefulWidget {
  @override
  _VillageScreenState createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
  var dbHelper = DBHelper();
  Setting setup = Setting();
  Future<List<Village>> lastvillagefuture;

  void getprefsandRetrieveData() async {
    setup = await SharePrefsData.readDeviceSetupFromPrefs();
    retrievedata();
  }

  refreshList() {
    setState(() {
      lastvillagefuture = dbHelper.getVillages();
    });
  }

  void retrievedata() {
    setState(() {
      // print("refresh called");
      dbHelper = DBHelper();
      refreshList();
    });
  }

  @override
  void initState() {
    super.initState();
    getprefsandRetrieveData();
    // dbHelper = DBHelper();
    // refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate('village_page_title')),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.map,
              color: Colors.white,
            ),
            onPressed: () {
              Route maproute = MaterialPageRoute(
                  builder: (context) => MapScreen(
                        setup: setup,
                      ));
              Navigator.of(context).push(maproute).whenComplete(retrievedata);
            },
          ),
          FlatButton(
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Route enrolroute =
                  MaterialPageRoute(builder: (context) => Login());
              Navigator.of(context).push(enrolroute).whenComplete(retrievedata);
            },
          ),
        ],
      ),
      body: makeBody(lastvillagefuture, setup),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: UIData.acraorangecolor,
        onPressed: () {
          // getprefs();
          if (setup != null && setup.collectorId.isNotEmpty) {
            Route enrolroute =
                MaterialPageRoute(builder: (context) => VillageForm());
            Navigator.of(context).push(enrolroute).whenComplete(retrievedata);
          } else {
            showDoneDialog(
                context,
                AppLocalizations.of(context)
                    .translate('dialog_device_nosetup_title'),
                AppLocalizations.of(context)
                    .translate('dialog_device_nosetup_content'),
                UIData.dangercolordark,
                null);
          }
        },
      ),
    );
  }

  void gotoListVillagepage() {
    Route gotoaction = MaterialPageRoute(builder: (context) => VillageScreen());
    Navigator.of(context).push(gotoaction);
  }
}

Widget makeCard(Village villa, Setting setme, BuildContext context) {
  // print("village nom ${villa.nom}");
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration:
          BoxDecoration(color: Colors.white), //Color.fromRGBO(64, 75, 96, .9))
      child: makeListTile(villa, setme, context),
    ),
  );
}

Widget makeListTile(Village villag, Setting setme, BuildContext context) {
  return ListTile(
    leading: Container(
        width: 60,
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        )),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    title: Text(
      " Nom Village : ${villag.nom} ",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      " Region : ${villag.region}  \n Department : ${villag.departement}",
      style:
          TextStyle(color: UIData.acraorangecolor, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.keyboard_arrow_right,
        color: UIData.acraorangecolor, size: 30.0),
    onTap: () {
      Route detailvillagepage = MaterialPageRoute(
          builder: (context) => DetailVillage(
                village: villag,
                setup: setme,
              ));
      Navigator.of(context).push(detailvillagepage);
    },
  );
}

Widget makeBody(Future<List<Village>> villagefuture, Setting setme) {
  return StreamBuilder<List<Village>>(
      stream: villagefuture?.asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data.length != 0)
              ? Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(snapshot.data[index], setme, context);
                    },
                  ),
                )
              : Container(
                  child: Center(
                  child: noCustomDataFoundWidget(
                      "assets/mudhut.png",
                      AppLocalizations.of(context)
                          .translate('village_page_list_nodata_found')),
                  // Text("Pas de village vouas pouvez enregistrer un village en cliquant sur le bouton orange en bas")
                ));
        }
        if (snapshot.hasError) {
          return Container(
              child: Center(child: Text("Has Error ${snapshot.error}")));
        }

        return Container(child: Center(child: CircularProgressIndicator()));
      });
}
