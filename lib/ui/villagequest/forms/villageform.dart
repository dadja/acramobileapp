import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:acra/uidata.dart';
import 'package:acra/resources/AppRequest.dart';
import 'package:acra/models/forms/listregionsdakar.dart';
import 'package:acra/models/village.dart';
import 'package:provider/provider.dart';
import 'package:acra/database/db_helper.dart';
import 'package:acra/app_localization.dart';

class VillageForm extends StatefulWidget {
  @override
  _VillageFormState createState() => _VillageFormState();
}

class _VillageFormState extends State<VillageForm> {
  var dbHelper;
  final formkey = GlobalKey<FormState>();
  ListRegionDakar myregions = ListRegionDakar();
  // int indiceregion = 0;
  // int indicedepartement = 0;
  // int indicearrondissement = 0;
  // int indicecommune = 0;
  // String typedanger;
  // String typedangerresult;
  TextEditingController formedit = TextEditingController();

  Village village = Village();

  var regionssource = [];
  var depsource = [];
  var arrondisssource = [];
  var communesource = [];

  // Region _selectedregion = Region();
  dynamic _selectedregion;
  // Departement _selecteddepartement = Departement();
  dynamic _selecteddepartement;
  dynamic _selectedarrondissement;
  dynamic _selectedcommune;

  getallregions(BuildContext context) async {
    myregions = await LocalDataBase.getRegions(context);
    setState(() {
      regionssource = myregions.regions
          .map((region) => {"display": region.nom, "value": region})
          .toList();
    });

    // print("size of regionsource ${myregions.regions.length}");
  }

  @override
  void initState() {
    getallregions(context);
    dbHelper = DBHelper();
    super.initState();
    // position =
  }

  @override
  void dispose() {
    formedit.dispose();
    super.dispose();
  }

  void goback() {
    Navigator.of(context).pop();
  }

  _saveForm() {
    var form = formkey.currentState;
    if (form.validate()) {
      // print(
      //     " region ${village.region}\n departement ${village.departement}\n arrondissement ${village.arrondissement} \n commune ${village.commune}\n nom village ${village.nom}");
      form.save();
      dbHelper.save(village);
      showDoneDialog(
          context,
          "Village Enregistre",
          "Enregistrement Village effectue",
          Theme.of(context).primaryColor,
          goback);
    }
  }

  String departement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate('village_form_page_title')),
      ),
      body: ChangeNotifierProvider(
        builder: (_) => village,
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    //Regions
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context).translate(
                          'village_form_page_regions_dropdown_title'), //'Regions',
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: _selectedregion,
                      // onSaved: (value) {
                      //   print(
                      //       "Region associe saved is $value"); //${village.region}
                      // },
                      onChanged: (value) {
                        Region reg = (value is Region) ? value : null;
                        print("Region associe is ${reg?.nom}");
                        // _selectedregion = reg;
                        setState(() {
                          _selectedregion = reg;
                          village.region = reg?.nom;
                          depsource = reg?.departements
                              .map((departement) => {
                                    "display": departement.nom,
                                    "value": departement
                                  })
                              .toList();
                          //clear all other tables
                          arrondisssource = [];
                          communesource = [];
                          //clear all others selectors..
                          _selecteddepartement = null;
                          _selectedarrondissement = null;
                          _selectedcommune = null;
                        });

                        // print(
                        //     "new departements size  associe is ${reg?.departements?.length}");
                      },
                      dataSource: regionssource,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    //Departements
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context).translate(
                          'village_form_page_departement_dropdown_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: _selecteddepartement,
                      onChanged: (value) {
                        Departement dep = (value is Departement) ? value : null;
                        print("Departements associe is ${dep?.nom}");

                        setState(() {
                          _selecteddepartement = dep;
                          village.departement = dep?.nom;
                          arrondisssource = dep?.arrondissements
                              .map((arrondissement) => {
                                    "display": arrondissement.nom,
                                    "value": arrondissement
                                  })
                              .toList();
                          communesource = [];
                          _selectedarrondissement = null;
                          _selectedcommune = null;
                        });

                        // print(
                        //     "new arrondissements size  associe is ${dep?.arrondissements?.length}");
                      },
                      // dataSource: DataBatimentPublic.typebatiments,
                      dataSource: depsource,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    //Arrondissements
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context).translate(
                          'village_form_page_arrondis_dropdown_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: _selectedarrondissement,
                      onChanged: (value) {
                        Arrondissement ar =
                            (value is Arrondissement) ? value : null;

                        print("Arrondissement associe is ${ar?.nom}");
                        setState(() {
                          _selectedarrondissement = ar;
                          village.arrondissement = ar?.nom;
                          communesource = ar?.communes
                              .map((commune) =>
                                  {"display": commune.nom, "value": commune})
                              .toList();
                          _selectedcommune = null;
                        });
                        // print(
                        //     "new Commune size  associe is ${ar?.communes?.length}");
                      },
                      // dataSource: DataBatimentPublic.typebatiments,
                      dataSource: arrondisssource,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    //communes
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      titleText: AppLocalizations.of(context)
                          .translate('village_form_page_commu_dropdown_title'),
                      hintText: AppLocalizations.of(context)
                          .translate('generic_dropdown_subtitle_msg'),
                      value: _selectedcommune,
                      onChanged: (value) {
                        Commune comu = (value is Commune) ? value : null;

                        print("Commune associe is ${comu?.nom}");
                        setState(() {
                          _selectedcommune = comu;
                          village.commune = comu?.nom;
                        });
                      },
                      // dataSource: DataBatimentPublic.typebatiments,
                      dataSource: communesource,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: formedit,
                      //textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {},
                      onSaved: (term) {
                        setState(() {
                          village.nom = term;
                          formedit.text = term;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: AppLocalizations.of(context).translate(
                            'village_form_page_village_formfield_label'),
                        hintText: AppLocalizations.of(context).translate(
                            'village_form_page_village_formfield_hint'),
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "On veut un nom!";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('generic_create_bouton_label'),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _saveForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
