import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'update_engine_modal_widget.dart' show UpdateEngineModalWidget;
import 'package:flutter/material.dart';

class UpdateEngineModalModel extends FlutterFlowModel<UpdateEngineModalWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Update Engine Hour)] action in Button widget.
  ApiCallResponse? updateEngineHourRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
