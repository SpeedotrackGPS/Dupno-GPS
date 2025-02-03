import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  // Start initial custom actions code
  await actions.onesignal();
  // End initial custom actions code

  await FlutterFlowTheme.initialize();

  await authManager.initialize();
  await FFLocalizations.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = FFLocalizations.getStoredLocale();

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  late Stream<DupnoGPSProAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = dupnoGPSProAuthUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
    FFLocalizations.storeLocale(language);
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dupno GPS Pro',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
        Locale('hi'),
        Locale('ar'),
        Locale('fr'),
        Locale('de'),
        Locale('vi'),
        Locale('ur'),
        Locale('nl'),
        Locale('id'),
        Locale('it'),
        Locale('fa'),
        Locale('ru'),
        Locale('ro'),
        Locale('pt'),
        Locale('es'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(false),
          trackVisibility: WidgetStateProperty.all(false),
          interactive: true,
        ),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(false),
          trackVisibility: WidgetStateProperty.all(false),
          interactive: true,
        ),
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Home';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': const HomeWidget(),
      'CarListScreen': const CarListScreenWidget(),
      'Multiple_Fleet': const MultipleFleetWidget(),
      'Alert': const AlertWidget(),
      'more': const MoreWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        color: FlutterFlowTheme.of(context).secondaryText,
        activeColor: FlutterFlowTheme.of(context).primary,
        tabBackgroundColor: FlutterFlowTheme.of(context).secondary,
        tabBorderRadius: 100.0,
        tabMargin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        gap: 0.0,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        duration: const Duration(milliseconds: 500),
        haptic: false,
        tabs: [
          GButton(
            icon: Icons.home,
            text: FFLocalizations.of(context).getText(
              'so979lph' /*  Home  */,
            ),
            iconSize: 22.0,
          ),
          GButton(
            icon: Icons.assignment,
            text: FFLocalizations.of(context).getText(
              '6d8darht' /* List View */,
            ),
            textStyle: GoogleFonts.getFont(
              'Roboto',
              color: FlutterFlowTheme.of(context).primary,
              fontWeight: FontWeight.w500,
            ),
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.location_on,
            text: FFLocalizations.of(context).getText(
              'wv9wtov2' /* Map View */,
            ),
            iconSize: 24.0,
          ),
          GButton(
            icon: currentIndex == 3
                ? Icons.notifications_rounded
                : Icons.notifications_rounded,
            text: FFLocalizations.of(context).getText(
              'q07g2hhg' /*  Alert */,
            ),
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.dashboard_customize,
            text: FFLocalizations.of(context).getText(
              '5frnblne' /* More */,
            ),
            iconSize: 24.0,
          )
        ],
      ),
    );
  }
}
