import '/components/dashboard02_task_list_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'selected_card_widget.dart' show SelectedCardWidget;
import 'package:flutter/material.dart';

class SelectedCardModel extends FlutterFlowModel<SelectedCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Dashboard02TaskList component.
  late Dashboard02TaskListModel dashboard02TaskListModel;

  @override
  void initState(BuildContext context) {
    dashboard02TaskListModel =
        createModel(context, () => Dashboard02TaskListModel());
  }

  @override
  void dispose() {
    dashboard02TaskListModel.dispose();
  }
}
