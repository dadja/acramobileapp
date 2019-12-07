import 'dart:io';
import 'package:acra/models/forms/batimentprivedata.dart';
import 'package:acra/models/forms/batimentpublicdata.dart';
import 'package:acra/models/forms/latrinedata.dart';
import 'package:acra/models/forms/waterdata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pdfLib;
import 'package:csv/csv.dart';
import 'package:acra/models/forms/dangerdata.dart';
import 'package:acra/uidata.dart';

//describing the type of data we going to export ...
abstract class CsvExport {
  exportdangers(BuildContext context, List<DangerData> data);
  exportlatrines(BuildContext context, List<LatrineData> data);
  exportbatimentpublics(BuildContext context, List<BatimentPublicData> data);
  exportbatimentprives(BuildContext context, List<BatimentPriveData> data);
  exportpointeau(BuildContext context, List<WaterData> data);
}

class ExportData extends CsvExport {
  @override
  exportdangers(BuildContext context, List<DangerData> data) async {
    // TODO: implement exportbatimentprive

    // Ordre d’affichage des données :
    //  Région, département, arrondissement, commune, village,
    //   date, collecteur, latitude, longitude,
    //   ensuite le formulaire
    //= await _databaseService.list().first;
    List<List<String>> csvData = [
      // headers
      <String>[
        'Région',
        'département',
        'arrondissement',
        'commune',
        'village',
        'date',
        'partenaire',
        'collecteur',
        'latitude',
        'longitude',
        'nomdanger',
        'typedanger',
        'note'
      ],
      // data
      ...data.map((item) => [
            item.region,
            item.departement,
            item.arrondissement,
            item.commune,
            item.village,
            setupDate(item.date),
            item.partenaire.toString(),
            item.collecteur.toString(),
            item.latitude.toString(),
            item.longitude.toString(),
            item.nom,
            item.type,
            item.note
          ]),
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory())
        .path; //TOOD change this path to public one
    final String path = '$dir/dangers-${setupDate(DateTime.now())}.csv';

    // create file
    final File file = File(path);
    // Save csv string using default configuration
    // , as field separator
    // " as text delimiter and
    // \r\n as eol.
    await file.writeAsString(csv);

    return null;
  }

  @override
  exportbatimentpublics(
      BuildContext context, List<BatimentPublicData> data) async {
    // Ordre d’affichage des données :
    //  Région, département, arrondissement, commune, village,
    //   date, collecteur, latitude, longitude,
    //   ensuite le formulaire
    //= await _databaseService.list().first;
    List<List<String>> csvData = [
      // headers
      <String>[
        'Région',
        'département',
        'arrondissement',
        'commune',
        'village',
        'date',
        'collecteur',
        'partenaire',
        'latitude',
        'longitude',
        'nombatiment',
        'soustypebatiment',
        'typebatiment',
        'robinetexistant',
        'robinetfonctionnel',
        'note'
      ],
      // data
      ...data.map((item) => [
            item.region,
            item.departement,
            item.arrondissement,
            item.commune,
            item.village,
            setupDate(item.date),
            item.collecteur.toString(),
            item.latitude.toString(),
            item.longitude.toString(),
            item.nombatiment,
            item.soustypebatiment,
            item.typebatiment,
            (item.robinetexistant == true) ? "Oui" : "Non",
            (item.robinetfonctionnel == true)
                ? "Oui"
                : "Non", //TODO to change by oui ou non
            item.note
          ]),
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory())
        .path; //TOOD change this path to public one
    final String path = '$dir/batpub-${setupDate(DateTime.now())}.csv';

    // create file
    final File file = File(path);
    // Save csv string using default configuration
    // , as field separator
    // " as text delimiter and
    // \r\n as eol.
    await file.writeAsString(csv);

    return null;
  }

