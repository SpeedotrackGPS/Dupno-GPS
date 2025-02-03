import '/components/a_b_c_d_c_ard_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'list_bottom_sheets_widget.dart' show ListBottomSheetsWidget;
import 'package:flutter/material.dart';

class ListBottomSheetsModel extends FlutterFlowModel<ListBottomSheetsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ABCDCArd component.
  late ABCDCArdModel aBCDCArdModel;

  @override
  void initState(BuildContext context) {
    aBCDCArdModel = createModel(context, () => ABCDCArdModel());
  }

  @override
  void dispose() {
    aBCDCArdModel.dispose();
  }
}
