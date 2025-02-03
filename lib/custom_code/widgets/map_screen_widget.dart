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

import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMapFunc;
import 'package:intl/intl.dart';

class MapScreenWidget extends StatefulWidget {
  Map<String, dynamic> jsonData;
  double? width;
  double? height;
  MapScreenWidget({required this.jsonData, this.width, this.height});
  @override
  State<MapScreenWidget> createState() => _MapScreenWidgetState();
}

class _MapScreenWidgetState extends State<MapScreenWidget> {
  LocationModel locationJsonData = LocationModel();
  List<RouteInfo> routeInfo = [];
  double _value = 0.0;
  bool showStopMarker = false;
  bool showEventMarker = false;
  // Map initialization
  GoogleMapFunc.MapType _currentMapType = GoogleMapFunc.MapType.normal;
  Completer<GoogleMapFunc.GoogleMapController> _controller = Completer();
  late GoogleMapFunc.GoogleMapController _mapController;
  late List<GoogleMapFunc.LatLng> _routeCoordinates;
  late final Map<GoogleMapFunc.MarkerId, GoogleMapFunc.Marker> _markers = Map();
  int _currentRouteIndex = 0;
  bool _isMoving = false;
  double _speed = 1.0; // Initial speed
  late GoogleMapFunc.Polyline _polyline;
  late Timer _timer;
  GoogleMapFunc.LatLng? _lastMarkerPosition;

  bool isLoadingData = false;
  bool isErrorLoadingData = false;
  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playback"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoadingData
            ? const Center(child: CircularProgressIndicator())
            : isErrorLoadingData
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Error occur while loading data, Please try again.",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Standard Text Widget
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 10, top: 10),
              child: Text(
                "Standard",
                style: TextStyle(fontSize: 16.0),
              ),
            ),

            // List of Horizontal Scroll Containers of Texts
            if (routeInfo.isNotEmpty) routeListWidget(),
            Expanded(
              child: Container(color: Colors.white, child: mapWidget()),
            ),
          ],
        ),
        draggableBottomSheet(),
      ],
    );
  }

