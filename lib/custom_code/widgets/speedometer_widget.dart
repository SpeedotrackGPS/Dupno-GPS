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

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

class SpeedometerWidget extends StatefulWidget {
  const SpeedometerWidget({
    super.key,
    this.width,
    this.height,
    required this.deviceImei,
  });

  final double? width;
  final double? height;
  final String deviceImei;

  @override
  State<SpeedometerWidget> createState() => _SpeedometerWidgetState();
}

class _SpeedometerWidgetState extends State<SpeedometerWidget> {
  late Timer _timer;
  late double _speed;

  @override
  void initState() {
    super.initState();
    _fetchSpeedData();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _fetchSpeedData();
    });
  }

  void _fetchSpeedData() {
    final selectedDeviceArr = FFAppState()
        .allDeviceData?['result']
        .where((device) => device?['imei'] == widget.deviceImei)
        .toList();
    final selectedDevice = selectedDeviceArr[0];
    int deviceSpeed = selectedDevice['speed'];
    double deviceSpeedDbl = deviceSpeed.toDouble();
    setState(() {
      _speed = deviceSpeedDbl;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 130,
      height: widget.height ?? 80,
      alignment: Alignment.bottomCenter,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 150,
            radiusFactor: 0.8, // Adjusts the size of the gauge
            showLabels: false, // Removes the minimum and maximum text
            pointers: <GaugePointer>[
              NeedlePointer(
                value: _speed,
                lengthUnit: GaugeSizeUnit.factor,
                needleLength: 0.6, // Adjusts the length of the needle
                needleStartWidth: 1,
                needleEndWidth: 3,
                knobStyle: KnobStyle(
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                  knobRadius: 4, // Adjusts the size of the knob at the center
                ),
              ),
            ],
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 50,
                color: Colors.green,
                startWidth: 5,
                endWidth: 5,
              ),
              GaugeRange(
                startValue: 50,
                endValue: 100,
                color: Colors.orange,
                startWidth: 5,
                endWidth: 5,
              ),
              GaugeRange(
                startValue: 100,
                endValue: 150,
                color: Colors.red,
                startWidth: 5,
                endWidth: 5,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Text(
                    '${_speed} km/h',
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
    );
  }
}
