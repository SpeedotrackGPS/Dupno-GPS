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

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as coord;
import 'package:flutter_map_animated_marker/flutter_map_animated_marker.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart' as anm;
import 'dart:async';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapWidget extends StatefulWidget {
  FlutterMapWidget({
    super.key,
    this.width,
    this.height,
    required this.selectedDeviceImei,
  });

  final double? width;
  final double? height;
  final String selectedDeviceImei;
  late Timer timer;

  @override
  State<FlutterMapWidget> createState() => _FlutterMapWidgetState();
}

class _FlutterMapWidgetState extends State<FlutterMapWidget>
    with TickerProviderStateMixin {
  late Timer _timer;
  var deviceData;
  List<coord.LatLng> tailData = [];
  dynamic animatedAngle = 0.0;
  String mapType = 'm';
  bool showRoute = true;
  bool switchMap = true;
  String renderMapType = 'roadmap';
  late anm.AnimatedMapController _animatedMapController;

  @override
  void initState() {
    super.initState();

    _animatedMapController = anm.AnimatedMapController(
      vsync: this,
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOut,
    );

    deviceData = FFAppState()
        .allDeviceData?['result']
        .where((device) => device?['imei'] == widget.selectedDeviceImei)
        .toList();

    void refreshData() {
      deviceData = FFAppState()
          .allDeviceData?['result']
          .where((device) => device?['imei'] == widget.selectedDeviceImei)
          .toList();
      setState(
        () {
          tailData.add(coord.LatLng(
            double.parse(deviceData?[0]['lat'] ?? '0'),
            double.parse(deviceData?[0]['lng'] ?? '0'),
          ));
          if (tailData.length > 7) {
            tailData.removeAt(0);
          }
          animatedAngle = deviceData?[0]['angle'];
        },
      );

      _animatedMapController.centerOnPoint(
        coord.LatLng(
          double.parse(deviceData?[0]['lat'] ?? '0'),
          double.parse(deviceData?[0]['lng'] ?? '0'),
        ),
        zoom: _animatedMapController.mapController.zoom,
      );
      _animatedMapController.animatedRotateTo(
          max(0, double.parse(deviceData?[0]['angle'] ?? '0').toDouble()) *
              pi /
              180);
    }

    _timer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        refreshData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            center: coord.LatLng(
              double.parse(deviceData?[0]['lat'] ?? '0'),
              double.parse(deviceData?[0]['lng'] ?? '0'),
            ),
            zoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate: renderMapType == 'roadmap'
                  ? 'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i{z}!2i{x}!3i{y}!4i256!2m3!1e0!2sm!3i702451461!3m12!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!5m2!1e3!5f2'
                  : renderMapType == 'hybrid'
                      ? 'https://maps.googleapis.com/maps/vt?lyrs=y,&x={x}&y={y}&z={z}&key=AIzaSyDfcYU0Ay95IlAyQtEXn_EJMo88dOlZFXM'
                      : 'https://maps.googleapis.com/maps/vt?lyrs=m,traffic&x={x}&y={y}&z={z}&key=AIzaSyDfcYU0Ay95IlAyQtEXn_EJMo88dOlZFXM',
              userAgentPackageName: 'com.edusoft.app',
            ),
            FFAppState().showRouteOnTracking
                ? PolylineLayer(polylines: [
                    Polyline(
                        points: tailData.length > 1
                            ? tailData.sublist(0, tailData.length - 1)
                            : tailData,
                        color: Colors.red,
                        strokeWidth: 5)
                  ])
                : Container(),
            AnimatedMarkerLayer(
              options: AnimatedMarkerLayerOptions(
                duration: Duration(seconds: 10),
                marker: Marker(
                  height: 40,
                  width: 40,
                  point: coord.LatLng(
                    double.parse(deviceData?[0]['lat'] ?? '0'),
                    double.parse(deviceData?[0]['lng'] ?? '0'),
                  ),
                  child: Transform.rotate(
                    angle: max(
                            0,
                            double.parse(deviceData?[0]['angle'] ?? '0')
                                .toDouble()) *
                        pi /
                        180,
                    child: Image.network(
                      deviceData?[0]['icon'] ??
                          'https://speedotrack.in/img/markers/m_5_.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (renderMapType != 'roadmap') {
                          renderMapType = 'roadmap';
                        } else {
                          renderMapType = 'hybrid';
                        }
                      });
                    },
                    child: Icon(
                      Icons.map,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        FFAppState().showRouteOnTracking =
                            !FFAppState().showRouteOnTracking;
                      });
                    },
                    child: Icon(
                      Icons.route,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      launchGoogleMaps(double.parse(deviceData[0]['lat']),
                          double.parse(deviceData[0]['lng']));
                    },
                    child: Icon(
                      Icons.control_point,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      launchGoogleMapsStreetView(
                          double.parse(deviceData[0]['lat']),
                          double.parse(deviceData[0]['lng']));
                    },
                    child: Icon(
                      Icons.streetview,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        launchGoogleMapsDirections(
                            double.parse(deviceData[0]['lat']),
                            double.parse(deviceData[0]['lng']));
                      },
                      child: Icon(
                        Icons.directions,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor:
                        renderMapType == 'traffic' ? Colors.blue : Colors.white,
                    onPressed: () {
                      setState(() {
                        renderMapType = 'traffic';
                      });
                    },
                    child: Icon(
                      Icons.traffic,
                      color: renderMapType == 'traffic'
                          ? Colors.white
                          : Colors.grey,
                      size: 20,
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

launchGoogleMaps(double lat, double lng) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchGoogleMapsStreetView(double lat, double lng) async {
  final url =
      'https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=$lat,$lng';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchGoogleMapsDirections(double lat, double lng) async {
  final url =
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
