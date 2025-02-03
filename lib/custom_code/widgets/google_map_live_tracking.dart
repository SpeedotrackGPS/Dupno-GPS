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

import '/flutter_flow/flutter_flow_theme.dart'; //

import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapLiveTracking extends StatefulWidget {
  const GoogleMapLiveTracking({
    super.key,
    this.width,
    this.height,
    required this.selectedDeviceImei,
  });

  final double? width;
  final double? height;
  final String selectedDeviceImei;

  @override
  State<GoogleMapLiveTracking> createState() => _GoogleMapLiveTrackingState();
}

class _GoogleMapLiveTrackingState extends State<GoogleMapLiveTracking> {
  Timer? _timer;
  bool switchMap = false;
  bool trafficEnabled = false;
  bool _initialZoomSet = false;
  bool angleSlow = false;

  final Completer<gm.GoogleMapController> _controller =
      Completer<gm.GoogleMapController>();

  static const gm.CameraPosition _kGooglePlex = gm.CameraPosition(
    target: gm.LatLng(0.0, 0.0),
    zoom: 1,
  );

  late gm.BitmapDescriptor customIcon;
  List<gm.LatLng> _pointsList = [];
  List<gm.LatLng> _polylinePoints = [];
  var deviceData;
  String? previousImageUrl = '';

  List<gm.Marker> _markers = [];
  Uint8List resizeImageMarker = Uint8List(0);

  @override
  void initState() {
    super.initState();

    deviceData = FFAppState()
        .allDeviceData?['result']
        .where((device) => device?['imei'] == widget.selectedDeviceImei)
        .toList();

    makeApiCall();

    _timer = Timer.periodic(
        Duration(milliseconds: 10000), (Timer t) => makeApiCall());
  }

  Future<void> makeApiCall() async {
    print('function called');
    deviceData = FFAppState()
        .allDeviceData?['result']
        .where((device) => device?['imei'] == widget.selectedDeviceImei)
        .toList();
    print(deviceData.toString());

    if (deviceData != null && deviceData.isNotEmpty) {
      final newImageUrl = deviceData[0]['icon'];
      final newPosition = gm.LatLng(
        double.parse(deviceData[0]['lat']),
        double.parse(deviceData[0]['lng']),
      );

      // Only process the image if the URL has changed
      if (previousImageUrl != newImageUrl) {
        await processNewImage(newImageUrl);
        previousImageUrl = newImageUrl;
      }

      // Update the marker's position regardless of image update
      setState(() {
        _markers = [
          gm.Marker(
            markerId: gm.MarkerId(deviceData[0]['imei']),
            position: newPosition,
            icon: gm.BitmapDescriptor.fromBytes(resizeImageMarker),
            rotation: double.parse(deviceData[0]['angle']) ?? 0.0,
            infoWindow: gm.InfoWindow(
              title: deviceData[0]['name'],
            ),
          )
        ];
      });

      print('marker set');

      final controller = await _controller.future;

      controller.animateCamera(
        gm.CameraUpdate.newLatLngZoom(newPosition, 15),
      );

      setState(() {
        angleSlow = true;
      });
    }
  }

  Future<void> processNewImage(String newImageUrl) async {
    Uint8List? image = await loadNetworkImage(newImageUrl);
    if (image != null) {
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        resizeImageMarker = byteData.buffer.asUint8List();
      }
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    print('load network image called.');
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Animarker(
          curve: Curves.linear,
          useRotation: true,
          angleThreshold: 1,
          zoom: 20,
          isActiveTrip: true,
          shouldAnimateCamera: false,
          mapId: _controller.future.then<int>((value) => value.mapId),
          markers: Set<gm.Marker>.of(_markers),
          duration: Duration(milliseconds: 10000),
          child: gm.GoogleMap(
            mapType: switchMap ? gm.MapType.hybrid : gm.MapType.normal,
            trafficEnabled: trafficEnabled,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (gm.GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: {
              gm.Polyline(
                polylineId: gm.PolylineId('my_polyline'),
                points: _polylinePoints.length > 1
                    ? _polylinePoints.sublist(0, _polylinePoints.length - 1)
                    : _polylinePoints,
                color: Colors.blue,
                width: 5,
              )
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 58.0,
            left: 8,
          ),
          child: Container(
            child: Column(
              children: [
                FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      switchMap = !switchMap;
                    });
                  },
                  child: Icon(
                    Icons.map,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      trafficEnabled = !trafficEnabled;
                    });
                  },
                  child: Icon(
                    Icons.traffic,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FloatingActionButton.small(
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
                SizedBox(
                  height: 12,
                ),
                FloatingActionButton.small(
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
                FloatingActionButton.small(
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
                )
              ],
            ),
          ),
        )
      ],
    ));
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
