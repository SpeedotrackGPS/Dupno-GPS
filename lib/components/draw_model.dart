import '/components/demo_form_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'draw_widget.dart' show DrawWidget;
import 'package:flutter/material.dart';

class DrawModel extends FlutterFlowModel<DrawWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for DemoForm component.
  late DemoFormModel demoFormModel;

  @override
  void initState(BuildContext context) {
    demoFormModel = createModel(context, () => DemoFormModel());
  }

  @override
  void dispose() {
    demoFormModel.dispose();
  }
}
