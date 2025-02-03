import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'custom_fields_model.dart';
export 'custom_fields_model.dart';

class CustomFieldsWidget extends StatefulWidget {
  const CustomFieldsWidget({
    super.key,
    this.deviceData,
  });

  final dynamic deviceData;

  @override
  State<CustomFieldsWidget> createState() => _CustomFieldsWidgetState();
}

class _CustomFieldsWidgetState extends State<CustomFieldsWidget> {
  late CustomFieldsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomFieldsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondary,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'f61ifzjr' /* Custom Fields */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).secondary,
                  fontSize: 15.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
          child: Container(
            width: double.infinity,
            height: 772.27,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  FlutterFlowTheme.of(context).primary
                ],
                stops: const [0.0, 1.0],
                begin: const AlignmentDirectional(0.0, -1.0),
                end: const AlignmentDirectional(0, 1.0),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Builder(
              builder: (context) {
                final customFieldsList = getJsonField(
                  widget.deviceData,
                  r'''$.custom_fields''',
                ).toList();

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: customFieldsList.length,
                  itemBuilder: (context, customFieldsListIndex) {
                    final customFieldsListItem =
                        customFieldsList[customFieldsListIndex];
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          15.0, 12.0, 15.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 63.0,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 12.0,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0.0,
                                          5.0,
                                        ),
                                      )
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        FlutterFlowTheme.of(context).primary,
                                        FlutterFlowTheme.of(context).primary
                                      ],
                                      stops: const [0.0, 1.0],
                                      begin: const AlignmentDirectional(0.0, -1.0),
                                      end: const AlignmentDirectional(0, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 8.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed('UpdateGeofence');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: getJsonField(
                                                      customFieldsListItem,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Bai Jamjuree',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'uobz5te0' /*  -  */,
                                                    ),
                                                    style: const TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text: getJsonField(
                                                      customFieldsListItem,
                                                      r'''$.value''',
                                                    ).toString(),
                                                    style: const TextStyle(),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Bai Jamjuree',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
