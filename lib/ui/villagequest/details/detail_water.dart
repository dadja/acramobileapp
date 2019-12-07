import 'package:acra/ui/uitest/usefulwidget.dart';
import 'package:flutter/material.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:acra/uidata.dart';
import 'package:acra/app_localization.dart';

class DetailWater extends StatelessWidget {
  final WaterData water;

  const DetailWater({Key key, this.water}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.watercolordark,
        title: Text(
          AppLocalizations.of(context).translate('detail_pointeau_title'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child:
              Center(child: makeCard(water, context, UIData.watercolordark))),
    );
  }
}

Widget genericdebutinfos(
    WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_nom'),
              water.nompointeau,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context)
                  .translate('water_form_typeeau_dropdown_title'),
              water.typepointeau,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget genericendinfos(
    WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      (water.note.isNotEmpty)
          ? Container(
              padding: EdgeInsets.all(16),
              child: textField(
                  AppLocalizations.of(context).translate('generic_note_label'),
                  water.note,
                  colorlight))
          : Container(),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_region'),
              water.region,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_departement'),
              water.departement,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_arrondis'),
              water.arrondissement,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_commune'),
              water.commune,
              colorlight)),
      SizedBox(
        height: 10.0,
      ),
      Container(
          padding: EdgeInsets.all(16),
          child: textField(
              AppLocalizations.of(context).translate('generic_village'),
              water.village,
              colorlight)),
    ],
  );
}

Widget makeCard(WaterData waterme, BuildContext context, Color colorlight) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              genericdebutinfos(waterme, colorlight, context),
              rightWidget(waterme, colorlight, context),
              genericendinfos(waterme, colorlight, context),
              //TOOD End it by a button it here
            ],
          ),
        ),
      ),
    ),
  );
}

Widget detailpompemanuelle(
    WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Text(AppLocalizations.of(context)
          .translate('water_form_info_pompemanuelle')),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_typepompemanuelle_dropdown_title'),
            water.modelepompe,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: (water.drainage == true)
            ? textField(
                AppLocalizations.of(context).translate('water_form_drainage'),
                "Oui",
                colorlight)
            : textField(
                AppLocalizations.of(context).translate('water_form_drainage'),
                "Non",
                colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget detailpuit(WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Text(AppLocalizations.of(context).translate('water_form_info_puit')),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_typepuit_dropdown_title'),
            water.typepuit,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context).translate('water_form_usageeau_title'),
            water.puitusage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),

      (water.couverclepuit == true)
          ? Container(
              padding: EdgeInsets.all(16),
              child: textField(
                  AppLocalizations.of(context)
                      .translate('water_form_couvercle'),
                  "Oui",
                  colorlight))
          : Container(
              padding: EdgeInsets.all(16),
              child: textField(
                  AppLocalizations.of(context)
                      .translate('water_form_couvercle'),
                  "Non",
                  colorlight)),
      // this.forageusage,Multi select from type usage
      SizedBox(
        height: 10.0,
      ),
      // this.foragedebithorairepompe, TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitdebithorairepompe_label'),
            water.puitdebithorairepompe,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragedureejournalierepompage,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitdureejournaliere_label'),
            water.puitdureejournalierepompage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragevolumemensuelpreleve,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitvolumemensuelprel_label'),
            water.puitvolumemensuelpreleve,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragenombrejourpompage, TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitnbrjourpompage_label'),
            water.puitnombrejourpompage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.forageniveaustatiqueforage,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitniveaustat_label'),
            water.puitniveaustatiquepuit,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragepotentielhydraulique,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitpotentielhydrau_label'),
            water.puitniveaustatiquepuit,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragetemperature,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context).translate('water_form_puitemp_label'),
            water.puittemperature,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.forageconductiviteelectrique,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_puitconductelec_label'),
            water.puitconductiviteelectrique,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget detailforage(WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Text(AppLocalizations.of(context).translate('water_form_info_forage')),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_sourcealimforage_dropdown_title'),
            water.foragesourcealimentation,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context).translate('water_form_usageeau_title'),
            water.forageusage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),

      (water.forageteteprotege == true)
          ? Container(
              padding: EdgeInsets.all(16),
              child: textField(
                  AppLocalizations.of(context)
                      .translate('water_form_teteforageprotege'),
                  " Oui",
                  colorlight))
          : Container(
              padding: EdgeInsets.all(16),
              child: textField(
                  AppLocalizations.of(context)
                      .translate('water_form_teteforageprotege'),
                  " Non",
                  colorlight)),
      // this.forageusage,Multi select from type usage
      SizedBox(
        height: 10.0,
      ),
      // this.foragedebithorairepompe, TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragedebithorairepompe_label'),
            water.foragedebithorairepompe,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragedureejournalierepompage,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragedureejournaliere_label'),
            water.foragedureejournalierepompage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragevolumemensuelpreleve,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragecvolumemensuelprel_label'),
            water.foragevolumemensuelpreleve,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragenombrejourpompage, TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragenbrjourpompage_label'),
            water.foragenombrejourpompage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.forageniveaustatiqueforage,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_forageniveaustat_label'),
            water.forageniveaustatiqueforage,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragepotentielhydraulique,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragepotentielhydrau_label'),
            water.foragepotentielhydraulique,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.foragetemperature,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_foragetemp_label'),
            water.foragetemperature,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
      // this.forageconductiviteelectrique,TextField
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_forageconductelec_label'),
            water.forageconductiviteelectrique,
            colorlight),
      ),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget detailAutreTypePointEau(
    WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Text(AppLocalizations.of(context).translate('water_form_info_autretype')),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: textField(
            AppLocalizations.of(context)
                .translate('water_form_autretypepointeau_label'),
            water.autretypepointeau,
            colorlight),
      ),
    ],
  );
}

Widget detailsource(WaterData water, Color colorlight, BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 10.0,
      ),
      Text(AppLocalizations.of(context).translate('water_form_info_source')),
      SizedBox(
        height: 10.0,
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: (water.sourcenote.isNotEmpty)
            ? textField(
                AppLocalizations.of(context)
                    .translate('water_form_notesource_label'),
                water.sourcenote,
                colorlight)
            : Container(),
      ),
      SizedBox(
        height: 10.0,
      ),
      (water.bonetatgeneral == true)
          ? textField(
              AppLocalizations.of(context).translate('water_form_amenage'),
              " Oui",
              colorlight)
          : textField(
              AppLocalizations.of(context).translate('water_form_amenage'),
              "Non",
              colorlight),
      SizedBox(
        height: 10.0,
      ),
    ],
  );
}

Widget rightWidget(
    WaterData waterdata, Color colorlight, BuildContext context) {
  switch (waterdata.typepointeau) {
    case "Pompe manuelle":
      return detailpompemanuelle(waterdata, colorlight, context);
    case "Puit":
      return detailpuit(waterdata, colorlight, context);
    case "Forage":
      return detailforage(waterdata, colorlight, context);
    case "Source":
      return detailsource(waterdata, colorlight, context);
    case "Autre type de point d'eau":
      return detailAutreTypePointEau(waterdata, colorlight, context);
    default:
      return Container();
  }
}
