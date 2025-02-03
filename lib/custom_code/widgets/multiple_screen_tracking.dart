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

import 'index.dart'; // Imports other custom widgets

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as coord;
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MultipleScreenTracking extends StatefulWidget {
  MultipleScreenTracking({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
  dynamic deviceListData;

  @override
  State<MultipleScreenTracking> createState() => _MultipleScreenTrackingState();
}

class _MultipleScreenTrackingState extends State<MultipleScreenTracking> {
  late Timer _timer;
  bool enableClustering = true;
  String mapType = 'm';
  bool showTooltip = true;
  bool switchMap = true;
  late final MapController _mapController;
  int renderCount = 0;
  bool hasBoundsFitted = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      updateDeviceList();
    });
  }

  void updateDeviceList() {
    setState(() {
      widget.deviceListData = FFAppState().allDeviceData?['result'];
    });
    if (widget.deviceListData != null &&
        widget.deviceListData.isNotEmpty &&
        !hasBoundsFitted) {
      _fitMapToBounds();
    }
    print(jsonEncode(widget.deviceListData));
  }

  void _fitMapToBounds() {
    List<coord.LatLng> allPoints = widget.deviceListData
            ?.map<coord.LatLng>(
              (vehicle) => coord.LatLng(
                double.parse(vehicle?['lat'] ?? '0'),
                double.parse(vehicle?['lng'] ?? '0'),
              ),
            )
            .toList() ??
        [];

    if (allPoints.isNotEmpty) {
      var latitudes = allPoints.map((point) => point.latitude);
      var longitudes = allPoints.map((point) => point.longitude);

      var southWest =
          coord.LatLng(latitudes.reduce(min), longitudes.reduce(min));
      var northEast =
          coord.LatLng(latitudes.reduce(max), longitudes.reduce(max));

      LatLngBounds bounds = LatLngBounds(southWest, northEast);

      _mapController.fitBounds(bounds,
          options: FitBoundsOptions(
            padding: EdgeInsets.all(100),
            maxZoom: 16,
          ));

      // Set the flag to true to prevent further calls
      hasBoundsFitted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: coord.LatLng(
              double.parse(
                  FFAppState().allDeviceData?['result'][0]['lat'] ?? '0'),
              double.parse(
                  FFAppState().allDeviceData?['result'][0]['lng'] ?? '0'),
            ),
            zoom: 3,
            maxZoom: 20,
            minZoom: 4,
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          ),
          children: [
            TileLayer(
              urlTemplate: switchMap
                  ? 'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i{z}!2i{x}!3i{y}!4i256!2m3!1e0!2sm!3i702451461!3m12!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!5m2!1e3!5f2'
                  : 'https://maps.googleapis.com/maps/vt?lyrs=y&x={x}&y={y}&z={z}&key=AIzaSyDfcYU0Ay95IlAyQtEXn_EJMo88dOlZFXM',
              userAgentPackageName: 'com.speedotrack.app',
            ),
            enableClustering
                ? MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      markers: widget.deviceListData
                              ?.map((vehicle) => Marker(
                                  height: 95,
                                  width: 150,
                                  point: coord.LatLng(
                                      double.parse(vehicle?['lat'] ?? '0'),
                                      double.parse(vehicle?['lng'] ?? '0')),
                                  child: GestureDetector(
                                      onTap: () async {
                                        context.pushNamed(
                                          'New_Tracking_Screen',
                                          queryParameters: {
                                            'singleDeviceData': serializeParam(
                                              vehicle,
                                              ParamType.JSON,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                          child: Column(
                                        children: [
                                          showTooltip
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      vehicle?['name']
                                                              .toString() ??
                                                          'Vehicle Name',
                                                      style: TextStyle(
                                                        color: vehicle?['st']
                                                                    .toString() ==
                                                                "Engine idle"
                                                            ? Colors.yellow
                                                            : vehicle?['st']
                                                                        .toString() ==
                                                                    "Stopped"
                                                                ? Colors.red
                                                                : vehicle?['st']
                                                                            .toString() ==
                                                                        "Moving"
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .black,
                                                      ),
                                                    ),
                                                  ))
                                              : Container(),
                                          SizedBox(height: 1),
                                          Transform.rotate(
                                            angle: max(
                                                    0,
                                                    double.parse(
                                                            vehicle?['angle'] ??
                                                                '0')
                                                        .toDouble()) *
                                                pi /
                                                180,
                                            child: Image.network(
                                              vehicle?['icon'] ??
                                                  'https://speedotrack.in/img/markers/m_5_.png',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ],
                                      )))))
                              .toList()
                              .cast<Marker>() ??
                          [],
                      builder: (context, markers) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              markers.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : MarkerLayer(
                    markers: widget.deviceListData
                            ?.map((vehicle) => Marker(
                                height: 80,
                                width: 120,
                                point: coord.LatLng(
                                    double.parse(vehicle?['lat'] ?? '0'),
                                    double.parse(vehicle?['lng'] ?? '0')),
                                child: Container(
                                    child: Column(
                                  children: [
                                    showTooltip
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                vehicle?['name'].toString() ??
                                                    'Vehicle Name',
                                                style: TextStyle(
                                                  color: vehicle?['st']
                                                              .toString() ==
                                                          "Engine idle"
                                                      ? Colors.yellow
                                                      : vehicle?['st']
                                                                  .toString() ==
                                                              "Stopped"
                                                          ? Colors.red
                                                          : vehicle?['st']
                                                                      .toString() ==
                                                                  "Moving"
                                                              ? Colors.green
                                                              : Colors.black,
                                                ),
                                              ),
                                            ))
                                        : Container(),
                                    SizedBox(height: 1),
                                    Transform.rotate(
                                      angle: max(
                                              0,
                                              double.parse(
                                                      vehicle?['angle'] ?? '0')
                                                  .toDouble()) *
                                          pi /
                                          180,
                                      child: Image.network(
                                        vehicle?['icon'] ??
                                            'https://speedotrack.in/img/markers/m_5_.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  ],
                                ))))
                            .toList()
                            .cast<Marker>() ??
                        [],
                  )
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        enableClustering = !enableClustering;
                      });
                    },
                    child: Icon(
                      Icons.streetview,
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
                        switchMap = !switchMap;
                      });
                    },
                    child: Icon(Icons.map, color: Colors.grey),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
