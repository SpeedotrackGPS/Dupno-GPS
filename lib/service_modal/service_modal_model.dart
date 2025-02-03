import '/components/add_main_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'service_modal_widget.dart' show ServiceModalWidget;
import 'package:flutter/material.dart';

class ServiceModalModel extends FlutterFlowModel<ServiceModalWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AddMain component.
  late AddMainModel addMainModel;

  @override
  void initState(BuildContext context) {
    addMainModel = createModel(context, () => AddMainModel());
  }

  @override
  void dispose() {
    addMainModel.dispose();
  }
}
