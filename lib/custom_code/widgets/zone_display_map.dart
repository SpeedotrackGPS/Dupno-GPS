// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'dart:async';

class ZoneDisplayMap extends StatefulWidget {
  const ZoneDisplayMap({
    super.key,
    this.width,
    this.height,
    required this.latLngString,
    required this.zoneColor,
  });

  final double? width;
  final double? height;
  final String latLngString;
  final Color zoneColor;

  @override
  State<ZoneDisplayMap> createState() => _ZoneDisplayMapState();
}

class _ZoneDisplayMapState extends State<ZoneDisplayMap> {
  final Completer<gm.GoogleMapController> _controller =
      Completer<gm.GoogleMapController>();

  List<gm.LatLng> _polygonPoints = [];

  @override
  void initState() {
    super.initState();
    _polygonPoints = convertStringToLatLng(widget.latLngString);

    setVehicles();
  }

  List<gm.LatLng> convertStringToLatLng(String latLngString) {
    final List<String> stringArr = latLngString.split(",");
    List<gm.LatLng> latLngList = [];

    for (int i = 0; i < stringArr.length; i += 2) {
      final double latitude = double.parse(stringArr[i]);
      final double longitude = double.parse(stringArr[i + 1]);
      latLngList.add(gm.LatLng(latitude, longitude));
    }

    return latLngList;
  }

  Future<void> setVehicles() async {
    if (_polygonPoints.isNotEmpty) {
      gm.LatLngBounds bounds = calculateBounds(_polygonPoints);
      final controller = await _controller.future;
      controller.animateCamera(gm.CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  gm.LatLngBounds calculateBounds(List<gm.LatLng> points) {
    double south =
        points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
    double north =
        points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    double west =
        points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
    double east =
        points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

    return gm.LatLngBounds(
      southwest: gm.LatLng(south, west),
      northeast: gm.LatLng(north, east),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: gm.GoogleMap(
        initialCameraPosition: gm.CameraPosition(
          target: _polygonPoints.isNotEmpty
              ? _polygonPoints[0]
              : gm.LatLng(0.0, 0.0),
          zoom: 18,
        ),
        onMapCreated: (gm.GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygonPoints.isNotEmpty
            ? Set<gm.Polygon>.of([
                gm.Polygon(
                  polygonId: gm.PolygonId('zone_polygon'),
                  points: _polygonPoints,
                  strokeColor: widget.zoneColor,
                  strokeWidth: 2,
                  fillColor: widget.zoneColor.withOpacity(0.2),
                ),
              ])
            : Set<gm.Polygon>(),
      ),
    );
  }
}
