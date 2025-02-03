import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'multiple_fleet_widget.dart' show MultipleFleetWidget;
import 'package:flutter/material.dart';

class MultipleFleetModel extends FlutterFlowModel<MultipleFleetWidget> {
  ///  Local state fields for this page.

  bool isLoadingGeneralInfo = true;

  dynamic liveVehicleTrackingData;

  bool showCard = true;

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // Stores action output result for [Backend Call - API (test large device)] action in Multiple_Fleet widget.
  ApiCallResponse? initialPeriodicMultiple;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
