import '/components/gyvbuyh_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'maintense_widget.dart' show MaintenseWidget;
import 'package:flutter/material.dart';

class MaintenseModel extends FlutterFlowModel<MaintenseWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for gyvbuyh component.
  late GyvbuyhModel gyvbuyhModel;

  @override
  void initState(BuildContext context) {
    gyvbuyhModel = createModel(context, () => GyvbuyhModel());
  }

  @override
  void dispose() {
    gyvbuyhModel.dispose();
  }
}
