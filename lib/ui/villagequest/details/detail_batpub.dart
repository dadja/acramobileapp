import 'package:flutter/material.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/app_localization.dart';

class DetailBatimentPublic extends StatelessWidget {
  final BatimentPublicData batpub;

  const DetailBatimentPublic({Key key, this.batpub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.batpubcolordark,
        title: Text(
          AppLocalizations.of(context).translate('detail_batpub_appbartitle'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
                child: makeCard(batpub, context, UIData.batpubcolordark))),
      ),
    );
  }
}

Widget makeCard(
    BatimentPublicData bati, BuildContext context, Color colorlight) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                    .translate('batpub_form_nombatiment_label'),
                bati.nombatiment,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpub_form_info_typebatiment'),
                bati.typebatiment,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('batpub_form_info_soustypebatiment'),
                bati.soustypebatiment,
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
