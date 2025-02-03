import '/components/a_b_c_d_c_ard_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'list_bottom_sheets_model.dart';
export 'list_bottom_sheets_model.dart';

class ListBottomSheetsWidget extends StatefulWidget {
  const ListBottomSheetsWidget({
    super.key,
    required this.selectedDeviceImei,
  });

  final dynamic selectedDeviceImei;

  @override
  State<ListBottomSheetsWidget> createState() => _ListBottomSheetsWidgetState();
}

class _ListBottomSheetsWidgetState extends State<ListBottomSheetsWidget> {
  late ListBottomSheetsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListBottomSheetsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 60.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 342.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: wrapWithModel(
                  model: _model.aBCDCArdModel,
                  updateCallback: () => safeSetState(() {}),
                  child: ABCDCArdWidget(
                    selectedDeviceImei: widget.selectedDeviceImei!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
