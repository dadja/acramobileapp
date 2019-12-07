import 'package:flutter/material.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/app_localization.dart';

class DetailDanger extends StatelessWidget {
  final DangerData realdanger;

  const DetailDanger({Key key, this.realdanger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.dangercolordark,
        title: Text(
          AppLocalizations.of(context).translate('detail_danger_appbartitle'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
                child: makeCard(realdanger, context, UIData.dangercolordark))),
      ),
    );
  }
}

Widget makeCard(DangerData danger, BuildContext context, Color colorlight) {
  return Card(
    elevation: 8.0,
    // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_nom'),
                danger.nom, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_type'),
                danger.type, colorlight),
            SizedBox(
              height: 10.0,
            ),
            (danger.note.isNotEmpty)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('generic_note_label'),
                    danger.note,
                    colorlight)
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_region'),
                danger.region, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_departement'),
                danger.departement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_arrondis'),
                danger.arrondissement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_commune'),
                danger.commune, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_village'),
                danger.village, colorlight),
            //TOOD End it by a button it here
          ],
        ),
      ),
    ),
  );
}
