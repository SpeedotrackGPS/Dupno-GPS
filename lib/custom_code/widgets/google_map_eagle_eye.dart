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

import 'dart:async';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'dart:ui' as ui;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';

class GoogleMapEagleEye extends StatefulWidget {
  const GoogleMapEagleEye({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<GoogleMapEagleEye> createState() => _GoogleMapEagleEyeState();
}

class _GoogleMapEagleEyeState extends State<GoogleMapEagleEye> {
  dynamic? deviceListData;
  bool trafficEnabled = false;
  bool switchMap = false;
  bool clusteringEnabled = true;
  late Timer _timer;
  late ClusterManager<Place> _manager;

  final Completer<gm.GoogleMapController> _controller =
      Completer<gm.GoogleMapController>();

  static const gm.CameraPosition _kGooglePlex = gm.CameraPosition(
    target: gm.LatLng(0.0, 0.0),
    zoom: 1,
  );

  Set<gm.Marker> _markers = {};
  List<gm.LatLng> _pointsList = [];

  @override
  void initState() {
    super.initState();
    _initializeClusterManager();
    _updateIcons();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _updateIcons();
    });
    _setVehicles();
  }

  void _initializeClusterManager() {
    _manager = ClusterManager<Place>(
      [],
      _updateMarkers,
      markerBuilder: _markerBuilder,
      levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0],
      extraPercent: 0.2,
      stopClusteringZoom: 17.0,
    );
  }

  Future<void> _setVehicles() async {
    if (_pointsList.isNotEmpty) {
      gm.LatLngBounds bounds = _calculateBounds(_pointsList);
      final controller = await _controller.future;
      controller.animateCamera(gm.CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  Future<void> _updateIcons() async {
    final resData = FFAppState().allDeviceData;

    List<gm.LatLng> pointsList = [];
    _pointsList.clear();

    List<Place> places = [];

    for (int i = 0; i < resData['result'].length; i++) {
      final deviceItem = resData['result'][i];
      final latLng = gm.LatLng(
          double.parse(deviceItem['lat']), double.parse(deviceItem['lng']));
      _pointsList.add(latLng);
      pointsList.add(latLng);
      places.add(Place(name: deviceItem['name'], latLng: latLng));
    }

    setState(() {
      _manager.setItems(places);
    });
  }

  gm.LatLngBounds _calculateBounds(List<gm.LatLng> points) {
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

  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<gm.Marker> _markerBuilder(Cluster<Place> cluster) async {
    return gm.Marker(
      markerId: gm.MarkerId(cluster.getId()),
      position: cluster.location,
      onTap: () {
        print(cluster.items);
      },
      icon: await _getClusterBitmap(
        cluster.isMultiple ? 125 : 75,
        text: cluster.isMultiple ? cluster.count.toString() : null,
      ),
    );
  }

  Future<gm.BitmapDescriptor> _getClusterBitmap(int size,
      {String? text}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.red;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return gm.BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void _updateMarkers(Set<gm.Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }

  Future<gm.BitmapDescriptor> _getMarkerIcon(String url) async {
    final Uint8List? markerImage = await _loadNetworkImage(url);
    return gm.BitmapDescriptor.fromBytes(markerImage!);
  }

  void _toggleClustering() {
    setState(() {
      if (clusteringEnabled) {
        _manager.setItems(_manager.items.toList());
      } else {
        _updateIcons(); // Call _updateIcons to refresh the markers with images
      }

      clusteringEnabled = !clusteringEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          gm.GoogleMap(
            mapType: switchMap ? gm.MapType.hybrid : gm.MapType.normal,
            trafficEnabled: trafficEnabled,
            initialCameraPosition: _kGooglePlex,
            markers: Set<gm.Marker>.of(_markers),
            onMapCreated: (gm.GoogleMapController controller) {
              _controller.complete(controller);
              _manager.setMapId(controller.mapId);
            },
            onCameraMove: _manager.onCameraMove,
            onCameraIdle: _manager.updateMap,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 158.0, left: 8),
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      switchMap = !switchMap;
                    });
                  },
                  child: Icon(
                    Icons.map,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                SizedBox(height: 12),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      trafficEnabled = !trafficEnabled;
                    });
                  },
                  child: Icon(
                    Icons.traffic,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                SizedBox(height: 12),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _toggleClustering,
                  child: Icon(
                    Icons.layers,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Place with ClusterItem {
  final String name;
  final gm.LatLng latLng;

  Place({required this.name, required this.latLng});

  @override
  gm.LatLng get location => latLng;
}
