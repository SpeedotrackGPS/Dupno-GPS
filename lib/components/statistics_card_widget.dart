import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'statistics_card_model.dart';
export 'statistics_card_model.dart';

class StatisticsCardWidget extends StatefulWidget {
  const StatisticsCardWidget({super.key});

  @override
  State<StatisticsCardWidget> createState() => _StatisticsCardWidgetState();
}

class _StatisticsCardWidgetState extends State<StatisticsCardWidget> {
  late StatisticsCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatisticsCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4.0,
            color: Color(0x33000000),
            offset: Offset(
              0.0,
              2.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (Theme.of(context).brightness == Brightness.dark)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                  child: Icon(
                    FFIcons.kspeedometer,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 28.0,
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                child: Icon(
                  FFIcons.kspeedometer,
                  color: FlutterFlowTheme.of(context).secondary,
                  size: 28.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    '6k7rjnbi' /* Odometer */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Bai Jamjuree',
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'claerhkh' /* 153057 km */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Bai Jamjuree',
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