  @override
  exportbatimentprives(
      BuildContext context, List<BatimentPriveData> data) async {
    // Ordre d’affichage des données :
    //  Région, département, arrondissement, commune, village,
    //   date, collecteur, latitude, longitude,
    //   ensuite le formulaire
    //= await _databaseService.list().first;
    List<List<String>> csvData = [
      // headers
      <String>[
        'Région',
        'département',
        'arrondissement',
        'commune',
        'village',
        'date',
        'collecteur',
        'latitude',
        'longitude',
        'nomproprio',
        'numproprio',
        'nbradultes',
        'nbrvieux',
        'nbrenfants',
        'robinetexistant',
        'robinetfonctionnel',
        'note'
      ],

      // data
      ...data.map((item) => [
            item.region,
            item.departement,
            item.arrondissement,
            item.commune,
            item.village,
            setupDate(item.date),
            item.collecteur.toString(),
            item.latitude.toString(),
            item.longitude.toString(),
            item.nomproprio.toString(),
            item.numproprio.toString(),
            item.nbradultes.toString(),
            item.nbrvieux.toString(),
            item.nbrenfants.toString(),
            (item.robinetexistant == true) ? "Oui" : "Non",
            (item.robinetfonctionnel == true) ? "Oui" : "Non",
            item.note
          ]),
    ];

    // data.forEach((item) {
    //   csvData.add([
    //     item.region,
    //     item.departement,
    //     item.arrondissement,
    //     item.commune,
    //     item.village,
    //     setupDate(item.date),
    //     item.collecteur.toString(),
    //     item.latitude.toString(),
    //     item.longitude.toString(),
    //     item.nomproprio.toString(),
    //     item.numproprio,
    //     item.nbradultes.toString(),
    //     item.nbrvieux.toString(),
    //     item.nbrenfants.toString(),
    //     (item.robinetexistant == true) ? "Oui" : "Non",
    //     (item.robinetfonctionnel == true) ? "Oui" : "Non",
    //     item.note
    //   ]);
    // });

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory())
        .path; //TOOD change this path to public one
    final String path = '$dir/batpriv-${setupDate(DateTime.now())}.csv';

    // create file
    final File file = File(path);
    // Save csv string using default configuration
    // , as field separator
    // " as text delimiter and
    // \r\n as eol.
    await file.writeAsString(csv);

