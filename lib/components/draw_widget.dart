import '/components/demo_form_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'draw_model.dart';
export 'draw_model.dart';

class DrawWidget extends StatefulWidget {
  const DrawWidget({super.key});

  @override
  State<DrawWidget> createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  late DrawModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrawModel());

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
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 679.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: wrapWithModel(
                  model: _model.demoFormModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const DemoFormWidget(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
