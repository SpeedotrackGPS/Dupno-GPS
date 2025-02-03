import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'multiple_fleet_model.dart';
export 'multiple_fleet_model.dart';

class MultipleFleetWidget extends StatefulWidget {
  const MultipleFleetWidget({super.key});

  @override
  State<MultipleFleetWidget> createState() => _MultipleFleetWidgetState();
}

class _MultipleFleetWidgetState extends State<MultipleFleetWidget> {
  late MultipleFleetModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MultipleFleetModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: const Duration(milliseconds: 40000),
        callback: (timer) async {
          _model.initialPeriodicMultiple =
              await PhpApiGroupGroup.testLargeDeviceCall.call(
            apiKey: FFAppState().userApiKey,
            fv: 'total',
          );

          if ((_model.initialPeriodicMultiple?.succeeded ?? true)) {
            FFAppState().allDeviceData =
                (_model.initialPeriodicMultiple?.jsonBody ?? '');
            FFAppState().isLoadingVehicleData = false;
            FFAppState().update(() {});
            FFAppState().singleDeviceLocationData = functions
                .findSpecficVehicleWithImei(
                    getJsonField(
                      (_model.initialPeriodicMultiple?.jsonBody ?? ''),
                      r'''$.result''',
                    ),
                    FFAppState().selectedDeviceForData)
                .firstOrNull!;
            FFAppState().update(() {});
          }
        },
        startImmediately: true,
      );
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primary,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: custom_widgets.MultipleScreenTracking(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
