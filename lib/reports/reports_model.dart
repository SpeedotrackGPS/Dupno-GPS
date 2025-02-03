import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'reports_widget.dart' show ReportsWidget;
import 'package:flutter/material.dart';

class ReportsModel extends FlutterFlowModel<ReportsWidget> {
  ///  Local state fields for this page.

  List<String> selectedDevices = [];
  void addToSelectedDevices(String item) => selectedDevices.add(item);
  void removeFromSelectedDevices(String item) => selectedDevices.remove(item);
  void removeAtIndexFromSelectedDevices(int index) =>
      selectedDevices.removeAt(index);
  void insertAtIndexInSelectedDevices(int index, String item) =>
      selectedDevices.insert(index, item);
  void updateSelectedDevicesAtIndex(int index, Function(String) updateFn) =>
      selectedDevices[index] = updateFn(selectedDevices[index]);

  String? startDate;

  String? endDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - API (Reports Download)] action in Button widget.
  ApiCallResponse? reportGenerateRes;
  // Stores action output result for [Backend Call - API (Reports Download)] action in Button widget.
  ApiCallResponse? reportDownloadRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
