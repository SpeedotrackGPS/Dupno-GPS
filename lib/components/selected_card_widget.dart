import '/components/dashboard02_task_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'selected_card_model.dart';
export 'selected_card_model.dart';

class SelectedCardWidget extends StatefulWidget {
  const SelectedCardWidget({super.key});

  @override
  State<SelectedCardWidget> createState() => _SelectedCardWidgetState();
}

class _SelectedCardWidgetState extends State<SelectedCardWidget> {
  late SelectedCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectedCardModel());

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
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 297.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: wrapWithModel(
                    model: _model.dashboard02TaskListModel,
                    updateCallback: () => safeSetState(() {}),
                    child: const Dashboard02TaskListWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
