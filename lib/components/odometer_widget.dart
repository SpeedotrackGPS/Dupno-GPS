import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'odometer_model.dart';
export 'odometer_model.dart';

class OdometerWidget extends StatefulWidget {
  const OdometerWidget({super.key});

  @override
  State<OdometerWidget> createState() => _OdometerWidgetState();
}

class _OdometerWidgetState extends State<OdometerWidget> {
  late OdometerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OdometerModel());

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(110.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/vecteezy_meter-speedometer-png-transparent_9589658.png',
                      width: 205.0,
                      height: 72.0,
                      fit: BoxFit.cover,
                      alignment: const Alignment(1.0, 0.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
