import '/flutter_flow/flutter_flow_util.dart';
import 'create_notification_widget.dart' show CreateNotificationWidget;
import 'package:flutter/material.dart';

class CreateNotificationModel
    extends FlutterFlowModel<CreateNotificationWidget> {
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