// widgets
  Widget mapWidget() {
    return Stack(
      children: [
        GoogleMapFunc.GoogleMap(
          mapType: _currentMapType,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.175,
          ),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: GoogleMapFunc.CameraPosition(
            target: _routeCoordinates.first,
            zoom: 14,
          ),
          markers: Set<GoogleMapFunc.Marker>.of(_markers.values),
          polylines: Set.of([_polyline]),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _changeMapType();
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(0, 100, 8, 0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/map.png"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showStopMarker = !showStopMarker;
                  });
                  if (showStopMarker) {
                    _addStopMarkersIcons();
                  } else {
                    _removeStopMarkersIcons();
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/stop.png"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showEventMarker = !showEventMarker;
                  });
                  if (showEventMarker) {
                    _addEventMarkersIcons();
                  } else {
                    _removeEventMarkersIcons();
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/events.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  DraggableScrollableSheet draggableBottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            locationJsonData.route![_value.toInt()][5]
                                .toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff388d42)),
                          ),
                          const Positioned(
                            bottom: 10,
                            right: -25,
                            child: Text(
                              'kph',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff388d42)),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('HH:mm:ss').format(DateTime.parse(
                            locationJsonData.route![_value.toInt()][0]
                                .toString())),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.parse(
                            locationJsonData.route![_value.toInt()][0]
                                .toString())),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 20,
                      height: 60,
                      child: VerticalDivider(
                        color: Colors.grey,
                        width: 0.4,
                      )),
                  InkWell(
                    onTap: () => _moveMarker(),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !_isMoving ? Colors.green : Colors.red),
                      child: Icon(!_isMoving ? Icons.play_arrow : Icons.pause,
                          color: Colors.white),
                    ),
                  ),
                  if (locationJsonData.route != null &&
                      locationJsonData.route!.isNotEmpty)
                    Slider(
                      inactiveColor: Colors.red.shade50,
                      activeColor: Colors.red,
                      min: 0.0,
                      max: locationJsonData.route!.length - 1.toDouble(),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          if (locationJsonData.route!.length - 1 == value) {
                            _isMoving = false;
                          }
                          _currentRouteIndex = value.toInt();
                          _value = value;
                        });
                      },
                    ),
                  InkWell(
                    onTap: () {
                      if (_speed != 4) {
                        _speed++;
                      } else {
                        _speed = 1;
                      }
                      setState(() {});
                      _moveSpeedMarker();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.redAccent.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 2),
                        child: Text(
                          "${_speed.round()}X",
                          style: const TextStyle(
                              color: Colors.purpleAccent, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: locationJsonData.drives!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Drive driveData = locationJsonData.drives![index];
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 20 : 0.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ],
                              )),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat("dd-MMM-yyyy  hh:mm:ss a")
                                          .format(driveData.dtStart!),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            driveData.routeLength!
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            driveData.duration!,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd-MMM-yyyy  hh:mm:ss a")
                                          .format(driveData.dtEnd!),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                            child: Divider(),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget routeListWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(routeInfo.length, (index) {
          var routeData = routeInfo[index];
          final Color randomColor =
              itemColors[Random().nextInt(itemColors.length)];

          return Container(
            margin: const EdgeInsets.only(right: 4.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            decoration: BoxDecoration(
                color: randomColor, borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: [
                Text(
                  routeData.title,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  routeData.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // map functions

  void _loadMarkerIcons() async {
    try {
      final startIcon = await getStartImage();
      final destinationIcon = await getDestinationImage();
      final movingIcon = await getMovingMarkerImage();

      setState(() {
        _markers[GoogleMapFunc.MarkerId('startMarker')] = GoogleMapFunc.Marker(
          markerId: GoogleMapFunc.MarkerId('startMarker'),
          position: _routeCoordinates.first,
          icon: startIcon,
        );

        _markers[GoogleMapFunc.MarkerId('destinationMarker')] =
            GoogleMapFunc.Marker(
          markerId: GoogleMapFunc.MarkerId('destinationMarker'),
          position: _routeCoordinates.last,
          icon: destinationIcon,
        );

        _markers[GoogleMapFunc.MarkerId('movingMarker')] = GoogleMapFunc.Marker(
            markerId: GoogleMapFunc.MarkerId('movingMarker'),
            position: _routeCoordinates.first,
            icon: movingIcon);
      });
    } catch (error) {
      print("Error loading marker icons: $error");
    }
  }

  Future<GoogleMapFunc.BitmapDescriptor> getDestinationImage() async {
    return await GoogleMapFunc.BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/images/destination.png',
    );
  }

  Future<GoogleMapFunc.BitmapDescriptor> getStartImage() async {
    return await GoogleMapFunc.BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/images/start.png',
    );
  }

  Future<GoogleMapFunc.BitmapDescriptor> getStopImage() async {
    return await GoogleMapFunc.BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/images/stop.png',
    );
  }

  Future<GoogleMapFunc.BitmapDescriptor> getEventsImage() async {
    return await GoogleMapFunc.BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/images/events.png',
    );
  }

  Future<GoogleMapFunc.BitmapDescriptor> getMovingMarkerImage() async {
    return await GoogleMapFunc.BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/images/cursor.png',
    );
  }

  void _addStopMarkersIcons() async {
    try {
      final stopIcon = await getStopImage();
      for (var stopLatLng in locationJsonData.stops!) {
        setState(() {
          GoogleMapFunc.MarkerId markerId =
              GoogleMapFunc.MarkerId("stopIcon_${stopLatLng.idStart}");

          _markers[GoogleMapFunc.MarkerId("stopIcon_${stopLatLng.idStart}")] =
              GoogleMapFunc.Marker(
            onTap: () {
              if (markerId.value.contains("stopIcon_")) {
                List<String> splitList = markerId.value.split("stopIcon_");
                Stop stopElement = locationJsonData.stops!
                    .where((stopElement) =>
                        stopElement.idStart.toString() == splitList[1])
                    .first;
                showStopAlertWindow(stopElement);
              }
            },
            markerId: markerId,
            position: GoogleMapFunc.LatLng(
                double.parse(stopLatLng.lat!), double.parse(stopLatLng.lng!)),
            icon: stopIcon,
          );
        });
      }
    } catch (error) {
      print("Error loading marker icons: $error");
    }
  }

  void _removeStopMarkersIcons() async {
    try {
      for (var stopLatLng in locationJsonData.stops!) {
        setState(() {
          _markers
              .remove(GoogleMapFunc.MarkerId("stopIcon_${stopLatLng.idStart}"));
        });
      }
    } catch (error) {
      print("Error loading marker icons: $error");
    }
  }

  void _addEventMarkersIcons() async {
    try {
      final stopIcon = await getEventsImage();
      for (var stopLatLng in locationJsonData.events!) {
        setState(() {
          GoogleMapFunc.MarkerId markerId =
              GoogleMapFunc.MarkerId("eventIcon_${stopLatLng.lat}");

          _markers[GoogleMapFunc.MarkerId("eventIcon_${stopLatLng.lat}")] =
              GoogleMapFunc.Marker(
            onTap: () {
              if (markerId.value.contains("eventIcon_")) {
                List<String> splitList = markerId.value.split("eventIcon_");
                Event stopElement = locationJsonData.events!
                    .where((stopElement) =>
                        stopElement.lat.toString() == splitList[1])
                    .first;
                showEventAlertWindow(stopElement);
              }
            },
            markerId: markerId,
            position: GoogleMapFunc.LatLng(
                double.parse(stopLatLng.lat!), double.parse(stopLatLng.lng!)),
            icon: stopIcon,
          );
        });
      }
    } catch (error) {
      print("Error loading marker icons: $error");
    }
  }

  void _removeEventMarkersIcons() async {
    try {
      for (var stopLatLng in locationJsonData.events!) {
        setState(() {
          _markers
              .remove(GoogleMapFunc.MarkerId("eventIcon_${stopLatLng.lat}"));
        });
      }
    } catch (error) {
      print("Error loading marker icons: $error");
    }
  }

  void _onMapCreated(GoogleMapFunc.GoogleMapController controller) {
    _controller.complete(controller);
    _mapController = controller;
  }

  void _moveMarker() async {
    final movingIcon = await getMovingMarkerImage();
    if (_isMoving) {
      _timer.cancel();
      setState(() {
        _isMoving = false;
        _lastMarkerPosition = _markers[GoogleMapFunc.MarkerId('movingMarker')]!
            .position; // Update last marker position when movement is stopped
      });
    } else {
      setState(() {
        _isMoving = true;
      });

      _timer = Timer.periodic(Duration(milliseconds: 300 ~/ _speed), (timer) {
        _value = _currentRouteIndex.toDouble();
        GoogleMapFunc.LatLng start = _routeCoordinates[_currentRouteIndex];
        GoogleMapFunc.LatLng end = _routeCoordinates[_currentRouteIndex + 1];

        double distance = _calculateDistance(
            start.latitude, start.longitude, end.latitude, end.longitude);
        double durationInSeconds = distance /
            (_speed); // Adjust speed factor here  distance / (_speed *50 );

        setState(() {
          double t = timer.tick / (durationInSeconds * 60);
          if (_lastMarkerPosition != null) {
            t = min(t, 1.0);
            double lat = _lastMarkerPosition!.latitude +
                (end.latitude - _lastMarkerPosition!.latitude) * t;
            double lng = _lastMarkerPosition!.longitude +
                (end.longitude - _lastMarkerPosition!.longitude) * t;
            _markers[GoogleMapFunc.MarkerId('movingMarker')] =
                GoogleMapFunc.Marker(
                    rotation: double.parse(
                        locationJsonData.route![_currentRouteIndex][4]),
                    markerId: GoogleMapFunc.MarkerId('movingMarker'),
                    position: GoogleMapFunc.LatLng(lat, lng),
                    icon: movingIcon);
          } else {
            _markers[GoogleMapFunc.MarkerId('movingMarker')] =
                GoogleMapFunc.Marker(
              markerId: GoogleMapFunc.MarkerId('movingMarker'),
              icon: movingIcon,
              rotation: double.parse(
                  locationJsonData.route![_currentRouteIndex][4].toString()),
              position: GoogleMapFunc.LatLng(
                lerpDouble(start.latitude, end.latitude, t)!,
                lerpDouble(start.longitude, end.longitude, t)!,
              ),
            );
          }
        });

        if (timer.tick >= durationInSeconds * 60) {
          _currentRouteIndex++;
          if (_currentRouteIndex >= _routeCoordinates.length - 1) {
            _timer.cancel();
            setState(() {
              _isMoving = false;
            });
          }
          _lastMarkerPosition =
              _markers[GoogleMapFunc.MarkerId('movingMarker')]!.position;
        }
      });
    }
  }

  void _moveSpeedMarker() async {
    final movingIcon = await getMovingMarkerImage();
    setState(() {
      _timer.cancel();
    });
    _timer = Timer.periodic(Duration(milliseconds: 300 ~/ _speed), (timer) {
      _value = _currentRouteIndex.toDouble();
      GoogleMapFunc.LatLng start = _routeCoordinates[_currentRouteIndex];
      GoogleMapFunc.LatLng end = _routeCoordinates[_currentRouteIndex + 1];

      double distance = _calculateDistance(
          start.latitude, start.longitude, end.latitude, end.longitude);
      double durationInSeconds = distance /
          (_speed); // Adjust speed factor here  distance / (_speed *50 );

      setState(() {
        double t = timer.tick / (durationInSeconds * 60);
        if (_lastMarkerPosition != null) {
          t = min(t, 1.0);
          double lat = _lastMarkerPosition!.latitude +
              (end.latitude - _lastMarkerPosition!.latitude) * t;
          double lng = _lastMarkerPosition!.longitude +
              (end.longitude - _lastMarkerPosition!.longitude) * t;
          _markers[GoogleMapFunc.MarkerId('movingMarker')] = GoogleMapFunc.Marker(
              // rotation:  locationJsonData.route![_currentRouteIndex][5]!=null|| locationJsonData.route![_currentRouteIndex][5]!=0?double.parse(
              //     locationJsonData.route![_currentRouteIndex][5]):45.0,
              markerId: GoogleMapFunc.MarkerId('movingMarker'),
              position: GoogleMapFunc.LatLng(lat, lng),
              icon: movingIcon);
        } else {
          _markers[GoogleMapFunc.MarkerId('movingMarker')] =
              GoogleMapFunc.Marker(
            markerId: GoogleMapFunc.MarkerId('movingMarker'),
            icon: movingIcon,
            position: GoogleMapFunc.LatLng(
              lerpDouble(start.latitude, end.latitude, t)!,
              lerpDouble(start.longitude, end.longitude, t)!,
            ),
          );
        }
      });

      if (timer.tick >= durationInSeconds * 60) {
        _currentRouteIndex++;
        if (_currentRouteIndex >= _routeCoordinates.length - 1) {
          _timer.cancel();
          setState(() {
            _isMoving = false;
          });
        }
        _lastMarkerPosition =
            _markers[GoogleMapFunc.MarkerId('movingMarker')]!.position;
      }
    });
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == GoogleMapFunc.MapType.normal
          ? GoogleMapFunc.MapType.satellite
          : GoogleMapFunc.MapType.normal;
    });
  }

  showStopAlertWindow(Stop stopElement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleText("Position", "${stopElement.lat}, ${stopElement.lng}"),
              titleText("Angle", "${stopElement.angle}"),
              titleText("Came", "${stopElement.dtStart}"),
              titleText("Left", "${stopElement.dtEnd}"),
              titleText("Duration", "${stopElement.duration}"),
            ],
          ),
        );
      },
    );
  }

  showEventAlertWindow(Event stopElement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              titleText("Position", "${stopElement.lat}, ${stopElement.lng}"),
              titleText("Angle", "${stopElement.angle}"),
              titleText("Came", "${stopElement.dtTracker}"),
              titleText("Engine Status", "${stopElement.eventDesc}"),
              titleText("Altitude", "${stopElement.altitude}"),
              titleText("Speed", "${stopElement.speed}"),
            ],
          ),
        );
      },
    );
  }

  titleText(String title, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(flex: 2, child: Text(value))
        ]),
      );
  List<GoogleMapFunc.LatLng> getRoutePoints() {
    List<GoogleMapFunc.LatLng> latLongs = [];
    for (var latLng in locationJsonData.route!) {
      latLongs.add(GoogleMapFunc.LatLng(
          double.parse(latLng[1]), double.parse(latLng[2])));
    }
    return latLongs;
  }

  String removeJsonAndArray(String text) {
    if (text.startsWith('[') || text.startsWith('{')) {
      text = text.substring(1, text.length - 1);
      if (text.startsWith('[') || text.startsWith('{')) {
        text = removeJsonAndArray(text);
      }
    }
    return text;
  }

  getDataFromAPI() async {
    var data = json.encode(widget.jsonData);
    print("data received ${json.encode(widget.jsonData)}");
    locationJsonData = LocationModel.fromJson(jsonDecode(data));
    await getLocationInfo(locationJsonData);
    _loadMarkerIcons();
    _routeCoordinates = getRoutePoints();
    setState(() {});
    _polyline = GoogleMapFunc.Polyline(
      polylineId: GoogleMapFunc.PolylineId('route'),
      color: Colors.red,
      width: 2,
      points: _routeCoordinates,
    );
    setState(() {
      isLoadingData = false;
    });
    _moveMarker();
  }

  getLocationInfo(LocationModel locationJsonData) {
    routeInfo = <RouteInfo>[
      RouteInfo(
          title: 'Route Length',
          value: "${locationJsonData.routeLength!.toStringAsFixed(2)} km"),
      RouteInfo(
          title: 'Top Speed',
          value: "${locationJsonData.topSpeed.toString()} kph"),
      RouteInfo(
          title: 'Fuel Consumption',
          value: locationJsonData.fuelConsumption!.toStringAsFixed(2)),
      RouteInfo(
          title: 'Fuel Cost',
          value: locationJsonData.fuelCost!.toStringAsFixed(2)),
      RouteInfo(
          title: 'Stops Duration', value: locationJsonData.stopsDuration ?? ''),
      RouteInfo(
          title: 'Drives Duration',
          value: locationJsonData.drivesDuration ?? ''),
      RouteInfo(
          title: 'Average Speed',
          value: "${locationJsonData.avgSpeed.toString()} kph"),
      RouteInfo(
          title: 'Engine Work Time',
          value: locationJsonData.engineWorkTime.toString() + ' s'),
      RouteInfo(
          title: 'Engine Idle Time',
          value: '${locationJsonData.engineIdleTime} s'),
      RouteInfo(
          title: 'Fuel Consumption per 100km',
          value: locationJsonData.fuelConsumptionPer100Km.toString()),
      RouteInfo(
          title: 'Fuel Consumption (MPG)',
          value: locationJsonData.fuelConsumptionMpg.toString()),
    ];
  }
}

