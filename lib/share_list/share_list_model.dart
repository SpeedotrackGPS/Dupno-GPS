import '/flutter_flow/flutter_flow_util.dart';
import 'share_list_widget.dart' show ShareListWidget;
import 'package:flutter/material.dart';

class ShareListModel extends FlutterFlowModel<ShareListWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
