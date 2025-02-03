import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'update_odometer_widget.dart' show UpdateOdometerWidget;
import 'package:flutter/material.dart';

class UpdateOdometerModel extends FlutterFlowModel<UpdateOdometerWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Update Odometer)] action in Button widget.
  ApiCallResponse? updateOdometerRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
