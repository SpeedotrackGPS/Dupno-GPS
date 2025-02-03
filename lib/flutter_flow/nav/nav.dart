import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  DupnoGPSProAuthUser? initialUser;
  DupnoGPSProAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(DupnoGPSProAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const NavBarPage() : const SplashScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const NavBarPage() : const SplashScreenWidget(),
        ),
        FFRoute(
          name: 'Home',
          path: '/home',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Home')
              : const NavBarPage(
                  initialPage: 'Home',
                  page: HomeWidget(),
                ),
        ),
        FFRoute(
          name: 'Alert',
          path: '/alert',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Alert')
              : const NavBarPage(
                  initialPage: 'Alert',
                  page: AlertWidget(),
                ),
        ),
        FFRoute(
          name: 'ServiceModal',
          path: '/serviceModal',
          builder: (context, params) => const ServiceModalWidget(),
        ),
        FFRoute(
          name: 'AddExp',
          path: '/addExp',
          builder: (context, params) => const AddExpWidget(),
        ),
        FFRoute(
          name: 'EditWidget',
          path: '/editWidget',
          builder: (context, params) => const EditWidgetWidget(),
        ),
        FFRoute(
          name: 'MyProfile',
          path: '/myProfile',
          builder: (context, params) => const MyProfileWidget(),
        ),
        FFRoute(
          name: 'Reports',
          path: '/reports',
          builder: (context, params) => const ReportsWidget(),
        ),
        FFRoute(
          name: 'Geofence',
          path: '/geofence',
          builder: (context, params) => const GeofenceWidget(),
        ),
        FFRoute(
          name: 'UpdateGeofence',
          path: '/updateGeofence',
          builder: (context, params) => const UpdateGeofenceWidget(),
        ),
        FFRoute(
          name: 'CreateGeofence',
          path: '/createGeofence',
          builder: (context, params) => const CreateGeofenceWidget(),
        ),
        FFRoute(
          name: 'MaintenancePage',
          path: '/maintenancePage',
          builder: (context, params) => const MaintenancePageWidget(),
        ),
        FFRoute(
          name: 'ExpensesPage',
          path: '/expensesPage',
          builder: (context, params) => const ExpensesPageWidget(),
        ),
        FFRoute(
          name: 'LiveSupport',
          path: '/liveSupport',
          builder: (context, params) => const LiveSupportWidget(),
        ),
        FFRoute(
          name: 'NotificationToggle',
          path: '/notificationToggle',
          builder: (context, params) => const NotificationToggleWidget(),
        ),
        FFRoute(
          name: 'kmSummary',
          path: '/kmSummary',
          builder: (context, params) => const KmSummaryWidget(),
        ),
        FFRoute(
          name: 'ChangePassword',
          path: '/changePassword',
          builder: (context, params) => const ChangePasswordWidget(),
        ),
        FFRoute(
          name: 'AdvanceInfo',
          path: '/advanceInfo',
          builder: (context, params) => AdvanceInfoWidget(
            singleDeviceData: params.getParam(
              'singleDeviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'EngineLock',
          path: '/engineLock',
          builder: (context, params) => EngineLockWidget(
            deviceData: params.getParam(
              'deviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'QuickSettings',
          path: '/quickSettings',
          builder: (context, params) => QuickSettingsWidget(
            selectedDeviceImei: params.getParam(
              'selectedDeviceImei',
              ParamType.String,
            ),
            selectedDeviceName: params.getParam(
              'selectedDeviceName',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'UpdateIconModal',
          path: '/updateIconModal',
          builder: (context, params) => UpdateIconModalWidget(
            selectedDeviceImei: params.getParam(
              'selectedDeviceImei',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'TripInfo',
          path: '/tripInfo',
          builder: (context, params) => TripInfoWidget(
            tripData: params.getParam(
              'tripData',
              ParamType.JSON,
            ),
            selectedDeviceImei: params.getParam(
              'selectedDeviceImei',
              ParamType.String,
            ),
            selectedDeviceData: params.getParam(
              'selectedDeviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'splashScreen',
          path: '/splashScreen',
          builder: (context, params) => const SplashScreenWidget(),
        ),
        FFRoute(
          name: 'LoginScreen',
          path: '/loginScreen',
          builder: (context, params) => const LoginScreenWidget(),
        ),
        FFRoute(
          name: 'Events',
          path: '/events',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: EventsWidget(
              selectedDeviceImei: params.getParam(
                'selectedDeviceImei',
                ParamType.String,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'userProfilePage',
          path: '/userProfilePage',
          builder: (context, params) => const UserProfilePageWidget(),
        ),
        FFRoute(
          name: 'dummy',
          path: '/dummy',
          builder: (context, params) => const DummyWidget(),
        ),
        FFRoute(
          name: 'PlaybackLoading',
          path: '/playbackLoading',
          builder: (context, params) => PlaybackLoadingWidget(
            deviceImei: params.getParam(
              'deviceImei',
              ParamType.String,
            ),
            startDate: params.getParam(
              'startDate',
              ParamType.String,
            ),
            endDate: params.getParam(
              'endDate',
              ParamType.String,
            ),
            minStopDuration: params.getParam(
              'minStopDuration',
              ParamType.String,
            ),
            deviceData: params.getParam(
              'deviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'PlaybackFinal',
          path: '/playbackFinal',
          builder: (context, params) => PlaybackFinalWidget(
            playbackHistoryData: params.getParam(
              'playbackHistoryData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'New_Tracking_Screen',
          path: '/newTrackingScreen',
          builder: (context, params) => NewTrackingScreenWidget(
            singleDeviceData: params.getParam(
              'singleDeviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'EngineLockUnsupported',
          path: '/engineLockUnsupported',
          builder: (context, params) => EngineLockUnsupportedWidget(
            deviceData: params.getParam(
              'deviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'Details18TimerSimple',
          path: '/details18TimerSimple',
          builder: (context, params) => const Details18TimerSimpleWidget(),
        ),
        FFRoute(
          name: 'List10OrderHistory',
          path: '/list10OrderHistory',
          builder: (context, params) => const List10OrderHistoryWidget(),
        ),
        FFRoute(
          name: 'Dashboard6',
          path: '/dashboard6',
          builder: (context, params) => const Dashboard6Widget(),
        ),
        FFRoute(
          name: 'Multiple_Fleet',
          path: '/multipleFleet',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Multiple_Fleet')
              : const NavBarPage(
                  initialPage: 'Multiple_Fleet',
                  page: MultipleFleetWidget(),
                ),
        ),
        FFRoute(
          name: 'Add_Maintance',
          path: '/addMaintance',
          builder: (context, params) => const AddMaintanceWidget(),
        ),
        FFRoute(
          name: 'Edit_Maintenance',
          path: '/editMaintenance',
          builder: (context, params) => const EditMaintenanceWidget(),
        ),
        FFRoute(
          name: 'EhSummary',
          path: '/ehSummary',
          builder: (context, params) => const EhSummaryWidget(),
        ),
        FFRoute(
          name: 'CarListScreen',
          path: '/carListScreen',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'CarListScreen')
              : NavBarPage(
                  initialPage: 'CarListScreen',
                  page: CarListScreenWidget(
                    filterValueParam: params.getParam(
                      'filterValueParam',
                      ParamType.String,
                    ),
                    carListFilterValueParam: params.getParam(
                      'carListFilterValueParam',
                      ParamType.String,
                    ),
                  ),
                ),
        ),
        FFRoute(
          name: 'TripInfoForm',
          path: '/tripInfoForm',
          builder: (context, params) => TripInfoFormWidget(
            selectedDeviceData: params.getParam(
              'selectedDeviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'Details47PropertyListing',
          path: '/details47PropertyListing',
          builder: (context, params) => const Details47PropertyListingWidget(),
        ),
        FFRoute(
          name: 'CommandsList',
          path: '/commandsList',
          builder: (context, params) => CommandsListWidget(
            deviceData: params.getParam(
              'deviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'PlaybackInput',
          path: '/playbackInput',
          builder: (context, params) => PlaybackInputWidget(
            selectedDeviceData: params.getParam(
              'selectedDeviceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'Details03TransactionsSummary',
          path: '/details03TransactionsSummary',
          builder: (context, params) => const Details03TransactionsSummaryWidget(),
        ),
        FFRoute(
          name: 'NotificationMap',
          path: '/notificationMap',
          builder: (context, params) => NotificationMapWidget(
            deviceName: params.getParam(
              'deviceName',
              ParamType.String,
            ),
            eventName: params.getParam(
              'eventName',
              ParamType.String,
            ),
            eventTime: params.getParam(
              'eventTime',
              ParamType.String,
            ),
            lat: params.getParam(
              'lat',
              ParamType.String,
            ),
            lon: params.getParam(
              'lon',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'lo',
          path: '/lo',
          builder: (context, params) => const LoWidget(),
        ),
        FFRoute(
          name: 'Forgot_Password',
          path: '/forgotPassword',
          builder: (context, params) => const ForgotPasswordWidget(),
        ),
        FFRoute(
          name: 'Setting',
          path: '/setting',
          builder: (context, params) => const SettingWidget(),
        ),
        FFRoute(
          name: 'more',
          path: '/more',
          builder: (context, params) =>
              params.isEmpty ? const NavBarPage(initialPage: 'more') : const MoreWidget(),
        ),
        FFRoute(
          name: 'ViewGeofence',
          path: '/viewGeofence',
          builder: (context, params) => ViewGeofenceWidget(
            geofenceData: params.getParam(
              'geofenceData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: 'PaymentPage',
          path: '/paymentPage',
          builder: (context, params) => const PaymentPageWidget(),
        ),
        FFRoute(
          name: 'UserEvents',
          path: '/userEvents',
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: UserEventsWidget(),
          ),
        ),
        FFRoute(
          name: 'EngineStartStop',
          path: '/engineStartStop',
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: EngineStartStopWidget(),
          ),
        ),
        FFRoute(
          name: 'CreateNotification',
          path: '/createNotification',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: CreateNotificationWidget(
              checkedValueData: params.getParam(
                'checkedValueData',
                ParamType.String,
              ),
              notificationType: params.getParam(
                'notificationType',
                ParamType.String,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'CreateUnits',
          path: '/createUnits',
          builder: (context, params) => NavBarPage(
            initialPage: '',
            page: CreateUnitsWidget(
              checkedValueData: params.getParam(
                'checkedValueData',
                ParamType.String,
              ),
              notificationType: params.getParam(
                'notificationType',
                ParamType.String,
              ),
              eventName: params.getParam(
                'eventName',
                ParamType.String,
              ),
            ),
          ),
        ),
        FFRoute(
          name: 'shareList',
          path: '/shareList',
          builder: (context, params) => const NavBarPage(
            initialPage: '',
            page: ShareListWidget(),
          ),
        ),
        FFRoute(
          name: 'CustomFields',
          path: '/customFields',
          builder: (context, params) => CustomFieldsWidget(
            deviceData: params.getParam(
              'deviceData',
              ParamType.JSON,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/splashScreen';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/dt-logo-png.png',
                      width: 250.0,
                      height: 250.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
