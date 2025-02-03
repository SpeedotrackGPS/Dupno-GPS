import '/flutter_flow/flutter_flow_util.dart';
import 'update_odometer_modals_widget.dart' show UpdateOdometerModalsWidget;
import 'package:flutter/material.dart';

class UpdateOdometerModalsModel
    extends FlutterFlowModel<UpdateOdometerModalsWidget> {
  ///  State fields for stateful widgets in this component.

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
