import '/backend/api_requests/api_calls.dart';
import '/components/car_list_bottom_card_widget.dart';
import '/components/expiring_devices_drawer_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'car_list_screen_model.dart';
export 'car_list_screen_model.dart';

class CarListScreenWidget extends StatefulWidget {
  const CarListScreenWidget({
    super.key,
    String? filterValueParam,
    String? carListFilterValueParam,
  })  : filterValueParam = filterValueParam ?? 'all',
        carListFilterValueParam = carListFilterValueParam ?? 'All';

  final String filterValueParam;
  final String carListFilterValueParam;

  @override
  State<CarListScreenWidget> createState() => _CarListScreenWidgetState();
}

class _CarListScreenWidgetState extends State<CarListScreenWidget>
    with TickerProviderStateMixin {
  late CarListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarListScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.showSearch = false;
      _model.filterValue = widget.filterValueParam;
      safeSetState(() {});
      FFAppState().carListFilterValue = widget.carListFilterValueParam;
      safeSetState(() {});
      await actions.inAppUpdate();
      if (functions
              .retunArrayLength(FFAppState().expiringDevicesList.toList())
              .toString() !=
          '0') {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: const SizedBox(
                  height: 650.0,
                  child: ExpiringDevicesDrawerWidget(),
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
      _model.instantTimer = InstantTimer.periodic(
        duration: const Duration(milliseconds: 5000),
        callback: (timer) async {
          _model.initialPeriodicDeviceDataRes =
              await PhpApiGroupGroup.testLargeDeviceCall.call(
            apiKey: FFAppState().userApiKey,
            fv: 'total',
          );

          if ((_model.initialPeriodicDeviceDataRes?.succeeded ?? true)) {
            FFAppState().allDeviceData =
                (_model.initialPeriodicDeviceDataRes?.jsonBody ?? '');
            FFAppState().isLoadingVehicleData = false;
            FFAppState().update(() {});
            FFAppState().singleDeviceLocationData = functions
                .findSpecficVehicleWithImei(
                    getJsonField(
                      (_model.initialPeriodicDeviceDataRes?.jsonBody ?? ''),
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

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.698, 0),
            end: const Offset(0, 0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.7, 0.7),
            end: const Offset(1.0, 1.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, 30.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 55.0, 8.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.showSearch == false)
                                          Container(
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.filterValue =
                                                                  'all';
                                                              _model.isExpiredFilter =
                                                                  false;
                                                              _model.isOfflineFilter =
                                                                  false;
                                                              _model.isOnlineFilter =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                              FFAppState()
                                                                      .carListFilterValue =
                                                                  'All';
                                                              FFAppState()
                                                                  .deviceSearchValue = '';
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 70.0,
                                                              height: 30.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: _model
                                                                            .filterValue ==
                                                                        'all'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent2
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'i4ooefn2' /* All */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Bai Jamjuree',
                                                                              color: _model.filterValue == 'all' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'yuljqnac' /*  ( */,
                                                                        ),
                                                                        style:
                                                                            TextStyle(
                                                                          color: _model.filterValue == 'all'
                                                                              ? FlutterFlowTheme.of(context).info
                                                                              : FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            FFAppState().allDeviceData,
                                                                            r'''$.total''',
                                                                          )?.toString(),
                                                                          '0',
                                                                        ),
                                                                        style:
                                                                            TextStyle(
                                                                          color: _model.filterValue == 'all'
                                                                              ? FlutterFlowTheme.of(context).info
                                                                              : FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          '170j3lvv' /* ) */,
                                                                        ),
                                                                        style:
                                                                            TextStyle(
                                                                          color: _model.filterValue == 'all'
                                                                              ? FlutterFlowTheme.of(context).info
                                                                              : FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Bai Jamjuree',
                                                                          color: _model.filterValue == 'all'
                                                                              ? FlutterFlowTheme.of(context).primaryText
                                                                              : FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.filterValue =
                                                                    'moving';
                                                                _model.isExpiredFilter =
                                                                    false;
                                                                _model.isOfflineFilter =
                                                                    false;
                                                                _model.isOnlineFilter =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Moving';
                                                                FFAppState()
                                                                    .deviceSearchValue = '';
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                width: 99.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'moving'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'db4lhrp7' /* Moving */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'moving' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'to85yzz5' /*  ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'moving'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.moving''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'moving'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'njygp6st' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'moving'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color: _model.filterValue == 'moving'
                                                                                ? FlutterFlowTheme.of(context).secondaryBackground
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.filterValue =
                                                                    'stopped';
                                                                _model.isExpiredFilter =
                                                                    false;
                                                                _model.isOfflineFilter =
                                                                    false;
                                                                _model.isOnlineFilter =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Stopped';
                                                                FFAppState()
                                                                    .deviceSearchValue = '';
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                width: 99.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'stopped'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'oi15f2vl' /* Stopped */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'stopped' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'l008r75n' /* ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'moving'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.stopped''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'stopped'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            '75h9eagy' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'stopped'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color: _model.filterValue == 'stopped'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.filterValue =
                                                                    'idle';
                                                                _model.isExpiredFilter =
                                                                    false;
                                                                _model.isOfflineFilter =
                                                                    false;
                                                                _model.isOnlineFilter =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Engine idle';
                                                                FFAppState()
                                                                    .deviceSearchValue = '';
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                width: 99.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'idle'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'y2v8xy47' /* Idle */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'idle' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            's38fj656' /* ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'idle'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.idle''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'idle'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            '1n5np9f6' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'idle'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color: _model.filterValue == 'idle'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.filterValue =
                                                                    'Offline';
                                                                _model.isOnlineFilter =
                                                                    false;
                                                                _model.isExpiredFilter =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Offline';
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                width: 84.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'Offline'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            's1kfpmda' /* Offline */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'Offline' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'rk0ndhuk' /*  ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'Offline'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.offline''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'Offline'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'ysfwlgwr' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'Offline'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color: _model.filterValue == 'Offline'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.isOnlineFilter =
                                                                    true;
                                                                _model.isExpiredFilter =
                                                                    false;
                                                                _model.filterValue =
                                                                    'online';
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Online';
                                                                FFAppState()
                                                                    .update(
                                                                        () {});
                                                              },
                                                              child: Container(
                                                                width: 99.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'online'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            '9qhv1gs1' /* Online */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'online' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'kfvk5r8p' /*  ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'online'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.online''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'online'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            '0rt9tsiw' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'online'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.isExpiredFilter =
                                                                    true;
                                                                _model.isOfflineFilter =
                                                                    false;
                                                                _model.isOnlineFilter =
                                                                    false;
                                                                _model.filterValue =
                                                                    'expired';
                                                                safeSetState(
                                                                    () {});
                                                                FFAppState()
                                                                        .carListFilterValue =
                                                                    'Expired';
                                                                FFAppState()
                                                                    .update(
                                                                        () {});
                                                              },
                                                              child: Container(
                                                                width: 99.0,
                                                                height: 30.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _model
                                                                              .filterValue ==
                                                                          'expired'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent2
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'owi6gjju' /* Expired */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Bai Jamjuree',
                                                                                color: _model.filterValue == 'expired' ? FlutterFlowTheme.of(context).info : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'w63q6xb9' /*  ( */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'expired'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              FFAppState().allDeviceData,
                                                                              r'''$.expired''',
                                                                            )?.toString(),
                                                                            '0',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'expired'
                                                                                ? FlutterFlowTheme.of(context).info
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'p3aubh72' /* ) */,
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            color: _model.filterValue == 'expired'
                                                                                ? FlutterFlowTheme.of(context).secondaryBackground
                                                                                : FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
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
                                            ),
                                          ),
                                        if (_model.showSearch == true)
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 10.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Container(
                                                width: 360.0,
                                                height: 45.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController,
                                                    focusNode: _model
                                                        .textFieldFocusNode,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'wpydl9qp' /* Search Device... */,
                                                      ),
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Bai Jamjuree',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Bai Jamjuree',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Bai Jamjuree',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    validator: _model
                                                        .textControllerValidator
                                                        .asValidator(context),
                                                  ),
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
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 4.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.showSearch = !_model.showSearch;
                                      safeSetState(() {});
                                      safeSetState(() {
                                        _model.textController?.clear();
                                      });
                                    },
                                    child: Icon(
                                      Icons.search_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Align(
                    alignment: const Alignment(0.0, 0),
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Bai Jamjuree',
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                              ),
                      unselectedLabelStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Bai Jamjuree',
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                              ),
                      labelColor: FlutterFlowTheme.of(context).info,
                      unselectedLabelColor:
                          FlutterFlowTheme.of(context).secondaryText,
                      backgroundColor: FlutterFlowTheme.of(context).accent2,
                      unselectedBackgroundColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderColor: FlutterFlowTheme.of(context).accent2,
                      unselectedBorderColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderWidth: 2.0,
                      borderRadius: 8.0,
                      elevation: 0.0,
                      buttonMargin:
                          const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      padding: const EdgeInsets.all(4.0),
                      tabs: [
                        Tab(
                          text: FFLocalizations.of(context).getText(
                            '943ikpaa' /* Map View */,
                          ),
                        ),
                        Tab(
                          text: FFLocalizations.of(context).getText(
                            'b51g8ozz' /* List View */,
                          ),
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}, () async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        Container(
                          height: double.infinity,
                          decoration: const BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final deviceList = functions
                                  .returnFilteredDeviceListOnStatus(
                                      FFAppState().carListFilterValue,
                                      getJsonField(
                                        FFAppState().allDeviceData,
                                        r'''$.result''',
                                        true,
                                      )!,
                                      _model.textController.text,
                                      _model.isOnlineFilter,
                                      _model.isOfflineFilter,
                                      _model.isExpiredFilter)
                                  .toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: deviceList.length,
                                itemBuilder: (context, deviceListIndex) {
                                  final deviceListItem =
                                      deviceList[deviceListIndex];
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 10.0, 12.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (getJsonField(
                                                            deviceListItem,
                                                            r'''$.active''',
                                                          ) ==
                                                          getJsonField(
                                                            <String, String>{
                                                              'val': 'true',
                                                            },
                                                            r'''$.val''',
                                                          )) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      15.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 3.0,
                                                                    height:
                                                                        280.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        () {
                                                                          if (getJsonField(
                                                                                deviceListItem,
                                                                                r'''$.st''',
                                                                              ) ==
                                                                              getJsonField(
                                                                                FFAppState().containsMoving,
                                                                                r'''$.m''',
                                                                              )) {
                                                                            return const Color(0xFF2E7304);
                                                                          } else if (getJsonField(
                                                                                deviceListItem,
                                                                                r'''$.st''',
                                                                              ) ==
                                                                              getJsonField(
                                                                                FFAppState().containsStopped,
                                                                                r'''$.s''',
                                                                              )) {
                                                                            return const Color(0xFFDD2020);
                                                                          } else if (getJsonField(
                                                                                deviceListItem,
                                                                                r'''$.st''',
                                                                              ) ==
                                                                              getJsonField(
                                                                                FFAppState().containsIdle,
                                                                                r'''$.i''',
                                                                              )) {
                                                                            return const Color(0xFFBC7418);
                                                                          } else {
                                                                            return const Color(0xFF404040);
                                                                          }
                                                                        }(),
                                                                        const Color(
                                                                            0xFFDDD5D5),
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(50.0),
                                                                        bottomRight:
                                                                            Radius.circular(0.0),
                                                                        topLeft:
                                                                            Radius.circular(50.0),
                                                                        topRight:
                                                                            Radius.circular(0.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          266.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: double.infinity,
                                                                                                  height: 168.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    image: DecorationImage(
                                                                                                      fit: BoxFit.cover,
                                                                                                      image: Image.network(
                                                                                                        functions.returnGoogleMapTile(
                                                                                                            '14',
                                                                                                            valueOrDefault<String>(
                                                                                                              getJsonField(
                                                                                                                deviceListItem,
                                                                                                                r'''$.lat''',
                                                                                                              )?.toString(),
                                                                                                              '0',
                                                                                                            ),
                                                                                                            valueOrDefault<String>(
                                                                                                              getJsonField(
                                                                                                                deviceListItem,
                                                                                                                r'''$.lng''',
                                                                                                              )?.toString(),
                                                                                                              '0',
                                                                                                            )),
                                                                                                      ).image,
                                                                                                    ),
                                                                                                    borderRadius: const BorderRadius.only(
                                                                                                      bottomLeft: Radius.circular(0.0),
                                                                                                      bottomRight: Radius.circular(0.0),
                                                                                                      topLeft: Radius.circular(10.0),
                                                                                                      topRight: Radius.circular(10.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: double.infinity,
                                                                                                  decoration: const BoxDecoration(
                                                                                                    color: Color(0x1BFFFFFF),
                                                                                                  ),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 12.0, 10.0, 0.0),
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                                                                                                                child: Container(
                                                                                                                  width: 200.0,
                                                                                                                  height: 20.0,
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  child: RichText(
                                                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                                                    text: TextSpan(
                                                                                                                      children: [
                                                                                                                        TextSpan(
                                                                                                                          text: valueOrDefault<String>(
                                                                                                                            getJsonField(
                                                                                                                              deviceListItem,
                                                                                                                              r'''$.speed''',
                                                                                                                            )?.toString(),
                                                                                                                            '0',
                                                                                                                          ),
                                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                fontFamily: 'Bai Jamjuree',
                                                                                                                                fontSize: 18.0,
                                                                                                                                letterSpacing: 0.0,
                                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                              ),
                                                                                                                        ),
                                                                                                                        TextSpan(
                                                                                                                          text: FFLocalizations.of(context).getText(
                                                                                                                            'r5z1jqh1' /*  KM/H */,
                                                                                                                          ),
                                                                                                                          style: const TextStyle(),
                                                                                                                        )
                                                                                                                      ],
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            fontFamily: 'Bai Jamjuree',
                                                                                                                            fontSize: 18.0,
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w600,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Expanded(
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                                                child: Container(
                                                                                                                  width: 200.0,
                                                                                                                  height: 20.0,
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                                  child: AutoSizeText(
                                                                                                                    valueOrDefault<String>(
                                                                                                                      getJsonField(
                                                                                                                        deviceListItem,
                                                                                                                        r'''$.name''',
                                                                                                                      )?.toString(),
                                                                                                                      'Device Name',
                                                                                                                    ),
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          fontFamily: 'Bai Jamjuree',
                                                                                                                          fontSize: 16.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                                                                                                        child: Row(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                                                                                                                child: Container(
                                                                                                                  width: 200.0,
                                                                                                                  height: 20.0,
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  child: Padding(
                                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                                    child: RichText(
                                                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                                                      text: TextSpan(
                                                                                                                        children: [
                                                                                                                          TextSpan(
                                                                                                                            text: FFLocalizations.of(context).getText(
                                                                                                                              'z5vft0fl' /* IMEI :  */,
                                                                                                                            ),
                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                  fontFamily: 'Bai Jamjuree',
                                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                  fontSize: 10.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                                ),
                                                                                                                          ),
                                                                                                                          TextSpan(
                                                                                                                            text: valueOrDefault<String>(
                                                                                                                              getJsonField(
                                                                                                                                deviceListItem,
                                                                                                                                r'''$.imei''',
                                                                                                                              )?.toString(),
                                                                                                                              '00',
                                                                                                                            ),
                                                                                                                            style: TextStyle(
                                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                              fontSize: 10.0,
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        ],
                                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                              fontFamily: 'Bai Jamjuree',
                                                                                                                              letterSpacing: 0.0,
                                                                                                                            ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Expanded(
                                                                                                              child: Padding(
                                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                                child: Container(
                                                                                                                  width: 200.0,
                                                                                                                  height: 20.0,
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                                  child: Text(
                                                                                                                    FFLocalizations.of(context).getText(
                                                                                                                      '4840fblw' /* Expires On */,
                                                                                                                    ),
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          fontFamily: 'Bai Jamjuree',
                                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                          fontSize: 10.0,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Expanded(
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 200.0,
                                                                                                                height: 20.0,
                                                                                                                decoration: const BoxDecoration(),
                                                                                                                child: Padding(
                                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                                  child: RichText(
                                                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                                                    text: TextSpan(
                                                                                                                      children: [
                                                                                                                        TextSpan(
                                                                                                                          text: FFLocalizations.of(context).getText(
                                                                                                                            '9c6gul7l' /* Moving :  */,
                                                                                                                          ),
                                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                fontFamily: 'Bai Jamjuree',
                                                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                fontSize: 10.0,
                                                                                                                                letterSpacing: 0.0,
                                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                              ),
                                                                                                                        ),
                                                                                                                        TextSpan(
                                                                                                                          text: valueOrDefault<String>(
                                                                                                                            getJsonField(
                                                                                                                              deviceListItem,
                                                                                                                              r'''$.ststr''',
                                                                                                                            )?.toString(),
                                                                                                                            '0',
                                                                                                                          ),
                                                                                                                          style: TextStyle(
                                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                            fontSize: 10.0,
                                                                                                                          ),
                                                                                                                        )
                                                                                                                      ],
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            fontFamily: 'Bai Jamjuree',
                                                                                                                            letterSpacing: 0.0,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                              child: Container(
                                                                                                                width: 200.0,
                                                                                                                height: 20.0,
                                                                                                                decoration: const BoxDecoration(),
                                                                                                                alignment: const AlignmentDirectional(1.0, 0.0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    getJsonField(
                                                                                                                      deviceListItem,
                                                                                                                      r'''$.object_expire_dt''',
                                                                                                                    )?.toString(),
                                                                                                                    '0',
                                                                                                                  ),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Bai Jamjuree',
                                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                        fontSize: 10.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    await showModalBottomSheet(
                                                                                                      isScrollControlled: true,
                                                                                                      backgroundColor: Colors.transparent,
                                                                                                      context: context,
                                                                                                      builder: (context) {
                                                                                                        return GestureDetector(
                                                                                                          onTap: () {
                                                                                                            FocusScope.of(context).unfocus();
                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                          },
                                                                                                          child: Padding(
                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                            child: CarListBottomCardWidget(
                                                                                                              deviceData: deviceListItem,
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ).then((value) => safeSetState(() {}));
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: 161.0,
                                                                                                    decoration: const BoxDecoration(),
                                                                                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                                      child: Image.network(
                                                                                                        getJsonField(
                                                                                                          deviceListItem,
                                                                                                          r'''$.icon''',
                                                                                                        ).toString(),
                                                                                                        width: 36.0,
                                                                                                        height: 48.0,
                                                                                                        fit: BoxFit.contain,
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
                                                                                  ],
                                                                                ),
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 5.0),
                                                                                    child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: const AlignmentDirectional(0.0, -1.0),
                                                                                            child: Container(
                                                                                              width: 386.0,
                                                                                              decoration: const BoxDecoration(),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                                                                                child: Builder(
                                                                                                  builder: (context) {
                                                                                                    final sensorsList = getJsonField(
                                                                                                      deviceListItem,
                                                                                                      r'''$.sensors''',
                                                                                                    ).toList();

                                                                                                    return SingleChildScrollView(
                                                                                                      scrollDirection: Axis.horizontal,
                                                                                                      child: Row(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: List.generate(sensorsList.length, (sensorsListIndex) {
                                                                                                          final sensorsListItem = sensorsList[sensorsListIndex];
                                                                                                          return Padding(
                                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                                                                                                            child: Column(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                ),
                                                                                                                Container(
                                                                                                                  decoration: const BoxDecoration(),
                                                                                                                  child: ClipRRect(
                                                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                                                    child: Image.network(
                                                                                                                      getJsonField(
                                                                                                                        sensorsListItem,
                                                                                                                        r'''$.icon''',
                                                                                                                      ).toString(),
                                                                                                                      width: 15.0,
                                                                                                                      height: 20.0,
                                                                                                                      fit: BoxFit.cover,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                AutoSizeText(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    getJsonField(
                                                                                                                      sensorsListItem,
                                                                                                                      r'''$.name''',
                                                                                                                    )?.toString(),
                                                                                                                    'name',
                                                                                                                  ),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Bai Jamjuree',
                                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                        fontSize: 10.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                ),
                                                                                                                AutoSizeText(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    getJsonField(
                                                                                                                      sensorsListItem,
                                                                                                                      r'''$.value_full''',
                                                                                                                    )?.toString(),
                                                                                                                    '0',
                                                                                                                  ),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        fontFamily: 'Bai Jamjuree',
                                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                        fontSize: 10.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          );
                                                                                                        }),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                context.pushNamed(
                                                                                                  'New_Tracking_Screen',
                                                                                                  queryParameters: {
                                                                                                    'singleDeviceData': serializeParam(
                                                                                                      deviceListItem,
                                                                                                      ParamType.JSON,
                                                                                                    ),
                                                                                                  }.withoutNulls,
                                                                                                );
                                                                                              },
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                children: [
                                                                                                  const Icon(
                                                                                                    Icons.gps_fixed,
                                                                                                    color: Color(0xFF798A97),
                                                                                                    size: 18.0,
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 4.0),
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        'vb7eyp2m' /* Live Tracking */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Bai Jamjuree',
                                                                                                            color: const Color(0xFF798A97),
                                                                                                            fontSize: 12.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  context.pushNamed(
                                                                                                    'PlaybackInput',
                                                                                                    queryParameters: {
                                                                                                      'selectedDeviceData': serializeParam(
                                                                                                        deviceListItem,
                                                                                                        ParamType.JSON,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                  );
                                                                                                },
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                  children: [
                                                                                                    const Icon(
                                                                                                      Icons.play_circle,
                                                                                                      color: Color(0xFF798A97),
                                                                                                      size: 18.0,
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 4.0),
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          '75j0tgbc' /* Playback */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              fontFamily: 'Bai Jamjuree',
                                                                                                              color: const Color(0xFF798A97),
                                                                                                              fontSize: 12.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    context.pushNamed(
                                                                                                      'AdvanceInfo',
                                                                                                      queryParameters: {
                                                                                                        'singleDeviceData': serializeParam(
                                                                                                          deviceListItem,
                                                                                                          ParamType.JSON,
                                                                                                        ),
                                                                                                      }.withoutNulls,
                                                                                                    );
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                    children: [
                                                                                                      const Icon(
                                                                                                        Icons.dashboard_rounded,
                                                                                                        color: Color(0xFF798A97),
                                                                                                        size: 18.0,
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 4.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'bnbuibzq' /* Dashboard */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: 'Bai Jamjuree',
                                                                                                                color: const Color(0xFF798A97),
                                                                                                                fontSize: 12.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Align(
                                                                                                alignment: const AlignmentDirectional(1.0, -1.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    await showModalBottomSheet(
                                                                                                      isScrollControlled: true,
                                                                                                      backgroundColor: Colors.transparent,
                                                                                                      context: context,
                                                                                                      builder: (context) {
                                                                                                        return GestureDetector(
                                                                                                          onTap: () {
                                                                                                            FocusScope.of(context).unfocus();
                                                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                                                          },
                                                                                                          child: Padding(
                                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                                            child: CarListBottomCardWidget(
                                                                                                              deviceData: deviceListItem,
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ).then((value) => safeSetState(() {}));
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    decoration: const BoxDecoration(),
                                                                                                    child: const Icon(
                                                                                                      Icons.read_more,
                                                                                                      color: Color(0xFF9AA4AB),
                                                                                                      size: 18.0,
                                                                                                    ),
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
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          width: 359.46,
                                                          height: 149.7,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0.0,
                                                                  2.0,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                  'PaymentPage');
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          20.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    FFIcons
                                                                        .kmoney,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    size: 50.0,
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            12.0),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'ungbrlw0' /* Dear User, your  */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Bai Jamjuree',
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              deviceListItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            style:
                                                                                const TextStyle(),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'k9c7vzu9' /*  has expired on  */,
                                                                            ),
                                                                            style:
                                                                                const TextStyle(),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              deviceListItem,
                                                                              r'''$.object_expire_dt''',
                                                                            ).toString(),
                                                                            style:
                                                                                const TextStyle(),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              '5qkjns7s' /* .  Renew today to avoid reacti... */,
                                                                            ),
                                                                            style:
                                                                                const TextStyle(),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Bai Jamjuree',
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          decoration: const BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final deviceListTable = functions
                                  .returnFilteredDeviceListOnStatus(
                                      FFAppState().carListFilterValue,
                                      getJsonField(
                                        FFAppState().allDeviceData,
                                        r'''$.result''',
                                        true,
                                      )!,
                                      _model.textController.text,
                                      _model.isOnlineFilter,
                                      _model.isOfflineFilter,
                                      _model.isExpiredFilter)
                                  .toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: deviceListTable.length,
                                itemBuilder: (context, deviceListTableIndex) {
                                  final deviceListTableItem =
                                      deviceListTable[deviceListTableIndex];
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              if (getJsonField(
                                                    deviceListTableItem,
                                                    r'''$.active''',
                                                  ) ==
                                                  getJsonField(
                                                    <String, String>{
                                                      'val': 'true',
                                                    },
                                                    r'''$.val''',
                                                  )) {
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        const BoxDecoration(),
                                                                    child:
                                                                        AutoSizeText(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          deviceListTableItem,
                                                                          r'''$.speed''',
                                                                        )?.toString(),
                                                                        '0',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color:
                                                                                valueOrDefault<Color>(
                                                                              () {
                                                                                if (getJsonField(
                                                                                      deviceListTableItem,
                                                                                      r'''$.st''',
                                                                                    ) ==
                                                                                    getJsonField(
                                                                                      FFAppState().containsMoving,
                                                                                      r'''$.m''',
                                                                                    )) {
                                                                                  return const Color(0xFF2E7304);
                                                                                } else if (getJsonField(
                                                                                      deviceListTableItem,
                                                                                      r'''$.st''',
                                                                                    ) ==
                                                                                    getJsonField(
                                                                                      FFAppState().containsStopped,
                                                                                      r'''$.s''',
                                                                                    )) {
                                                                                  return const Color(0xFFDD2020);
                                                                                } else if (getJsonField(
                                                                                      deviceListTableItem,
                                                                                      r'''$.st''',
                                                                                    ) ==
                                                                                    getJsonField(
                                                                                      FFAppState().containsIdle,
                                                                                      r'''$.i''',
                                                                                    )) {
                                                                                  return const Color(0xFFBC7418);
                                                                                } else {
                                                                                  return const Color(0xFF404040);
                                                                                }
                                                                              }(),
                                                                              const Color(0xFFDDD5D5),
                                                                            ),
                                                                            fontSize:
                                                                                25.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          6.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'lmve53l9' /* KM/H */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Bai Jamjuree',
                                                                              color: valueOrDefault<Color>(
                                                                                () {
                                                                                  if (getJsonField(
                                                                                        deviceListTableItem,
                                                                                        r'''$.st''',
                                                                                      ) ==
                                                                                      getJsonField(
                                                                                        FFAppState().containsMoving,
                                                                                        r'''$.m''',
                                                                                      )) {
                                                                                    return const Color(0xFF2E7304);
                                                                                  } else if (getJsonField(
                                                                                        deviceListTableItem,
                                                                                        r'''$.st''',
                                                                                      ) ==
                                                                                      getJsonField(
                                                                                        FFAppState().containsStopped,
                                                                                        r'''$.s''',
                                                                                      )) {
                                                                                    return const Color(0xFFDD2020);
                                                                                  } else if (getJsonField(
                                                                                        deviceListTableItem,
                                                                                        r'''$.st''',
                                                                                      ) ==
                                                                                      getJsonField(
                                                                                        FFAppState().containsIdle,
                                                                                        r'''$.i''',
                                                                                      )) {
                                                                                    return const Color(0xFFBC7418);
                                                                                  } else {
                                                                                    return const Color(0xFF404040);
                                                                                  }
                                                                                }(),
                                                                                const Color(0xFFDDD5D5),
                                                                              ),
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          fadeInDuration:
                                                                              const Duration(milliseconds: 500),
                                                                          fadeOutDuration:
                                                                              const Duration(milliseconds: 500),
                                                                          imageUrl:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              deviceListTableItem,
                                                                              r'''$.icon''',
                                                                            )?.toString(),
                                                                            'https://www.speedotrack.in/img/markers/objects/m_2_.png',
                                                                          ),
                                                                          width:
                                                                              35.0,
                                                                          height:
                                                                              50.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          148.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                await showModalBottomSheet(
                                                                                  isScrollControlled: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  useSafeArea: true,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return GestureDetector(
                                                                                      onTap: () {
                                                                                        FocusScope.of(context).unfocus();
                                                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: MediaQuery.viewInsetsOf(context),
                                                                                        child: CarListBottomCardWidget(
                                                                                          deviceData: deviceListTableItem,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));
                                                                              },
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            decoration: const BoxDecoration(),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  deviceListTableItem,
                                                                                                  r'''$.name''',
                                                                                                )?.toString(),
                                                                                                'Device Name',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'Bai Jamjuree',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  Icons.location_on,
                                                                                                  color: getJsonField(
                                                                                                            deviceListTableItem,
                                                                                                            r'''$.cn''',
                                                                                                          ) !=
                                                                                                          getJsonField(
                                                                                                            FFAppState().containsCnOff,
                                                                                                            r'''$.cn''',
                                                                                                          )
                                                                                                      ? FlutterFlowTheme.of(context).success
                                                                                                      : FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 18.0,
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'ic863mas' /* GPS */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'Bai Jamjuree',
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          fontSize: 11.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  const Icon(
                                                                                                    Icons.wifi_rounded,
                                                                                                    color: Color(0xFF2E7304),
                                                                                                    size: 18.0,
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        'iz3rug3a' /* GSM */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Bai Jamjuree',
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            fontSize: 11.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.key,
                                                                                                    color: getJsonField(
                                                                                                              deviceListTableItem,
                                                                                                              r'''$.ignition.value''',
                                                                                                            ) ==
                                                                                                            getJsonField(
                                                                                                              FFAppState().containsIgnitionOn,
                                                                                                              r'''$.i''',
                                                                                                            )
                                                                                                        ? FlutterFlowTheme.of(context).success
                                                                                                        : FlutterFlowTheme.of(context).secondaryText,
                                                                                                    size: 18.0,
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        '61r146qn' /* Ignition */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'Bai Jamjuree',
                                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                            fontSize: 11.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    thickness: 1.0,
                                                                                    color: FlutterFlowTheme.of(context).accent4,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          valueOrDefault<String>(
                                                                                            getJsonField(
                                                                                              deviceListTableItem,
                                                                                              r'''$.ststr''',
                                                                                            )?.toString(),
                                                                                            'Device Status',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'Bai Jamjuree',
                                                                                                color: valueOrDefault<Color>(
                                                                                                  () {
                                                                                                    if (getJsonField(
                                                                                                          deviceListTableItem,
                                                                                                          r'''$.st''',
                                                                                                        ) ==
                                                                                                        getJsonField(
                                                                                                          FFAppState().containsMoving,
                                                                                                          r'''$.m''',
                                                                                                        )) {
                                                                                                      return const Color(0xFF2E7304);
                                                                                                    } else if (getJsonField(
                                                                                                          deviceListTableItem,
                                                                                                          r'''$.st''',
                                                                                                        ) ==
                                                                                                        getJsonField(
                                                                                                          FFAppState().containsStopped,
                                                                                                          r'''$.s''',
                                                                                                        )) {
                                                                                                      return const Color(0xFFDD2020);
                                                                                                    } else if (getJsonField(
                                                                                                          deviceListTableItem,
                                                                                                          r'''$.st''',
                                                                                                        ) ==
                                                                                                        getJsonField(
                                                                                                          FFAppState().containsIdle,
                                                                                                          r'''$.i''',
                                                                                                        )) {
                                                                                                      return const Color(0xFFBC7418);
                                                                                                    } else {
                                                                                                      return const Color(0xFF404040);
                                                                                                    }
                                                                                                  }(),
                                                                                                  const Color(0xFFDDD5D5),
                                                                                                ),
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                        Material(
                                                                                          color: Colors.transparent,
                                                                                          elevation: 0.0,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: 70.0,
                                                                                            height: 20.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: valueOrDefault<Color>(
                                                                                                () {
                                                                                                  if (getJsonField(
                                                                                                        deviceListTableItem,
                                                                                                        r'''$.st''',
                                                                                                      ) ==
                                                                                                      getJsonField(
                                                                                                        FFAppState().containsMoving,
                                                                                                        r'''$.m''',
                                                                                                      )) {
                                                                                                    return const Color(0xFF2E7304);
                                                                                                  } else if (getJsonField(
                                                                                                        deviceListTableItem,
                                                                                                        r'''$.st''',
                                                                                                      ) ==
                                                                                                      getJsonField(
                                                                                                        FFAppState().containsStopped,
                                                                                                        r'''$.s''',
                                                                                                      )) {
                                                                                                    return const Color(0xFFDD2020);
                                                                                                  } else if (getJsonField(
                                                                                                        deviceListTableItem,
                                                                                                        r'''$.st''',
                                                                                                      ) ==
                                                                                                      getJsonField(
                                                                                                        FFAppState().containsIdle,
                                                                                                        r'''$.i''',
                                                                                                      )) {
                                                                                                    return const Color(0xFFBC7418);
                                                                                                  } else {
                                                                                                    return const Color(0xFF404040);
                                                                                                  }
                                                                                                }(),
                                                                                                const Color(0xFFDDD5D5),
                                                                                              ),
                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                            ),
                                                                                            child: Align(
                                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 1.0, 5.0, 1.0),
                                                                                                child: AutoSizeText(
                                                                                                  getJsonField(
                                                                                                    deviceListTableItem,
                                                                                                    r'''$.object_expire_dt''',
                                                                                                  ).toString(),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Bai Jamjuree',
                                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                        fontSize: 10.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                          child: Container(
                                                                                            width: 270.0,
                                                                                            height: 60.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            ),
                                                                                            alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Align(
                                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                                child: AutoSizeText(
                                                                                                  valueOrDefault<String>(
                                                                                                    getJsonField(
                                                                                                      deviceListTableItem,
                                                                                                      r'''$.address''',
                                                                                                    )?.toString(),
                                                                                                    'Device Address',
                                                                                                  ).maybeHandleOverflow(
                                                                                                    maxChars: 40,
                                                                                                  ),
                                                                                                  textAlign: TextAlign.start,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'Bai Jamjuree',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Container(
                                                    width: 332.7,
                                                    height: 149.7,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                            'PaymentPage');
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        20.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Icon(
                                                              FFIcons.kmoney,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              size: 50.0,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                          12.0),
                                                              child: RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'a7rpsj4b' /* Dear User, your  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Bai Jamjuree',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).error,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          getJsonField(
                                                                        deviceListTableItem,
                                                                        r'''$.name''',
                                                                      ).toString(),
                                                                      style:
                                                                          const TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '0bskjnii' /*  has expired on  */,
                                                                      ),
                                                                      style:
                                                                          const TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          getJsonField(
                                                                        deviceListTableItem,
                                                                        r'''$.object_expire_dt''',
                                                                      ).toString(),
                                                                      style:
                                                                          const TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '9gpc8fjv' /* .  Renew today to avoid reacti... */,
                                                                      ),
                                                                      style:
                                                                          const TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Bai Jamjuree',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).animateOnPageLoad(animationsMap[
                                  'listViewOnPageLoadAnimation']!);
                            },
                          ),
                        ),
                      ],
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
