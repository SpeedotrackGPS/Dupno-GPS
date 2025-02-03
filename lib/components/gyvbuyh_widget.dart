import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'gyvbuyh_model.dart';
export 'gyvbuyh_model.dart';

class GyvbuyhWidget extends StatefulWidget {
  const GyvbuyhWidget({super.key});

  @override
  State<GyvbuyhWidget> createState() => _GyvbuyhWidgetState();
}

class _GyvbuyhWidgetState extends State<GyvbuyhWidget> {
  late GyvbuyhModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GyvbuyhModel());

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
        const SizedBox(
          height: 30.0,
          child: VerticalDivider(
            thickness: 1.0,
            color: Color(0xFF92BF90),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'veuf50iy' /* Vidange */,
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Bai Jamjuree',
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'pcubnmkm' /* Moto Shield */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Bai Jamjuree',
                      fontSize: 10.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Icon(
                    Icons.timer_sharp,
                    color: FlutterFlowTheme.of(context).secondary,
                    size: 24.0,
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'y310z1uy' /* 153456 km */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Bai Jamjuree',
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Icon(
                        Icons.timer_sharp,
                        color: FlutterFlowTheme.of(context).secondary,
                        size: 24.0,
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'eoj4kyhd' /* 153456 km */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