// CONSTANT & MODELS
const List<Color> itemColors = [
  Color(0xFFE4F2FD),
  Color(0xFFE8F5EB),
  Color(0xFFE2F6FC),
  Color(0xFFFFECEE),
  Color(0xFFDFF8FA),
];

class RouteInfo {
  final String title;
  final String value;

  RouteInfo({required this.title, required this.value});
}

// MAIN API MODEL
class LocationModel {
  List<List<dynamic>>? route;
  List<Stop>? stops;
  List<Drive>? drives;
  List<Event>? events;
  double? routeLength;
  int? topSpeed;
  double? fuelConsumption;
  double? fuelCost;
  int? stopsDurationTime;
  String? stopsDuration;
  int? drivesDurationTime;
  String? drivesDuration;
  int? avgSpeed;
  int? engineWorkTime;
  int? engineIdleTime;
  dynamic engineWork;
  dynamic engineIdle;
  double? fuelConsumptionPer100Km;
  double? fuelConsumptionMpg;

  LocationModel({
    this.route,
    this.stops,
    this.drives,
    this.events,
    this.routeLength,
    this.topSpeed,
    this.fuelConsumption,
    this.fuelCost,
    this.stopsDurationTime,
    this.stopsDuration,
    this.drivesDurationTime,
    this.drivesDuration,
    this.avgSpeed,
    this.engineWorkTime,
    this.engineIdleTime,
    this.engineWork,
    this.engineIdle,
    this.fuelConsumptionPer100Km,
    this.fuelConsumptionMpg,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        route: json["route"] == null
            ? []
            : List<List<dynamic>>.from(
                json["route"]!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        stops: json["stops"] == null
            ? []
            : List<Stop>.from(json["stops"]!.map((x) => Stop.fromJson(x))),
        drives: json["drives"] == null
            ? []
            : List<Drive>.from(json["drives"]!.map((x) => Drive.fromJson(x))),
        events: json["events"] == null
            ? []
            : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
        routeLength: json["route_length"]?.toDouble(),
        topSpeed: json["top_speed"],
        fuelConsumption: json["fuel_consumption"]?.toDouble(),
        fuelCost: json["fuel_cost"]?.toDouble(),
        stopsDurationTime: json["stops_duration_time"],
        stopsDuration: json["stops_duration"],
        drivesDurationTime: json["drives_duration_time"],
        drivesDuration: json["drives_duration"],
        avgSpeed: json["avg_speed"],
        engineWorkTime: json["engine_work_time"],
        engineIdleTime: json["engine_idle_time"],
        engineWork: json["engine_work"] ?? "",
        engineIdle: json["engine_idle"] ?? "",
        fuelConsumptionPer100Km: json["fuel_consumption_per_100km"]?.toDouble(),
        fuelConsumptionMpg: json["fuel_consumption_mpg"]?.toDouble(),
      );
}

class Drive {
  int? idStartS;
  int? idStart;
  int? idEnd;
  DateTime? dtStartS;
  DateTime? dtStart;
  DateTime? dtEnd;
  String? duration;
  double? routeLength;
  int? topSpeed;
  int? avgSpeed;
  double? fuelConsumption;
  double? fuelCost;
  dynamic engineWork;
  double? fuelConsumptionPer100Km;
  double? fuelConsumptionMpg;

  Drive({
    this.idStartS,
    this.idStart,
    this.idEnd,
    this.dtStartS,
    this.dtStart,
    this.dtEnd,
    this.duration,
    this.routeLength,
    this.topSpeed,
    this.avgSpeed,
    this.fuelConsumption,
    this.fuelCost,
    this.engineWork,
    this.fuelConsumptionPer100Km,
    this.fuelConsumptionMpg,
  });

  factory Drive.fromJson(Map<String, dynamic> json) => Drive(
        idStartS: json["id_start_s"],
        idStart: json["id_start"],
        idEnd: json["id_end"],
        dtStartS: json["dt_start_s"] == null
            ? null
            : DateTime.parse(json["dt_start_s"]),
        dtStart:
            json["dt_start"] == null ? null : DateTime.parse(json["dt_start"]),
        dtEnd: json["dt_end"] == null ? null : DateTime.parse(json["dt_end"]),
        duration: json["duration"],
        routeLength: json["route_length"]?.toDouble(),
        topSpeed: json["top_speed"],
        avgSpeed: json["avg_speed"],
        fuelConsumption: json["fuel_consumption"]?.toDouble(),
        fuelCost: json["fuel_cost"]?.toDouble(),
        engineWork: json["engine_work"],
        fuelConsumptionPer100Km: json["fuel_consumption_per_100km"]?.toDouble(),
        fuelConsumptionMpg: json["fuel_consumption_mpg"]?.toDouble(),
      );
}

class RouteClass {
  String? gpslev;
  String? io239;
  String? io240;
  String? io200;
  String? io1;
  String? io179;
  String? io175;
  String? io236;
  String? io252;
  String? io253;
  String? io66;
  String? io24;
  String? io67;
  String? io9;
  String? io199;
  String? io16;
  String? io247;
  String? io246;
  String? gsmlev;
  String? io254;
  String? io21;

  RouteClass({
    this.gpslev,
    this.io239,
    this.io240,
    this.io200,
    this.io1,
    this.io179,
    this.io175,
    this.io236,
    this.io252,
    this.io253,
    this.io66,
    this.io24,
    this.io67,
    this.io9,
    this.io199,
    this.io16,
    this.io247,
    this.io246,
    this.gsmlev,
    this.io254,
    this.io21,
  });

  factory RouteClass.fromJson(Map<String, dynamic> json) => RouteClass(
        gpslev: json["gpslev"],
        io239: json["io239"],
        io240: json["io240"],
        io200: json["io200"],
        io1: json["io1"],
        io179: json["io179"],
        io175: json["io175"],
        io236: json["io236"],
        io252: json["io252"],
        io253: json["io253"],
        io66: json["io66"],
        io24: json["io24"],
        io67: json["io67"],
        io9: json["io9"],
        io199: json["io199"],
        io16: json["io16"],
        io247: json["io247"],
        io246: json["io246"],
        gsmlev: json["gsmlev"],
        io254: json["io254"],
        io21: json["io21"],
      );
}

class Stop {
  int? idStart;
  int? idEnd;
  String? lat;
  String? lng;
  String? altitude;
  String? angle;
  int? speed;
  DateTime? dtStart;
  DateTime? dtEnd;
  String? duration;
  double? fuelConsumption;
  double? fuelCost;
  dynamic engineIdle;
  RouteClass? params;

  Stop({
    this.idStart,
    this.idEnd,
    this.lat,
    this.lng,
    this.altitude,
    this.angle,
    this.speed,
    this.dtStart,
    this.dtEnd,
    this.duration,
    this.fuelConsumption,
    this.fuelCost,
    this.engineIdle,
    this.params,
  });

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
        idStart: json["id_start"],
        idEnd: json["id_end"],
        lat: json["lat"],
        lng: json["lng"],
        altitude: json["altitude"],
        angle: json["angle"],
        speed: json["speed"],
        dtStart:
            json["dt_start"] == null ? null : DateTime.parse(json["dt_start"]),
        dtEnd: json["dt_end"] == null ? null : DateTime.parse(json["dt_end"]),
        duration: json["duration"],
        fuelConsumption: json["fuel_consumption"]?.toDouble(),
        fuelCost: json["fuel_cost"]?.toDouble(),
        engineIdle: json["engine_idle"] != null ? json["engine_idle"]! : null,
        params:
            json["params"] == null ? null : RouteClass.fromJson(json["params"]),
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Event {
  dynamic eventDesc;
  DateTime? dtTracker;
  String? lat;
  String? lng;
  String? altitude;
  String? angle;
  int? speed;
  Params? params;

  Event({
    this.eventDesc,
    this.dtTracker,
    this.lat,
    this.lng,
    this.altitude,
    this.angle,
    this.speed,
    this.params,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventDesc: eventDescValues.map[json["event_desc"]] != null
            ? eventDescValues.map[json["event_desc"]]
            : "",
        dtTracker: json["dt_tracker"] == null
            ? null
            : DateTime.parse(json["dt_tracker"]),
        lat: json["lat"],
        lng: json["lng"],
        altitude: json["altitude"],
        angle: json["angle"],
        speed: json["speed"],
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
      );
}

class Params {
  String? gpslev;
  String? mcc;
  String? mnc;
  String? lac;
  String? cellid;
  String? acc;
  String? alarm;
  String? pump;
  String? track;
  String? bats;
  String? defense;
  String? batl;
  String? accv;
  String? iccid;
  String? defence;
  String? gsmlev;

  Params({
    this.gpslev,
    this.mcc,
    this.mnc,
    this.lac,
    this.cellid,
    this.acc,
    this.alarm,
    this.pump,
    this.track,
    this.bats,
    this.defense,
    this.batl,
    this.accv,
    this.iccid,
    this.defence,
    this.gsmlev,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        gpslev: json["gpslev"],
        mcc: json["mcc"],
        mnc: json["mnc"],
        lac: json["lac"],
        cellid: json["cellid"],
        acc: json["acc"],
        alarm: json["alarm"],
        pump: json["pump"],
        track: json["track"],
        bats: json["bats"],
        defense: json["defense"],
        batl: json["batl"],
        accv: json["accv"],
        iccid: json["iccid"],
        defence: json["defence"],
        gsmlev: json["gsmlev"],
      );
}

final eventDescValues = EnumValues(
    {"Engine Off": EventDesc.ENGINE_OFF, "Engine On": EventDesc.ENGINE_ON});

enum EventDesc { ENGINE_OFF, ENGINE_ON }
