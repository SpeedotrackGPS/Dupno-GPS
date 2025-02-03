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

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animated_marker/flutter_map_animated_marker.dart';
import 'package:latlong2/latlong.dart' as coord;
import 'dart:async';
import 'dart:math';
import 'package:flutter_map_animations/flutter_map_animations.dart' as anm;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PlaybackFlutterMap extends StatefulWidget {
  const PlaybackFlutterMap({
    super.key,
    this.width,
    this.height,
    required this.historyData,
    required this.stopsData,
  });

  final double? width;
  final double? height;
  final dynamic historyData;
  final dynamic stopsData;

  @override
  State<PlaybackFlutterMap> createState() => _PlaybackFlutterMapState();
}

class _PlaybackFlutterMapState extends State<PlaybackFlutterMap>
    with TickerProviderStateMixin {
  List<coord.LatLng> polyline = [];
  List<coord.LatLng> stopsArr = [];
  double currentLat = 0.0;
  double currentLng = 0.0;
  String currentDate = '';
  double currentAngle = 0;
  double prevAngle = 0;
  int currentSpeed = 0;
  int i = 0;
  int currentPlaybackIndex = 0;
  String initialAngle = '0';
  bool isPaused = false;
  int playbackSpeed = 1;
  int durationTime = 1000;
  bool isAngleDevice = true;
  String mapType = 'm';
  bool showStops = true;
  bool toggleMap = true;
  bool isInitial = true;

  late MapController mapController;
  late final _animatedMapController = anm.AnimatedMapController(
    vsync: this,
    duration: Duration(milliseconds: durationTime),
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();
    for (int j = 0; j < widget.historyData.length; j++) {
      setState(() {
        polyline.add(coord.LatLng(double.parse(widget.historyData[j][1]),
            double.parse(widget.historyData[j][2])));
      });
    }

    final bounds = calculateBounds(polyline);

    // Animate the map to fit the bounds
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _animatedMapController.fitBounds(bounds,
    //       options: FitBoundsOptions(
    //         padding: EdgeInsets.all(50), // Add some padding around the edges
    //       ));
    // });

    bool checkAngle() {
      for (int k = 0; k < min(50, widget.historyData.length); k++) {
        if (widget.historyData[k][3] != '0') {
          return true;
        }
      }
      return false;
    }

    if (widget.stopsData.length > 0) {
      for (int l = 0; l < widget.stopsData.length; l++) {
        setState(() {
          stopsArr.add(coord.LatLng(
            double.parse(widget.stopsData[l]['lat']),
            double.parse(widget.stopsData[l]['lng']),
          ));
        });
      }
    }
    print(widget.historyData[0]);
    setState(() {
      currentLat = double.parse(widget.historyData[0][1]);
      currentLng = double.parse(widget.historyData[0][2]);
      currentDate = widget.historyData[0][0];
      initialAngle = widget.historyData[0][3];
      isAngleDevice = checkAngle();
      currentAngle = double.parse(widget.historyData[0][4]);
    });

    // function for playing history data.....
    Future<void> playHistory() async {
      while (i < widget.historyData.length) {
        setState(() {
          prevAngle = currentAngle;
        });

        if (isInitial == true && i > 1) {
          setState(() {
            isInitial = false;
          });
        }

        await Future.delayed(Duration(
            milliseconds: playbackSpeed == 1
                ? 1000
                : playbackSpeed == 2
                    ? 500
                    : 300));

        if (isPaused) continue;

        if (i < widget.historyData.length) {
          setState(() {
            currentLat = double.parse(widget.historyData[i][1]);
            currentLng = double.parse(widget.historyData[i][2]);
            currentAngle = double.parse(widget.historyData[i][4]);
            currentDate = widget.historyData[i][0];
            currentSpeed = widget.historyData[i][5];
            i = i + 1;
          });

          if (isInitial == true) {
            _animatedMapController.centerOnPoint(
                // coord.LatLng(double.parse(widget.historyData[i][1]),
                //     double.parse(widget.historyData[i][2])),
                getCenter(calculateBounds(polyline)),
                zoom: calculateZoomLevel(
                    calculateBounds(polyline),
                    MediaQuery.of(context).size.width - 45,
                    MediaQuery.of(context).size.height - 350));
          }
          // _animatedMapController
          //     .animatedRotateTo(max(0, currentAngle) * pi / 180);
        } else {
          break; // Exit loop if index is out of bounds
        }
      }
    }

    playHistory();
  }

  LatLngBounds calculateBounds(List<coord.LatLng> points) {
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      coord.LatLng(minLat, minLng),
      coord.LatLng(maxLat, maxLng),
    );
  }

  coord.LatLng getCenter(LatLngBounds bounds) {
    double lat = (bounds.southWest!.latitude + bounds.northEast!.latitude) / 2;
    double lng =
        (bounds.southWest!.longitude + bounds.northEast!.longitude) / 2;
    return coord.LatLng(lat, lng);
  }

  double calculateZoomLevel(
      LatLngBounds bounds, double mapWidth, double mapHeight) {
    const double worldWidth =
        256.0; // Width of the world at zoom level 0 in pixels
    const double maxZoom = 18.0; // Maximum zoom level for your map

    double latFraction =
        (bounds.northEast!.latitude - bounds.southWest!.latitude) / 360.0;
    double lngFraction =
        (bounds.northEast!.longitude - bounds.southWest!.longitude) / 360.0;

    double latZoom = log(mapHeight / worldWidth / latFraction) / log(2);
    double lngZoom = log(mapWidth / worldWidth / lngFraction) / log(2);

    return min(min(latZoom, lngZoom), maxZoom);
  }

  // void fitBoundsWithAnimation(List<coord.LatLng> points) {
  //   final bounds = calculateBounds(points);
  //   final center = getCenter(bounds);
  //
  //   // Assuming your map widget width and height
  //   final double mapWidth = 400; // Replace with your actual map width
  //   final double mapHeight = 600; // Replace with your actual map height
  //
  //   final zoomLevel = calculateZoomLevel(bounds, mapWidth, mapHeight);
  //
  //   _animatedMapController.animatedMapMove(center, zoomLevel);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              center: coord.LatLng(currentLat, currentLng),
              zoom: 8,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate: toggleMap
                    ? 'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i{z}!2i{x}!3i{y}!4i256!2m3!1e0!2sm!3i702451461!3m12!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!5m2!1e3!5f2'
                    : 'https://maps.googleapis.com/maps/vt?lyrs=y&x={x}&y={y}&z={z}&key=AIzaSyDfcYU0Ay95IlAyQtEXn_EJMo88dOlZFXM',
                userAgentPackageName: 'com.speedotrack.app',
              ),

              PolylineLayer(
                polylines: [
                  Polyline(
                      points: polyline, color: Colors.blue, strokeWidth: 5.2)
                ],
              ),
              showStops == true && stopsArr.length > 0
                  ? MarkerLayer(
                      markers: stopsArr
                          .asMap()
                          .entries
                          .map(
                            (entry) => Marker(
                              point: entry.value,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  (entry.key + 1).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : MarkerLayer(
                      markers: [],
                    ),

              //animated marker layer starts here...

              // AnimatedMarkerLayer(
              //   options: AnimatedMarkerLayerOptions(
              //     duration: Duration(
              //       seconds: 2,
              //     ),
              //     marker: Marker(
              //       height: 60,
              //       width: 60,
              //       point: coord.LatLng(currentLat, currentLng),
              //       child: Container(
              //           width: 40,
              //           height: 40,
              //           child: Column(
              //             children: [
              //               Image.network(
              //                 "https://speedotrack.in/img/markers/pointer.png",
              //                 height: 40,
              //                 width: 40,
              //               ),
              //             ],
              //           )),
              //     ),
              //   ),
              //         ),

              //new marker layer without animation here..

              MarkerLayer(
                markers: [
                  Marker(
                    height: 60,
                    width: 60,
                    point: coord.LatLng(currentLat, currentLng),
                    child: Container(
                        width: 40,
                        height: 40,
                        child: Column(
                          children: [
                            Image.network(
                              "https://speedotrack.in/img/markers/pointer.png",
                              height: 40,
                              width: 40,
                            ),
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          showStops = !showStops;
                        });
                      },
                      child: Icon(
                        Icons.stop,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    FloatingActionButton.small(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          // if (mapType == 'm') {
                          //   mapType = 'y';
                          // } else {
                          //   mapType = 'm';
                          // }
                          toggleMap = !toggleMap;
                        });
                      },
                      child: Icon(
                        Icons.map,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 180,
              child: Column(children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(140),
                        topRight: Radius.circular(140)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 150,
                          radiusFactor: 0.9, // Adjusts the size of the gauge
                          showLabels:
                              false, // Removes the minimum and maximum text
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: currentSpeed.toDouble(),
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength:
                                  0.6, // Adjusts the length of the needle
                              needleStartWidth: 1,
                              needleEndWidth: 3,
                              knobStyle: KnobStyle(
                                sizeUnit: GaugeSizeUnit.logicalPixel,
                                knobRadius:
                                    4, // Adjusts the size of the knob at the center
                              ),
                            ),
                          ],
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 120,
                              color: Colors.black,
                              startWidth: 5,
                              endWidth: 5,
                            ),
                            GaugeRange(
                              startValue: 120,
                              endValue: 160,
                              color: Colors.red,
                              startWidth: 5,
                              endWidth: 5,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Container(
                                child: Text(
                                  '${currentSpeed.toDouble()} km/h',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12))),
                  height: 80,
                  child: Column(children: [
                    Row(children: [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        flex: 4,
                        child: Slider(
                          value: i.toDouble(),
                          max: widget.historyData.length.toDouble(),
                          divisions: widget.historyData.length,
                          onChanged: (double value) {
                            setState(() {
                              i = value.toInt();
                              if (i < widget.historyData.length) {
                                currentLat =
                                    double.parse(widget.historyData[i][1]);
                                currentLng =
                                    double.parse(widget.historyData[i][2]);
                                currentAngle =
                                    double.parse(widget.historyData[i][4]);
                                currentDate = widget.historyData[i][0];
                                currentSpeed = widget.historyData[i][5];
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPaused = !isPaused;
                            });
                          },
                          child: Container(
                            child: isPaused
                                ? Icon(
                                    Icons.play_arrow,
                                    color: Colors.blue,
                                  )
                                : Icon(
                                    Icons.pause,
                                    color: Colors.red,
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (playbackSpeed == 1) {
                              setState(() {
                                playbackSpeed = 2;
                              });
                            } else if (playbackSpeed == 2) {
                              setState(() {
                                playbackSpeed = 3;
                              });
                            } else {
                              setState(() {
                                playbackSpeed = 1;
                              });
                            }
                          },
                          child: Container(
                            child: Text(playbackSpeed == 1
                                ? '1x'
                                : playbackSpeed == 2
                                    ? '2x'
                                    : '3x'),
                          ),
                        ),
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/performance.png',
                                width: 30.0,
                                height: 30.0,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '${currentSpeed.toString()}',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 18)),
                                  TextSpan(
                                      text: 'Km/h',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12)),
                                ]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/8044031.png',
                                width: 30.0,
                                height: 30.0,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                currentDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
