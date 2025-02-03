import '/flutter_flow/flutter_flow_util.dart';
import 'engine_start_stop_widget.dart' show EngineStartStopWidget;
import 'package:flutter/material.dart';

class EngineStartStopModel extends FlutterFlowModel<EngineStartStopWidget> {
  ///  Local state fields for this page.

  dynamic vehiclesListData;

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
