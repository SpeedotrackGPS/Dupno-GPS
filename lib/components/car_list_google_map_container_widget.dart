import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'car_list_google_map_container_model.dart';
export 'car_list_google_map_container_model.dart';

class CarListGoogleMapContainerWidget extends StatefulWidget {
  const CarListGoogleMapContainerWidget({
    super.key,
    String? markerImageLink,
    String? mapImageLink,
  })  : markerImageLink = markerImageLink ??
            'https://speedotrack.in/img/markers/objects/m_2_.png',
        mapImageLink = mapImageLink ??
            'https://www.google.com/maps/vt/pb=!1m4!1m3!1i12!2i3018!3i1774!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

  final String markerImageLink;
  final String mapImageLink;

  @override
  State<CarListGoogleMapContainerWidget> createState() =>
      _CarListGoogleMapContainerWidgetState();
}

class _CarListGoogleMapContainerWidgetState
    extends State<CarListGoogleMapContainerWidget> {
  late CarListGoogleMapContainerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarListGoogleMapContainerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.mapImageLink,
              width: 300.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.markerImageLink,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.contain,
                  alignment: const Alignment(0.0, 0.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
