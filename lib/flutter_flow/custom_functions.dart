import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/custom_auth/auth_util.dart';

List<LatLng>? returnLatLngArray(
  List<String> latArray,
  List<String> lngArray,
) {
  List<LatLng> latLngList = [];

  // Ensure both lists have the same length
  if (latArray.length == lngArray.length) {
    // Iterate over the lists and combine latitude and longitude
    for (int i = 0; i < latArray.length; i++) {
      double lat = double.tryParse(latArray[i]) ?? 0.0;
      double lng = double.tryParse(lngArray[i]) ?? 0.0;

      latLngList.add(LatLng(lat, lng));
    }
  }

  return latLngList;
}

String? seperateUnlockCommandFromString(String? deviceModelCommand) {
  if (deviceModelCommand == null) {
    return null;
  }
  final List<String> commands = deviceModelCommand.split('@');
  if (commands.length != 2) {
    return null;
  }
  return commands[1];
}

LatLng? returnLatLngDataType(
  String? lat,
  String? lng,
) {
  // return LatLng data type
  if (lat != null && lng != null) {
    final latitude = double.tryParse(lat);
    final longitude = double.tryParse(lng);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
  }
  return null;
}

List<dynamic> returnFilteredDeviceListOnStatus(
  String? filterStatus,
  List<dynamic> deviceList,
  String? searchValue,
  bool? isOnline,
  bool? isOffline,
  bool? isExpired,
) {
  if (filterStatus == 'All') {
    // return all device filter on search
    if (searchValue == null || searchValue == '') {
      return deviceList;
    } else {
      return deviceList
          .where((device) =>
              device['name'].toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    }
  } else {
    if (isExpired == true) {
      final filteredList = deviceList.where((device) {
        return device['active'] == 'false';
      }).toList();
      return filteredList;
    }
    if (isOnline == true) {
      final filteredList =
          deviceList.where((device) => device['st'] != "Offline").toList();
      return filteredList;
    }
    //for filter with the status value
    final filteredList =
        deviceList.where((device) => device['st'] == filterStatus).toList();

    if (searchValue == null || searchValue == '') {
      return filteredList;
    } else {
      return filteredList
          .where((device) => device['name'].contains(searchValue))
          .toList();
    }
  }
}

String? getTommorowDate() {
  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(tomorrow);
}

String? getCurrentDate() {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  String formattedDate = DateFormat('yyyy-MM-dd 00:00:00').format(today);
  return formattedDate;
}

List<dynamic>? returnFilteredEventsDevices(
  String deviceImei,
  List<dynamic> eventsList,
) {
  final filteredEvents =
      eventsList.where((event) => event[2] == deviceImei).toList();
  return filteredEvents;
}

String? seperateLockCommandFromString(String? deviceModelCommand) {
  if (deviceModelCommand == null) {
    return null;
  }
  final List<String> commands = deviceModelCommand.split('@');
  if (commands.length != 2) {
    return null;
  }
  return commands[0];
}

List<dynamic> findSpecficVehicleWithImei(
  dynamic allDeviceList,
  String vehicleImeiToFind,
) {
  return allDeviceList
      .where((device) => device['imei'] == vehicleImeiToFind)
      .toList();
}

String convertArrayToString(List<String> selectedDeviceList) {
  return selectedDeviceList.join(',');
}

String returnTommorowDate() {
  // return tommorow date as string
  final now = DateTime.now();
  final tomorrow = now.add(Duration(days: 1));
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(tomorrow);
}

String? returnCurrentDate() {
  // return date of today as string
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(now);
}

String? returnYesterdayDate() {
  // return date of yesterday as string
  final now = DateTime.now();
  final yesterday = now.subtract(Duration(days: 1));
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(yesterday);
}

String? returnTwoDaysBefore() {
  // return date of two days before as string
  final now = DateTime.now();
  final twoDaysBefore = now.subtract(Duration(days: 2));
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(twoDaysBefore);
}

String? returnThisWeek() {
  // return the starting date of this week as string
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(startOfWeek);
}

String? returnLastWeek() {
  // retur first date of last week as string
  final now = DateTime.now();
  final lastWeek = now.subtract(Duration(days: 7));
  final firstDateOfLastWeek =
      lastWeek.subtract(Duration(days: lastWeek.weekday - 1));
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(firstDateOfLastWeek);
}

String? returnThisMonth() {
  // return first date of this month as string
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  String formattedDate =
      DateFormat('yyyy-MM-dd 00:00:00').format(firstDayOfMonth);
  return formattedDate;
}

String? returnLastMonth() {
  // return first date ofa lasta month as string
  final now = DateTime.now();
  final lastMonth = DateTime(now.year, now.month - 1, 1);
  final formatter = DateFormat('yyyy-MM-dd 00:00:00');
  return formatter.format(lastMonth);
}

String vechileImage(
  String? status,
  int? vechileId,
) {
  /// vechileIs = 1 => Car
  /// vechileIs = 2 => Truck
  /// vechileIs = 3 => Bike

  if (vechileId == 1) {
    if (status == "Moving") {
      return "assets/images/car_g.png";
    } else if (status == "Stopped") {
      return "assets/images/car_r.png";
    } else {
      return "assets/images/car_y.png";
    }
  } else if (vechileId == 2) {
    if (status == "Moving") {
      return "assets/images/truck_g.png";
    } else if (status == "Stopped") {
      return "assets/images/truck_r.png";
    } else {
      return "assets/images/truck_y.png";
    }
  } else {
    if (status == "Moving") {
      return "assets/images/bike_g.png";
    } else if (status == "Stopped") {
      return "assets/images/bike_r.png";
    } else {
      return "assets/images/bike_y.png";
    }
  }
}

bool containsAtSymbol(String command) {
  // return true if the string contains @
  bool containsAtSymbol = command.contains('@');
  return containsAtSymbol;
}

String returnGoogleMapTile(
  String zoomLevel,
  String latValue,
  String lonValue,
) {
  double latitude = double.parse(latValue);
  double longitude = double.parse(lonValue);

  final int fixedZoomLevel = int.parse(zoomLevel); // Use provided zoom level

  // Error handling (optional)
  if (fixedZoomLevel < 0 ||
      fixedZoomLevel > 21 ||
      latitude < -90 ||
      latitude > 90 ||
      longitude < -180 ||
      longitude > 180) {
    return "Invalid input values";
  }

  final tileX =
      (longitude + 180.0) / 360.0 * math.pow(2.0, fixedZoomLevel.floor());
  final tileY = (1 -
          math.log(math.tan(latitude * math.pi / 180.0) +
                  1 / math.cos(latitude * math.pi / 180.0)) /
              math.pi) /
      2.0 *
      math.pow(2.0, fixedZoomLevel.floor());

  // Construct the updated tile URL with {x}, {y}, {z} replaced
  final url =
      "https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i${fixedZoomLevel.floor()}!2i${tileX.floor()}!3i${tileY.floor()}!4i256!2m3!1e0!2sm!3i702451461!3m12!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!5m2!1e3!5f2";

  return url;
}

int retunArrayLength(List<dynamic> array) {
  // return the length of the list
  return array.length;
}

String? returnOsmTile(
  String latVal,
  String lonVal,
  String zoomVal,
) {
  final latRad = double.parse(latVal) * math.pi / 180;
  final n = math.pow(2.0, int.parse(zoomVal));
  final xTile = ((double.parse(lonVal) + 180.0) / 360.0 * n).floor();
  final yTile =
      ((1.0 - math.log(math.tan(latRad) + (1 / math.cos(latRad))) / math.pi) /
              2.0 *
              n)
          .floor();

  return "https://tile.openstreetmap.org/${zoomVal}/${xTile}/${yTile}.png";
//
}

String returnGoogleMapNavigateLink(
  String lat,
  String lng,
) {
  return "https://www.google.com/maps/search/?api=1&query=${lat},${lng}";
}

int returnTextLength(String textForLength) {
  // return length of the text
  return textForLength.length;
}

bool checkTextLength(int lengthOfTheText) {
  // return true if lenghtOfTheText is greater then 20
  return lengthOfTheText > 10;
}

String? uppercaseToLowerCase(String? loginID) {
  // write a program to take text input in mix upper case and lower case and return to lower cast string
  if (loginID == null) {
    return null;
  }
  return loginID.toLowerCase();
}

List<dynamic> convertJsonTypeToList(dynamic objectDataType) {
  if (objectDataType is Map<String, dynamic>) {
    List<Map<String, dynamic>> convertedList = [];

    objectDataType.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        convertedList.add(value);
      }
    });

    return convertedList;
  }

  return [];
}

