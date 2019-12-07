import 'package:flutter/material.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:acra/app_localization.dart';

class DetailLatrine extends StatelessWidget {
  final LatrineData latrine;

  const DetailLatrine({Key key, this.latrine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.latrinecolordark,
        title: Text(
          AppLocalizations.of(context).translate('detail_latrine_appbartitle'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
                child: makeCard(latrine, context, UIData.latrinecolordark))),
      ),
    );
  }
}

Widget makeCard(LatrineData latrine, BuildContext context, Color colorlight) {
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
                    .translate('latrine_form_nomproprio_label'),
                latrine.nomproprio,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('latrine_form_numproprio_label'),
                latrine.numproprio,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('latrine_form_dropdown_typelatrines_title'),
                latrine.typelatrine,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('latrine_form_dropdown_typesuperstruct_title'),
                latrine.superstructure,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context)
                    .translate('latrine_form_dropdown_typesdalle_title'),
                latrine.dalle,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.bonetatgeneral == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_bonetatgeneral'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_bonetatgeneral'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.doublefosse == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_doublefosse'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_doublefosse'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.siege == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_siege'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_siege'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.ventilation == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_ventilation'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_ventilation'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            (latrine.porte == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_porte'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_porte'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.fermeture == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_fermeture'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_fermeture'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.toit == true)
                ? textField(
                    AppLocalizations.of(context).translate('latrine_form_toit'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context).translate('latrine_form_toit'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.couvercledefecation == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_couvercle_defecation'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_couvercle_defecation'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.propre == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_propre'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_propre'),
                    "Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            (latrine.odeur == true)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_odeur'),
                    "Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context)
                        .translate('latrine_form_odeur'),
                    " Non",
                    colorlight),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            (latrine.doublefosse == true)
                ? textField(
                    AppLocalizations.of(context).translate('latrine_form_slms'),
                    " Oui",
                    colorlight)
                : textField(
                    AppLocalizations.of(context).translate('latrine_form_slms'),
                    "Non",
                    colorlight),
            (latrine.note.isNotEmpty)
                ? textField(
                    AppLocalizations.of(context)
                        .translate('generic_note_label'),
                    latrine.note,
                    colorlight)
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_region'),
                latrine.region, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_departement'),
                latrine.departement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(
                AppLocalizations.of(context).translate('generic_arrondis'),
                latrine.arrondissement,
                colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_commune'),
                latrine.commune, colorlight),
            SizedBox(
              height: 10.0,
            ),
            textField(AppLocalizations.of(context).translate('generic_village'),
                latrine.village, colorlight),
            //TOOD End it by a button it here
          ],
        ),
      ),
    ),
  );
}