    return null;
  }

  @override
  exportlatrines(BuildContext context, List<LatrineData> data) async {
    // Ordre d’affichage des données :
    //  Région, département, arrondissement, commune, village,
    //   date, collecteur, latitude, longitude,
    //   ensuite le formulaire
    //= await _databaseService.list().first;
    List<List<String>> csvData = [
      // headers
      <String>[
        'Région',
        'département',
        'arrondissement',
        'commune',
        'village',
        'date',
        'partenaire',
        'collecteur',
        'latitude',
        'longitude',
        'nomproprio',
        'numproprio',
        'typelatrine',
        'superstructure',
        'dalle',
        'bonetatgeneral',
        'doublefosse',
        'siege',
        'ventilation',
        'porte',
        'fermeture',
        'toit',
        'couvercledefecation',
        'propre',
        'odeur',
        'slms',
        'note'
      ],
      // data
      ...data.map((item) => [
            item.region,
            item.departement,
            item.arrondissement,
            item.commune,
            item.village,
            setupDate(item.date),
            item.partenaire.toString(),
            item.collecteur.toString(),
            item.latitude.toString(),
            item.longitude.toString(),
            item.nomproprio,
            item.numproprio,
            item.typelatrine,
            item.superstructure,
            item.dalle,
            (item.bonetatgeneral == true) ? "Oui" : "Non",
            (item.doublefosse == true) ? "Oui" : "Non",
            (item.siege == true) ? "Oui" : "Non",
            (item.ventilation == true) ? "Oui" : "Non",
            (item.porte == true) ? "Oui" : "Non",
            (item.fermeture == true) ? "Oui" : "Non",
            (item.toit == true) ? "Oui" : "Non",
            (item.couvercledefecation == true) ? "Oui" : "Non",
            (item.propre == true) ? "Oui" : "Non",
            (item.odeur == true) ? "Oui" : "Non",
            (item.slms == true) ? "Oui" : "Non",
            item.note
          ]),
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory())
        .path; //TOOD change this path to public one
    final String path = '$dir/latrine-${setupDate(DateTime.now())}.csv';

    // create file
    final File file = File(path);
    // Save csv string using default configuration
    // , as field separator
    // " as text delimiter and
    // \r\n as eol.
    await file.writeAsString(csv);

    return null;
  }

  @override
  exportpointeau(BuildContext context, List<WaterData> data) async {
    // Ordre d’affichage des données :
    //  Région, département, arrondissement, commune, village,
    //   date, collecteur, latitude, longitude,
    //   ensuite le formulaire
    //= await _databaseService.list().first;
    List<List<String>> csvData = [
      // headers
      <String>[
        'Région',
        'département',
        'arrondissement',
        'commune',
        'village',
        'date',
        'collecteur',
        'latitude',
        'longitude',
        'nompointeau',
        'typepointeau',
        'modelepompe',
        'profondeur',
        'couverclepuit',
        'typepuit',
        'puitdateexploitation',
        'puitusage',
        'puitdebithorairepompe',
        'puitdureejournalierepompage',
        'puitvolumemensuelpreleve',
        'puitnombrejourpompage',
        'puitniveaustatiquepuit',
        'puitpotentielhydraulique',
        'puittemperature',
        'puitconductiviteelectrique',
        'forageteteprotege',
        'foragesourcealimentation',
        'foragecloture',
        'foragedateexploitation',
        'forageusage',
        'foragedebithorairepompe',
        'foragedureejournalierepompage',
        'foragevolumemensuelpreleve',
        'foragenombrejourpompage',
        'forageniveaustatiqueforage',
        'foragepotentielhydraulique',
        'foragetemperature',
        'forageconductiviteelectrique',
        'sourcenote',
        'sourceamenage',
        'autretypepointeau',
        'bonetatgeneral',
        'cloture',
        'drainage',
        'amenage',
        'note'
      ],
      // data
      ...data.map((item) => [
            item.region,
            item.departement,
            item.arrondissement,
            item.commune,
            item.village,
            setupDate(item.date),
            item.collecteur.toString(),
            item.latitude.toString(),
            item.longitude.toString(),
            item.nompointeau,
            item.typepointeau,
            item.modelepompe,
            item.profondeur,
            (item.couverclepuit == true) ? "Oui" : "Non",
            item.typepuit,
            setupDate(item.puitdateexploitation),
            item.puitusage,
            item.puitdebithorairepompe,
            item.puitdureejournalierepompage,
            item.puitvolumemensuelpreleve,
            item.puitnombrejourpompage,
            item.puitniveaustatiquepuit,
            item.puitpotentielhydraulique,
            item.puittemperature,
            item.puitconductiviteelectrique,
            (item.forageteteprotege == true) ? "Oui" : "Non",
            item.foragesourcealimentation,
            (item.foragecloture == true) ? "Oui" : "Non",
            setupDate(item.foragedateexploitation),
            item.forageusage,
            item.foragedebithorairepompe,
            item.foragedureejournalierepompage,
            item.foragevolumemensuelpreleve,
            item.foragenombrejourpompage,
            item.forageniveaustatiqueforage,
            item.foragepotentielhydraulique,
            item.foragetemperature,
            item.forageconductiviteelectrique,
            item.sourcenote,
            (item.sourceamenage == true) ? "Oui" : "Non",
            item.autretypepointeau,
            (item.bonetatgeneral == true) ? "Oui" : "Non",
            (item.cloture == true) ? "Oui" : "Non",
            (item.drainage == true) ? "Oui" : "Non",
            (item.amenage == true) ? "Oui" : "Non",
            item.note
          ]),
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final String dir = (await getApplicationDocumentsDirectory())
        .path; //TOOD change this path to public one
    final String path = '$dir/pointeau-${setupDate(DateTime.now())}.csv';

    // create file
    final File file = File(path);
    // Save csv string using default configuration
    // , as field separator
    // " as text delimiter and
    // \r\n as eol.
    await file.writeAsString(csv);

    return null;
  }
}

// Future<void> generateCSVAndView(context) async {
//     List<BaseballModel> data = await _databaseService.list().first;
//     List<List<String>> csvData = [
//       // headers
//       <String>['Name', 'Coach', 'players'],
//       // data
//       ...data.map((item) => [item.name, item.coach, item.players.toString()]),
//     ];

//     String csv = const ListToCsvConverter().convert(csvData);

//     final String dir = (await getApplicationDocumentsDirectory()).path;
//     final String path = '$dir/baseball_teams.csv';

//     // create file
//     final File file = File(path);
//     // Save csv string using default configuration
//     // , as field separator
//     // " as text delimiter and
//     // \r\n as eol.
//     await file.writeAsString(csv);

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => LoadAndViewCsvPage(path: path),
//       ),
//     );
//   }
// }

//   static generatePdfAndView(context) async {
//     List<BaseballModel> data = await _databaseService.list().first;
//     final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

//     pdf.addPage(
//       pdfLib.MultiPage(
//         build: (context) => [
//               pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
//                 <String>['Name', 'Coach', 'players'],
//                 ...data.map(
//                     (item) => [item.name, item.coach, item.players.toString()])
//               ]),
//             ],
//       ),
//     );

//     final String dir = (await getApplicationDocumentsDirectory()).path;
//     final String path = '$dir/baseball_teams.pdf';
//     final File file = File(path);
//     await file.writeAsBytes(pdf.save());
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => PdfViewerPage(path: path),
//       ),
//     );
//   }
// }