List<String> addStringToArray(
  List<String> existingArray,
  String dataToAdd,
) {
  existingArray.add(dataToAdd);

  return existingArray;
}

List<String> removeStringFromArray(
  List<String> existingArray,
  String stringToRemove,
) {
  existingArray.remove(stringToRemove);

  return existingArray;
}

List<dynamic> returnExpiringDevices(dynamic allDeviceListData) {
  // List to store the devices expiring within 7 days
  List<dynamic> expiringDevices = [];

  // Get the current date
  DateTime now = DateTime.now();

  // Iterate through all device data
  for (var device in allDeviceListData) {
    // Parse the expiration date from the device data
    DateTime expirationDate =
        DateFormat("yyyy-MM-dd").parse(device['object_expire_dt']);

    // Calculate the number of days between now and the expiration date
    int daysToExpire = expirationDate.difference(now).inDays;

    // Check if the device expires within the next 7 days (inclusive)
    if (daysToExpire >= 0 && daysToExpire <= 4) {
      expiringDevices.add(device);
    }
  }

  return expiringDevices;
}

String returnNextDay(DateTime? currentDate) {
  // take the date and return next day in string format yyyy-mm-dd-00:00:00
  if (currentDate == null) {
    return '';
  }

  final nextDay = currentDate.add(Duration(days: 1));
  final formattedDate = DateFormat('yyyy-MM-dd').format(nextDay);

  return '$formattedDate-00:00:00';
}
