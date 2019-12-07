import 'package:acra/models/settings.dart';
import 'package:acra/uidata.dart';
import 'package:flutter/material.dart';
import 'package:acra/ui/villagequest/forms/batpubform.dart';
import 'package:acra/ui/villagequest/forms/batprivform.dart';
import 'package:acra/resources/db.dart';
import 'package:acra/ui/villagequest/batiments/batimentprivewidget.dart';
import 'package:acra/ui/villagequest/batiments/batimentpublicwidget.dart';
import 'package:acra/models/village.dart';
import 'package:acra/app_localization.dart';

class BatimentScreen extends StatefulWidget {
  final Village village;
  final Setting setup;

  BatimentScreen({this.village, this.setup});
  @override
  _BatimentScreenState createState() => _BatimentScreenState();
}

class _BatimentScreenState extends State<BatimentScreen> {
  Stream lookforbatpriv;
  Stream lookforbatpub;
  Color appbarcolor;

  var dialogtitle = "";
  var dialogpublicoptipn = "";
  var dialogprivoption = "";

  // TabController controller = TabController(initialIndex: 0, length: 2);

  @override
  void initState() {
    lookforbatpriv =
        DataBaseService.getBatimentprives(widget.village, widget.setup);
    lookforbatpub =
        DataBaseService.getBatimentpublics(widget.village, widget.setup);
    // controller.addListener(() {
    //   if (controller.index == 1) {
    //     setState(() {
    //       appbarcolor = UIData.batprivcolordark;
    //     });
    //   } else {
    //     setState(() {
    //       appbarcolor = UIData.batprivcolordark;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appbarcolor = UIData.batpubcolordark;
    dialogtitle =
        AppLocalizations.of(context).translate('batiment_dialog_title');
    dialogpublicoptipn =
        AppLocalizations.of(context).translate('batiment_dialog_public_option');
    dialogprivoption =
        AppLocalizations.of(context).translate('batiment_dialog_priv_option');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                  text: AppLocalizations.of(context)
                      .translate('batiment_screen_public_tab_text'),
                  icon: Icon(Icons.directions_car)),
              Tab(
                  text: AppLocalizations.of(context)
                      .translate('batiment_screen_priv_tab_text'),
                  icon: Icon(Icons.directions_transit)),
            ],
          ),
          title: Text(AppLocalizations.of(context)
              .translate('batiment_screen_appbartitle')),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: TabBarView(
              children: [
                // Icon(Icons.directions_car),
                buildbatimentpublic(lookforbatpub),
                buildbatimentprive(lookforbatpriv),
                // Icon(Icons.directions_transit),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showdialog(dialogtitle, dialogpublicoptipn, dialogprivoption);
          },
        ),
      ),
    );
  }

  Widget batimentsPages() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
        ],
      ),
    );
  }

  void showdialog(String dialogtitle, String dioalogpublicoption,
      String dialogprivateoption) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(dialogtitle),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  dioalogpublicoption,
                  style: TextStyle(color: UIData.batpubcolordark),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  //launch private form
                  Route gotoaction = MaterialPageRoute(
                      builder: (context) =>
                          BatimentPublicForm(village: widget.village));
                  Navigator.of(context).push(gotoaction);
                },
              ),
              FlatButton(
                child: Text(
                  dialogprivateoption,
                  style: TextStyle(color: UIData.batprivcolordark),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  //launch private form
                  Route gotoaction = MaterialPageRoute(
                      builder: (context) =>
                          BatimentPriveForm(village: widget.village));
                  Navigator.of(context).push(gotoaction);
                },
              ),
            ],
          );
        });
  }
}
