import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'commands_list_model.dart';
export 'commands_list_model.dart';

class CommandsListWidget extends StatefulWidget {
  const CommandsListWidget({
    super.key,
    this.deviceData,
  });

  final dynamic deviceData;

  @override
  State<CommandsListWidget> createState() => _CommandsListWidgetState();
}

class _CommandsListWidgetState extends State<CommandsListWidget> {
  late CommandsListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommandsListModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isLoading = true;
      safeSetState(() {});
      _model.deviceExecCommandsRes =
          await PhpApiGroupGroup.getUserCommandsExecCall.call(
        userApiKey: FFAppState().userApiKey,
        deviceImeiForCommandList: getJsonField(
          widget.deviceData,
          r'''$.imei''',
        ).toString().toString(),
      );

      if ((_model.deviceExecCommandsRes?.succeeded ?? true)) {
        _model.execCommandsList = (_model.deviceExecCommandsRes?.jsonBody ?? '')
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
        _model.sentCommandsRes =
            await PhpApiGroupGroup.getUserCommandsCall.call(
          userApiKey: FFAppState().userApiKey,
          deviceImei: getJsonField(
            widget.deviceData,
            r'''$.imei''',
          ).toString().toString(),
        );

        if ((_model.sentCommandsRes?.succeeded ?? true)) {
          _model.isLoading = false;
          _model.sentCommandsList =
              (_model.sentCommandsRes?.jsonBody ?? '').toList().cast<dynamic>();
          safeSetState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Unable to get exceucted commands',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unable to get exceucted commands',
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondary,
              size: 20.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              '4x1rh9eo' /* Device Commands List */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).secondary,
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        getJsonField(
                          widget.deviceData,
                          r'''$.name''',
                        )?.toString(),
                        'Device Name',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Bai Jamjuree',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                if (_model.isLoading == true)
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'u1ciydil' /* Loading... */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Bai Jamjuree',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '1nfn5xpl' /* Commands Sent List */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Bai Jamjuree',
                            color: FlutterFlowTheme.of(context).secondary,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (functions
                            .retunArrayLength(_model.sentCommandsList.toList())
                            .toString() ==
                        '0')
                      Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'dluygvyc' /* No Commands Found ! */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Bai Jamjuree',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 40.0),
                      child: Container(
                        height: 500.0,
                        constraints: const BoxConstraints(
                          maxHeight: 500.0,
                        ),
                        decoration: const BoxDecoration(),
                        child: Visibility(
                          visible: _model.isLoading == false,
                          child: Builder(
                            builder: (context) {
                              final commandsList =
                                  _model.sentCommandsList.toList();

                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(commandsList.length,
                                      (commandsListIndex) {
                                    final commandsListItem =
                                        commandsList[commandsListIndex];
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 15.0, 8.0, 15.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      commandsListItem,
                                                      r'''$[1]''',
                                                    )?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Bai Jamjuree',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      commandsListItem,
                                                      r'''$[1]''',
                                                    )?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Bai Jamjuree',
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      commandsListItem,
                                                      r'''$[2]''',
                                                    )?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 50.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '0ihqmmag' /* Commands Executed List */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Bai Jamjuree',
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (functions
                            .retunArrayLength(_model.execCommandsList.toList())
                            .toString() ==
                        '0')
                      Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '9xbj0gvp' /* No Commands Found ! */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Bai Jamjuree',
                                  color: FlutterFlowTheme.of(context).secondary,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    if (_model.isLoading == false)
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxHeight: 500.0,
                          ),
                          decoration: const BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final executedCommandsList =
                                  (_model.sentCommandsRes?.jsonBody ?? '')
                                      .toList();

                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(executedCommandsList.length,
                                          (executedCommandsListIndex) {
                                    final executedCommandsListItem =
                                        executedCommandsList[
                                            executedCommandsListIndex];
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: 365.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  getJsonField(
                                                    executedCommandsListItem,
                                                    r'''$[1]''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Bai Jamjuree',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      executedCommandsListItem,
                                                      r'''$[0]''',
                                                    )?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Bai Jamjuree',
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
