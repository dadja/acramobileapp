import 'package:flutter/foundation.dart';

class Setting {
  Setting({this.deviceId = "", this.partnerId = "", this.collectorId = ""});

  String deviceId = "";
  String partnerId = "";
  String collectorId = "";

  static Setting fromJson(Map<String, dynamic> json) {
    // print("JSON OBJECT IS $json");
    Setting setting = Setting();

    setting.deviceId = json["deviceId"];
    setting.partnerId = json["partnerId"];
    setting.collectorId = json["collectorId"];

    return setting;
  }

  String toSettingString() => "$deviceId-$partnerId-$collectorId";

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map["deviceId"] = deviceId;
    map["partnerId"] = partnerId;
    map["collectorId"] = collectorId;
    return map;
  }

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'partnerId': partnerId,
        'collectorId': collectorId,
      };
}
