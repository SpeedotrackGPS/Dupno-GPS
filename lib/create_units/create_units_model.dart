import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_units_widget.dart' show CreateUnitsWidget;
import 'package:flutter/material.dart';

class CreateUnitsModel extends FlutterFlowModel<CreateUnitsWidget> {
  ///  Local state fields for this page.

  List<String> selectedUnits = [];
  void addToSelectedUnits(String item) => selectedUnits.add(item);
  void removeFromSelectedUnits(String item) => selectedUnits.remove(item);
  void removeAtIndexFromSelectedUnits(int index) =>
      selectedUnits.removeAt(index);
  void insertAtIndexInSelectedUnits(int index, String item) =>
      selectedUnits.insert(index, item);
  void updateSelectedUnitsAtIndex(int index, Function(String) updateFn) =>
      selectedUnits[index] = updateFn(selectedUnits[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - API (Add Event )] action in Button widget.
  ApiCallResponse? addEventRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
