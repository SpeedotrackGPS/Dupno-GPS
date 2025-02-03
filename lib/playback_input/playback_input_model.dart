import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'playback_input_widget.dart' show PlaybackInputWidget;
import 'package:flutter/material.dart';

class PlaybackInputModel extends FlutterFlowModel<PlaybackInputWidget> {
  ///  Local state fields for this page.

  dynamic selectedDevice;

  String? startDate;

  String? endDate;

  String minStopDuration = '1';

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  DateTime? datePicked1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  DateTime? datePicked2;
  DateTime? datePicked3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
