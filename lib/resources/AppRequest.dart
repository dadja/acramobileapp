import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:acra/models/forms/listregionsdakar.dart';

class LocalDataBase {
  // static Future<List<Region>> getProfessions(BuildContext context) async {
  //   String data = await DefaultAssetBundle.of(context)
  //       .loadString('assets/listregionsdakar.json');

  //   // If the call to the server was successful, parse the JSON
  //   Iterable list = json.decode(data);
  //   return list.map((model) => Region.fromJson(model)).toList();
  // }

  static Future<ListRegionDakar> getRegions(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/listregionsdakar.json');

    // print("data regions acquired => \n $data");

    // return ListRegionDakarFromJson(data);
    return ListRegionDakar.fromJson(json.decode(data));
  }
}
