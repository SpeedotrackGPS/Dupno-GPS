import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'trip_info_form_widget.dart' show TripInfoFormWidget;
import 'package:flutter/material.dart';

class TripInfoFormModel extends FlutterFlowModel<TripInfoFormWidget> {
  ///  Local state fields for this page.

  String? startDate;

  String? endDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - API (Device Trip Info)] action in Button widget.
  ApiCallResponse? tripInfoRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
