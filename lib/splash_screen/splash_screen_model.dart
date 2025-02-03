import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'splash_screen_widget.dart' show SplashScreenWidget;
import 'package:flutter/material.dart';

class SplashScreenModel extends FlutterFlowModel<SplashScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (fn Connect LOGIN TRACKING Api)] action in splashScreen widget.
  ApiCallResponse? checkProperLogin;
  // Stores action output result for [Backend Call - API (test large device)] action in splashScreen widget.
  ApiCallResponse? initialDeviceDataRes;
  bool loginbio = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
