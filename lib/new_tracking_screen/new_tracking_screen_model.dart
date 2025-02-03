import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'new_tracking_screen_widget.dart' show NewTrackingScreenWidget;
import 'package:flutter/material.dart';

class NewTrackingScreenModel extends FlutterFlowModel<NewTrackingScreenWidget> {
  ///  Local state fields for this page.

  bool isLoadingGeneralInfo = true;

  dynamic liveVehicleTrackingData;

  bool showCard = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (deviceGeneralInfo)] action in New_Tracking_Screen widget.
  ApiCallResponse? vehicleGeneralInfoRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
