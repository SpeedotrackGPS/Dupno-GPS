import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'splash_screen_model.dart';
export 'splash_screen_model.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().userApiKey != '') {
        _model.checkProperLogin =
            await PhpApiGroupGroup.fnConnectLOGINTRACKINGApiCall.call(
          username: FFAppState().userName,
          password: FFAppState().password,
        );

        if (((_model.checkProperLogin?.bodyText ?? '') == 'LOGIN_TRACKING') ||
            ((_model.checkProperLogin?.bodyText ?? '') == 'LOGIN_CPANEL')) {
          _model.initialDeviceDataRes =
              await PhpApiGroupGroup.testLargeDeviceCall.call(
            apiKey: FFAppState().userApiKey,
            fv: 'total',
          );

          if ((_model.initialDeviceDataRes?.succeeded ?? true)) {
            FFAppState().allDeviceData =
                (_model.initialDeviceDataRes?.jsonBody ?? '');
            safeSetState(() {});
            FFAppState().expiringDevicesList = functions
                .returnExpiringDevices(getJsonField(
                  (_model.initialDeviceDataRes?.jsonBody ?? ''),
                  r'''$.result''',
                ))
                .toList()
                .cast<dynamic>();
            safeSetState(() {});
            final localAuth = LocalAuthentication();
            bool isBiometricSupported = await localAuth.isDeviceSupported();

            if (isBiometricSupported) {
              try {
                _model.loginbio = await localAuth.authenticate(
                    localizedReason: FFLocalizations.of(context).getText(
                  '8bjikcxc' /* Please authorize */,
                ));
              } on PlatformException {
                _model.loginbio = false;
              }
              safeSetState(() {});
            }

            if (_model.loginbio) {
              context.goNamed(
                'CarListScreen',
                extra: <String, dynamic>{
                  kTransitionInfoKey: const TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                  ),
                },
              );

              if (FFAppState().isDarkMode) {
                setDarkModeSetting(context, ThemeMode.dark);
              } else {
                setDarkModeSetting(context, ThemeMode.light);
              }

              await actions.inAppUpdate();
            } else {
              context.goNamed('LoginScreen');
            }
          } else {
            FFAppState().userApiKey = '';
            safeSetState(() {});
            await actions.onesignalLogout(
              FFAppState().userName,
            );

            context.goNamed('LoginScreen');
          }
        } else {
          FFAppState().userApiKey = '';
          safeSetState(() {});
          await actions.onesignalLogout(
            FFAppState().userName,
          );

          context.goNamed('LoginScreen');
        }
      } else {
        context.goNamed('LoginScreen');
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
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(),
              child: const FlutterFlowVideoPlayer(
                path: 'assets/videos/app_open_animation_(1).mp4',
                videoType: VideoType.asset,
                width: 50.0,
                height: double.infinity,
                autoPlay: true,
                looping: true,
                showControls: false,
                allowFullScreen: true,
                allowPlaybackSpeedMenu: false,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/dt-logo-white.png',
                  width: 347.45,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
