import 'dart:async';

import 'package:location/location.dart';
import 'package:acra/models/user_location.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // LocationData currentLocation;
  Location location = new Location();
  UserLocation _currentlocation;

  //continuously listen to position
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    checkstorageandlocationpermissions();
  }
  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentlocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
    } catch (e) {
      print("Could not get the location error is $e");
    }
  }

  checkstorageandlocationpermissions() async {
    PermissionStatus locationpermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    PermissionStatus storagepermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (storagepermission == PermissionStatus.denied) {
      Map<PermissionGroup, PermissionStatus> getstoragepermissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      if (getstoragepermissions[PermissionGroup.storage] ==
          PermissionStatus.denied) {
        //if still denied exit app
        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        SystemNavigator.pop();
      }
    }

    if (locationpermission == PermissionStatus.denied) {
      Map<PermissionGroup, PermissionStatus> getlocationpermissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.location]);
      if (getlocationpermissions[PermissionGroup.location] ==
          PermissionStatus.denied) {
        SystemNavigator.pop();
      }
    }

    //sec level
    location.requestPermission().then((grantEd) {
      if (grantEd) {
        location.onLocationChanged().listen((locationdata) {
          if (locationdata != null) {
            _locationController.add(UserLocation(
                latitude: locationdata.latitude,
                longitude: locationdata.longitude));
          }
        });
      }
    });
  }
}
