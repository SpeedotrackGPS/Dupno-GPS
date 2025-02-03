import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'playback_loading_model.dart';
export 'playback_loading_model.dart';

class PlaybackLoadingWidget extends StatefulWidget {
  const PlaybackLoadingWidget({
    super.key,
    this.deviceImei,
    this.startDate,
    this.endDate,
    this.minStopDuration,
    this.deviceData,
  });

  final String? deviceImei;
  final String? startDate;
  final String? endDate;
  final String? minStopDuration;
  final dynamic deviceData;

  @override
  State<PlaybackLoadingWidget> createState() => _PlaybackLoadingWidgetState();
}

class _PlaybackLoadingWidgetState extends State<PlaybackLoadingWidget> {
  late PlaybackLoadingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlaybackLoadingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.playbackDataRes =
          await PhpApiGroupGroup.newPlaybackHistoryRouteCall.call(
        userApiKey: FFAppState().userApiKey,
        deviceImei: widget.deviceImei,
        dateFrom: widget.startDate,
        dateTo: widget.endDate,
        minStopDuration: widget.minStopDuration,
      );

      if ((_model.playbackDataRes?.succeeded ?? true)) {
        if (functions
                .retunArrayLength(getJsonField(
                  (_model.playbackDataRes?.jsonBody ?? ''),
                  r'''$.route''',
                  true,
                )!)
                .toString() !=
            '0') {
          if (Navigator.of(context).canPop()) {
            context.pop();
          }
          context.pushNamed(
            'PlaybackFinal',
            queryParameters: {
              'playbackHistoryData': serializeParam(
                (_model.playbackDataRes?.jsonBody ?? ''),
                ParamType.JSON,
              ),
            }.withoutNulls,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'History data not found !',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).info,
                ),
              ),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
          context.safePop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              getJsonField(
                (_model.playbackDataRes?.jsonBody ?? ''),
                r'''$.message''',
              ).toString().toString(),
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Building-a-Logistics-App_(1).gif',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.03, 0.86),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'xjrjnm6k' /* Please wait while we fetch dat... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Bai Jamjuree',
                              color: FlutterFlowTheme.of(context).secondary,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
