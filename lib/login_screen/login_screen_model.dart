import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_screen_widget.dart' show LoginScreenWidget;
import 'package:flutter/material.dart';

class LoginScreenModel extends FlutterFlowModel<LoginScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (fn Connect LOGIN TRACKING Api)] action in Button widget.
  ApiCallResponse? loginApiRes;
  // Stores action output result for [Backend Call - API (Php Get User API key)] action in Button widget.
  ApiCallResponse? getApiKeyRes;
  bool loginbiometric = false;
  // Stores action output result for [Backend Call - API (fn Connect LOGIN TRACKING Api)] action in Icon widget.
  ApiCallResponse? loginApiResb;
  // Stores action output result for [Backend Call - API (Php Get User API key)] action in Icon widget.
  ApiCallResponse? getApiKeyResb;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
