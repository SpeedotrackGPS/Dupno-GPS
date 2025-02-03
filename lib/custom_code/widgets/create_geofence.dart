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
import 'package:geolocator/geolocator.dart';

class CreateGeofence extends StatefulWidget {
  const CreateGeofence({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CreateGeofence> createState() => _CreateGeofenceState();
}

class _CreateGeofenceState extends State<CreateGeofence> {
  static const gm.CameraPosition _kGooglePlex = gm.CameraPosition(
    target: gm.LatLng(0.0, 0.0), // Sample coordinates
    zoom: 2,
  );

  final List<gm.LatLng> _points = [];
  gm.LatLng markerPoint = gm.LatLng(0, 0);
  final Completer<gm.GoogleMapController> _controller =
      Completer<gm.GoogleMapController>();

  Future<Position?> _getCurrentLocation() async {
    // Check and request permission
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied.")),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Location permissions are permanently denied.")),
      );
      return null;
    }

    try {
      // Fetch the current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: $e")),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: gm.GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (gm.GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            gm.Marker(
              markerId: gm.MarkerId('your_marker_id'),
              position: markerPoint,
              icon: gm.BitmapDescriptor.defaultMarkerWithHue(
                  gm.BitmapDescriptor.hueRed),
            ),
          },
          onTap: (gm.LatLng latLng) {
            setState(() {
              _points.add(latLng);
              markerPoint = latLng;
            });
          },
          polygons: {
            if (_points.isNotEmpty)
              gm.Polygon(
                polygonId: const gm.PolygonId('geofence'),
                points: _points,
                strokeWidth: 2,
                fillColor: Colors.blue.withOpacity(0.2),
                strokeColor: Colors.blue,
              ),
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          FloatingActionButton(
            heroTag: 'currentLocation',
            child: const Icon(Icons.my_location),
            onPressed: () async {
              final position = await _getCurrentLocation();
              if (position != null) {
                final controller = await _controller.future;
                controller.animateCamera(
                  gm.CameraUpdate.newCameraPosition(
                    gm.CameraPosition(
                      target: gm.LatLng(position.latitude, position.longitude),
                      zoom: 15,
                    ),
                  ),
                );
                setState(() {
                  markerPoint =
                      gm.LatLng(position.latitude, position.longitude);
                });
              }
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'finalizeGeofence',
            child: const Icon(Icons.check),
            onPressed: () {
              setState(() {
                FFAppState().createGeofenceVertices =
                    convertLatLngListToString(_points);
              });
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'clearGeofence',
            child: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _points.clear();
                FFAppState().createGeofenceVertices = "";
              });
            },
          ),
        ],
      ),
    );
  }

  String convertLatLngListToString(List<gm.LatLng> latLngList) {
    if (latLngList.isEmpty) {
      return '';
    }
    return latLngList
        .map((latLng) => '${latLng.latitude},${latLng.longitude}')
        .join(',');
  }
}
