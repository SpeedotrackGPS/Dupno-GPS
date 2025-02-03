import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_maintance_widget.dart' show AddMaintanceWidget;
import 'package:flutter/material.dart';

class AddMaintanceModel extends FlutterFlowModel<AddMaintanceWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
  // State field(s) for DataList widget.
  bool? dataListValue;
  // State field(s) for Popup widget.
  bool? popupValue;
  // State field(s) for OdometerCheck widget.
  bool? odometerCheckValue;
  // State field(s) for odometerInterval widget.
  FocusNode? odometerIntervalFocusNode;
  TextEditingController? odometerIntervalTextController;
  String? Function(BuildContext, String?)?
      odometerIntervalTextControllerValidator;
  // State field(s) for odometerLast widget.
  FocusNode? odometerLastFocusNode;
  TextEditingController? odometerLastTextController;
  String? Function(BuildContext, String?)? odometerLastTextControllerValidator;
  // State field(s) for EngineHour widget.
  bool? engineHourValue;
  // State field(s) for EngineHourInterval widget.
  FocusNode? engineHourIntervalFocusNode;
  TextEditingController? engineHourIntervalTextController;
  String? Function(BuildContext, String?)?
      engineHourIntervalTextControllerValidator;
  // State field(s) for EngineHourLast widget.
  FocusNode? engineHourLastFocusNode;
  TextEditingController? engineHourLastTextController;
  String? Function(BuildContext, String?)?
      engineHourLastTextControllerValidator;
  // State field(s) for days widget.
  bool? daysValue;
  // State field(s) for daysInterval widget.
  FocusNode? daysIntervalFocusNode;
  TextEditingController? daysIntervalTextController;
  String? Function(BuildContext, String?)? daysIntervalTextControllerValidator;
  // State field(s) for daysLast widget.
  FocusNode? daysLastFocusNode;
  TextEditingController? daysLastTextController;
  String? Function(BuildContext, String?)? daysLastTextControllerValidator;
  // State field(s) for odometerLeft widget.
  bool? odometerLeftValue;
  // State field(s) for odometerLeftNum widget.
  FocusNode? odometerLeftNumFocusNode;
  TextEditingController? odometerLeftNumTextController;
  String? Function(BuildContext, String?)?
      odometerLeftNumTextControllerValidator;
  // State field(s) for engineLeft widget.
  bool? engineLeftValue;
  // State field(s) for engineLeftNumber widget.
  FocusNode? engineLeftNumberFocusNode;
  TextEditingController? engineLeftNumberTextController;
  String? Function(BuildContext, String?)?
      engineLeftNumberTextControllerValidator;
  // State field(s) for daysLeft widget.
  bool? daysLeftValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // State field(s) for lastUpdate widget.
  bool? lastUpdateValue;
  // Stores action output result for [Backend Call - API (Add Maintainence)] action in Button widget.
  ApiCallResponse? addMaintainenceRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    odometerIntervalFocusNode?.dispose();
    odometerIntervalTextController?.dispose();

    odometerLastFocusNode?.dispose();
    odometerLastTextController?.dispose();

    engineHourIntervalFocusNode?.dispose();
    engineHourIntervalTextController?.dispose();

    engineHourLastFocusNode?.dispose();
    engineHourLastTextController?.dispose();

    daysIntervalFocusNode?.dispose();
    daysIntervalTextController?.dispose();

    daysLastFocusNode?.dispose();
    daysLastTextController?.dispose();

    odometerLeftNumFocusNode?.dispose();
    odometerLeftNumTextController?.dispose();

    engineLeftNumberFocusNode?.dispose();
    engineLeftNumberTextController?.dispose();

    textFieldFocusNode2?.dispose();
    textController10?.dispose();
  }
}
