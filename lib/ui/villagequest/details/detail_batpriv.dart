import 'package:flutter/material.dart';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/app_localization.dart';

class DetailBatimentPrive extends StatelessWidget {
  final BatimentPriveData batpriv;

  const DetailBatimentPrive({Key key, this.batpriv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.batprivcolordark,
        title: Text(
          AppLocalizations.of(context).translate('detail_batpriv_appbartitle'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
                child: makeCard(batpriv, context, UIData.batprivcolordark))),
      ),
    );
  }
}

Widget makeCard(
    BatimentPriveData bati, BuildContext context, Color colorlight) {
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
            textField(
                AppLocalizations.of(context)
                    .translate('batpriv_nomproprio_label'),
                bati.nomproprio,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpriv_numproprio_label'),
                bati.numproprio,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpriv_nbrenfants_label'),
                bati.nbrenfants.toString(),
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpriv_nbradultes_label'),
                bati.nbradultes.toString(),
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpriv_nbrvieux_label'),
                bati.nbrvieux.toString(),
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            (bati.robinetexistant == true)
                ? textField(
                    AppLocalizations.of(context).translate('generic_robexist'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context).translate('generic_robexist'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (bati.robinetfonctionnel == true)
                ? textField(
                    AppLocalizations.of(context).translate('generic_robworks'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context).translate('generic_robworks'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (bati.note.isNotEmpty)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('generic_note_label'),
                    bati.note.toString(),
                    colorlight)
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_region'),
                bati.region, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_departement'),
                bati.departement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_arrondis'),
                bati.arrondissement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_commune'),
                bati.commune, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_village'),
                bati.village, colorlight),
            //TOOD End it by a button it here
          ],
        ),
      ),
    ),
  );
}
