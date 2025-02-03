import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _userApiKey = prefs.getString('ff_userApiKey') ?? _userApiKey;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_oneDayEventData')) {
        try {
          _oneDayEventData =
              jsonDecode(prefs.getString('ff_oneDayEventData') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _userName = prefs.getString('ff_userName') ?? _userName;
    });
    _safeInit(() {
      _selectedMapType = prefs.containsKey('ff_selectedMapType')
          ? deserializeEnum<Types>(prefs.getString('ff_selectedMapType'))
          : _selectedMapType;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userProfileData')) {
        try {
          _userProfileData =
              jsonDecode(prefs.getString('ff_userProfileData') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _password = prefs.getString('ff_password') ?? _password;
    });
    _safeInit(() {
      _showRouteOnTracking =
          prefs.getBool('ff_showRouteOnTracking') ?? _showRouteOnTracking;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _userApiKey = '';
  String get userApiKey => _userApiKey;
  set userApiKey(String value) {
    _userApiKey = value;
    prefs.setString('ff_userApiKey', value);
  }

  dynamic _allDeviceData;
  dynamic get allDeviceData => _allDeviceData;
  set allDeviceData(dynamic value) {
    _allDeviceData = value;
  }

  dynamic _oneDayEventData;
  dynamic get oneDayEventData => _oneDayEventData;
  set oneDayEventData(dynamic value) {
    _oneDayEventData = value;
    prefs.setString('ff_oneDayEventData', jsonEncode(value));
  }

  String _userName = 'demo';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
    prefs.setString('ff_userName', value);
  }

  List<String> _reportTypes = [
    'general',
    'drives_stops',
    'drives_stops_sensors',
    'drives_stops_logic',
    'travel_sheet',
    'travel_sheet_dn',
    'mileage_daily',
    'overspeed',
    'underspeed',
    'zone_in_out',
    'events',
    'service',
    'fuelfillings',
    'fuelthefts',
    'logic_sensors',
    'single_generator',
    'multi_generator',
    'speed_graph',
    'altitude_graph',
    'acc_graph',
    'fuellevel_graph',
    'temperature_graph',
    'sensor_graph',
    'routes',
    'routes_stops',
    'image_gallery',
    'general_merged',
    'general_analysis',
    'object_info',
    'current_position',
    'current_position_off',
    'rag',
    'rag_driver',
    'tasks',
    'rilogbook',
    'dtc',
    'expenses'
  ];
  List<String> get reportTypes => _reportTypes;
  set reportTypes(List<String> value) {
    _reportTypes = value;
  }

  void addToReportTypes(String value) {
    reportTypes.add(value);
  }

  void removeFromReportTypes(String value) {
    reportTypes.remove(value);
  }

  void removeAtIndexFromReportTypes(int index) {
    reportTypes.removeAt(index);
  }

  void updateReportTypesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    reportTypes[index] = updateFn(_reportTypes[index]);
  }

  void insertAtIndexInReportTypes(int index, String value) {
    reportTypes.insert(index, value);
  }

  dynamic _singleDeviceLocationData;
  dynamic get singleDeviceLocationData => _singleDeviceLocationData;
  set singleDeviceLocationData(dynamic value) {
    _singleDeviceLocationData = value;
  }

  String _selectedDeviceForData = '';
  String get selectedDeviceForData => _selectedDeviceForData;
  set selectedDeviceForData(String value) {
    _selectedDeviceForData = value;
  }

  LatLng? _tapped = const LatLng(35.1503787, 33.3410323);
  LatLng? get tapped => _tapped;
  set tapped(LatLng? value) {
    _tapped = value;
  }

  LatLng? _center = const LatLng(37.98381, 23.727539);
  LatLng? get center => _center;
  set center(LatLng? value) {
    _center = value;
  }

  List<MarkersNumberStruct> _markers = [
    MarkersNumberStruct.fromSerializableMap(jsonDecode(
        '{\"coordinates\":\"37.955654,23.698765\",\"value\":\"100\"}')),
    MarkersNumberStruct.fromSerializableMap(jsonDecode(
        '{\"coordinates\":\"37.98381,23.727539\",\"value\":\"20\"}')),
    MarkersNumberStruct.fromSerializableMap(
        jsonDecode('{\"coordinates\":\"38.05,23.83333\",\"value\":\"2.5\"}'))
  ];
  List<MarkersNumberStruct> get markers => _markers;
  set markers(List<MarkersNumberStruct> value) {
    _markers = value;
  }

  void addToMarkers(MarkersNumberStruct value) {
    markers.add(value);
  }

  void removeFromMarkers(MarkersNumberStruct value) {
    markers.remove(value);
  }

  void removeAtIndexFromMarkers(int index) {
    markers.removeAt(index);
  }

  void updateMarkersAtIndex(
    int index,
    MarkersNumberStruct Function(MarkersNumberStruct) updateFn,
  ) {
    markers[index] = updateFn(_markers[index]);
  }

  void insertAtIndexInMarkers(int index, MarkersNumberStruct value) {
    markers.insert(index, value);
  }

  dynamic _jsoon = jsonDecode(
      '{\"total\":12,\"available\":12,\"moving\":1,\"stopped\":10,\"idle\":1,\"online\":11,\"offline\":0,\"expired\":0,\"inactive\":0,\"active\":10,\"result\":[{\"imei\":\"350424066311786\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.172.173\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-09-06\",\"dt_server\":\"2024-03-12 22:30:08\",\"dt_tracker\":\"2024-03-12 22:30:02\",\"lat\":\"23.320172\",\"lng\":\"85.298173\",\"altitude\":\"661\",\"angle\":\"156\",\"speed\":0,\"params\":{\"gpslev\":\"18\",\"io239\":\"0\",\"io240\":\"0\",\"gsmlev\":\"3\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io247\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"13026\",\"io24\":\"0\",\"io67\":\"4071\",\"io9\":\"304\",\"io241\":\"40552\",\"io16\":\"21572016\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 22:14:47\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 22:14:33\",\"name\":\"Eco 3029\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"FMB920\",\"sim_number\":\"5754020284643\",\"model\":\"setdigout 1@setdigout 0\",\"vin\":\"\",\"plate_number\":\"JH 01EU 3029\",\"odometer\":\"18484.086121999393\",\"engine_hours\":\"820764\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Status\",\"type\":\"cust\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Fuel Level\",\"type\":\"fuel\",\"param\":\"io9\",\"value\":\"0.00\",\"value_full\":\"0.00 Liters\",\"icon\":\"https://www.speedotrack.in/theme/images/fuel.svg\"},{\"name\":\"Air Con\",\"type\":\"di\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/di.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 19 min 17 s\"},{\"imei\":\"350544505840549\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.164.179\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-08-01\",\"dt_server\":\"2024-03-12 22:33:55\",\"dt_tracker\":\"2024-03-12 22:33:50\",\"lat\":\"23.320115\",\"lng\":\"85.298217\",\"altitude\":\"668\",\"angle\":\"0\",\"speed\":0,\"params\":{\"gpslev\":\"8\",\"io239\":\"0\",\"io240\":\"0\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io2\":\"1\",\"io3\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io247\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"12797\",\"io67\":\"4048\",\"io9\":\"3845\",\"io6\":\"131\",\"io16\":\"107094\",\"io24\":\"0\",\"io241\":\"40552\",\"gsmlev\":\"4\",\"io113\":\"0\",\"pwrcut\":\"0\",\"shock\":\"0\",\"acc\":\"1\",\"arm\":\"0\",\"io21\":\"4\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-05 12:02:25\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-05 12:02:24\",\"name\":\"Restaurant Generator\",\"icon\":\"https://www.speedotrack.in/img/markers/m_8_.png\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"FMB120\",\"sim_number\":\"5754020017970\",\"model\":\"setdigout 0@setdigout 1\",\"vin\":\"Generator Flaves\",\"plate_number\":\"\",\"odometer\":\"83.29519500000022\",\"engine_hours\":\"1667485\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"gps\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/gps.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Engine Status\",\"type\":\"do\",\"param\":\"io179\",\"value\":0,\"value_full\":\"Locked\",\"icon\":\"https://www.speedotrack.in/theme/images/do.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Status\",\"type\":\"cust\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Electricity\",\"type\":\"di\",\"param\":\"io2\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/di.svg\"},{\"name\":\"Fuel Level\",\"type\":\"fuel\",\"param\":\"io9\",\"value\":\"0.00\",\"value_full\":\"0.00 Liters\",\"icon\":\"https://www.speedotrack.in/theme/images/fuel.svg\"},{\"name\":\"Generator\",\"type\":\"di\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/di.svg\"},{\"name\":\"engine hours\",\"type\":\"engh\",\"param\":\"io253\",\"value\":\"0.000\",\"value_full\":\"0.000\",\"icon\":\"https://www.speedotrack.in/theme/images/engine-hours.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 7 d 10 h 31 min 39 s\"},{\"imei\":\"350612076614799\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.159.165\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-07-21\",\"dt_server\":\"2024-03-12 22:34:00\",\"dt_tracker\":\"2024-03-12 22:33:52\",\"lat\":\"23.322497\",\"lng\":\"85.300512\",\"altitude\":\"666\",\"angle\":\"86\",\"speed\":0,\"params\":{\"gpslev\":\"17\",\"io239\":\"0\",\"io240\":\"0\",\"gsmlev\":\"5\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io247\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"12429\",\"io24\":\"0\",\"io67\":\"4049\",\"io9\":\"43\",\"io241\":\"40552\",\"io16\":\"4534947\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 22:17:53\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 22:16:59\",\"name\":\"JH 01 FE 1093 RED TVS\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"FMB920\",\"sim_number\":\"5754020018005\",\"model\":\"\",\"vin\":\"\",\"plate_number\":\"JH 01 FE 1093\",\"odometer\":\"4240.811977000016\",\"engine_hours\":\"1116504\",\"custom_fields\":[],\"address\":\"Nawatoli, Khejurtoli, Namkum, Ranchi, Jharkhand, 834002, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Engine Status\",\"type\":\"do\",\"param\":\"io179\",\"value\":0,\"value_full\":\"Unlocked\",\"icon\":\"https://www.speedotrack.in/theme/images/do.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Status\",\"type\":\"cust\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 16 min 11 s\"},{\"imei\":\"350612076617107\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.165.88\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-07-21\",\"dt_server\":\"2024-03-12 22:33:55\",\"dt_tracker\":\"2024-03-12 22:33:47\",\"lat\":\"23.306942\",\"lng\":\"85.277362\",\"altitude\":\"686\",\"angle\":\"245\",\"speed\":0,\"params\":{\"gpslev\":\"17\",\"io239\":\"0\",\"io240\":\"0\",\"gsmlev\":\"4\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io247\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"12589\",\"io24\":\"0\",\"io67\":\"4062\",\"io9\":\"174\",\"io241\":\"40552\",\"io16\":\"5384646\",\"io21\":\"3\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 18:55:22\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 18:46:33\",\"name\":\"JH 01TC 1586(Blue)\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"FMB920\",\"sim_number\":\"5754020018004\",\"model\":\"\",\"vin\":\"\",\"plate_number\":\"JH 01TC 1586\",\"odometer\":\"5081.881826000018\",\"engine_hours\":\"0\",\"custom_fields\":[],\"address\":\"Tangratoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Engine Status\",\"type\":\"do\",\"param\":\"io179\",\"value\":0,\"value_full\":\"Unlocked\",\"icon\":\"https://www.speedotrack.in/theme/images/do.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Status\",\"type\":\"cust\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 3 h 38 min 42 s\"},{\"imei\":\"351608082564043\",\"protocol\":\"concoxgt300\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.213.124\",\"port\":\"10214\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-10-27\",\"dt_server\":\"2024-03-12 22:18:05\",\"dt_tracker\":\"2024-03-12 07:52:38\",\"lat\":\"23.374336\",\"lng\":\"85.302836\",\"altitude\":\"0\",\"angle\":\"139\",\"speed\":0,\"params\":{\"gpslev\":\"11\",\"mcc\":\"0\",\"mnc\":\"0\",\"lac\":\"0\",\"cellid\":\"0\",\"acc\":\"1\",\"accv\":\"12.14\",\"track\":\"0\",\"bats\":\"1\",\"batl\":\"6\",\"gsmlev\":\"4\",\"pump\":\"0\",\"defense\":\"0\",\"defence\":\"0\",\"alarm\":\"0\"},\"loc_valid\":\"0\",\"dt_last_stop\":\"2024-03-12 07:52:23\",\"dt_last_idle\":\"2024-03-12 22:17:47\",\"dt_last_move\":\"2024-03-12 07:48:32\",\"name\":\"Yellow Activa\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/70_674a3a26349c701bec4ef40d0380ab02.png\",\"marker\":\"https://www.speedotrack.in//img/markers/off.svg\",\"device\":\"5754170163491\",\"sim_number\":\"5754170065667\",\"model\":\"\",\"vin\":\"RELAY,1#@RELAY,0#\",\"plate_number\":\"JH 01DH 9705\",\"odometer\":\"13456.834206000005\",\"engine_hours\":\"2908518\",\"custom_fields\":[],\"address\":\"Madhukam, Ranchi, Kanke, Ranchi, Jharkhand, 834005, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"acc\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"batl\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Defence\",\"type\":\"cust\",\"param\":\"defense\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Charging Status\",\"type\":\"cust\",\"param\":\"bats\",\"value\":0,\"value_full\":\"No\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"}],\"st\":\"Engine idle\",\"ststr\":\"Engine idle 16 min 17 s\"},{\"imei\":\"351608085141351\",\"protocol\":\"concoxgt800\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.191.10\",\"port\":\"10216\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2025-02-28\",\"dt_server\":\"2024-03-12 22:33:22\",\"dt_tracker\":\"2024-03-12 22:19:36\",\"lat\":\"23.319958\",\"lng\":\"85.297564\",\"altitude\":\"0\",\"angle\":\"0\",\"speed\":0,\"params\":{\"gpslev\":\"15\",\"mcc\":\"405\",\"mnc\":\"52\",\"lac\":\"1610\",\"cellid\":\"51259\",\"pump\":\"0\",\"track\":\"0\",\"bats\":\"1\",\"acc\":\"0\",\"defense\":\"0\",\"batl\":\"6\",\"accv\":\"12.77\",\"gsmlev\":\"4\",\"alarm\":\"0\",\"defence\":\"0\",\"iccid\":\"8991000903202772171F\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 22:19:13\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 22:15:29\",\"name\":\"Red Activa\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"We Track\",\"sim_number\":\"5754170062641\",\"model\":\"RELAY,1#@RELAY,0#\",\"vin\":\"Flaves\",\"plate_number\":\"JH 01CK 8990\",\"odometer\":\"61934.75018997483\",\"engine_hours\":\"6158853\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"acc\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"batl\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Charging Status\",\"type\":\"cust\",\"param\":\"bats\",\"value\":0,\"value_full\":\"No\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"accv\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 14 min 51 s\"},{\"imei\":\"352592574781308\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.174.160\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2025-02-22\",\"dt_server\":\"2024-03-12 22:33:13\",\"dt_tracker\":\"2024-03-12 22:33:07\",\"lat\":\"23.320193\",\"lng\":\"85.298077\",\"altitude\":\"670\",\"angle\":\"21\",\"speed\":0,\"params\":{\"gpslev\":\"17\",\"io239\":\"0\",\"io240\":\"0\",\"gsmlev\":\"3\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io247\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"12848\",\"io24\":\"0\",\"io67\":\"4043\",\"io9\":\"2776\",\"io241\":\"40552\",\"io16\":\"317833\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 21:58:18\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 21:57:44\",\"name\":\"Jeeto Tempo\",\"icon\":\"https://www.speedotrack.in/img/markers/m_3_.png\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"FMB920\",\"sim_number\":\"5754021415636\",\"model\":\"setdigout 1@setdigout 0\",\"vin\":\"\",\"plate_number\":\"\",\"odometer\":\"302.50261899999936\",\"engine_hours\":\"51331\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"gps\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/gps.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Engine Status\",\"type\":\"do\",\"param\":\"io179\",\"value\":0,\"value_full\":\"Unlocked\",\"icon\":\"https://www.speedotrack.in/theme/images/do.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Fuel Level\",\"type\":\"fuel\",\"param\":\"io9\",\"value\":\"10.00\",\"value_full\":\"10.00 Liters\",\"icon\":\"https://www.speedotrack.in/theme/images/fuel.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 35 min 46 s\"},{\"imei\":\"354017112561994\",\"protocol\":\"teltonikafm_old2\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.166.4\",\"port\":\"11919\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-09-17\",\"dt_server\":\"2024-03-12 22:33:07\",\"dt_tracker\":\"2024-03-12 22:33:03\",\"lat\":\"23.322602\",\"lng\":\"85.30048\",\"altitude\":\"664\",\"angle\":\"46\",\"speed\":0,\"params\":{\"gpslev\":\"16\",\"io239\":\"0\",\"io240\":\"0\",\"gsmlev\":\"3\",\"io200\":\"0\",\"io1\":\"0\",\"io179\":\"0\",\"io175\":\"-1\",\"io236\":\"0\",\"io252\":\"0\",\"io253\":\"0\",\"io66\":\"12605\",\"io24\":\"0\",\"io67\":\"3992\",\"io9\":\"87\",\"io241\":\"40552\",\"io16\":\"20653252\",\"io247\":\"0\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 22:07:04\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 22:05:16\",\"name\":\"Eco 7692\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"5754170276424\",\"sim_number\":\"5754020018014\",\"model\":\"0@0\",\"vin\":\"Flaves\",\"plate_number\":\"JH 01BE 7692\",\"odometer\":\"16129.29151099988\",\"engine_hours\":\"3244941\",\"custom_fields\":[],\"address\":\"Nawatoli, Khejurtoli, Namkum, Ranchi, Jharkhand, 834002, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"io239\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Internal Battery Voltage\",\"type\":\"batt\",\"param\":\"io67\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 Volt\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Engine Status\",\"type\":\"do\",\"param\":\"io179\",\"value\":0,\"value_full\":\"Unlocked\",\"icon\":\"https://www.speedotrack.in/theme/images/do.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"io252\",\"value\":0,\"value_full\":\"Present\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Status\",\"type\":\"cust\",\"param\":\"io66\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 27 min 0 s\"},{\"imei\":\"355172105371643\",\"protocol\":\"concoxgt800\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.183.148\",\"port\":\"10216\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-10-27\",\"dt_server\":\"2024-03-12 22:33:58\",\"dt_tracker\":\"2024-03-12 22:28:48\",\"lat\":\"23.320129\",\"lng\":\"85.297947\",\"altitude\":\"0\",\"angle\":\"159\",\"speed\":0,\"params\":{\"gpslev\":\"15\",\"mcc\":\"405\",\"mnc\":\"52\",\"lac\":\"1610\",\"cellid\":\"51259\",\"acc\":\"0\",\"alarm\":\"0\",\"pump\":\"0\",\"track\":\"1\",\"bats\":\"1\",\"defense\":\"0\",\"batl\":\"6\",\"accv\":\"13.1\",\"iccid\":\"89915222100050439812\",\"defence\":\"0\",\"gsmlev\":\"4\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 22:28:57\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 22:25:49\",\"name\":\"Blue Activa\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-red.svg\",\"device\":\"v5\",\"sim_number\":\"5754021874337\",\"model\":\"RELAY,1#@RELAY,0#\",\"vin\":\"Flaves Black Activa\",\"plate_number\":\"JJH 01DJ 6973\",\"odometer\":\"25859.219698999805\",\"engine_hours\":\"5312195\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"acc\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"batl\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Charging Status\",\"type\":\"cust\",\"param\":\"bats\",\"value\":0,\"value_full\":\"No\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"accv\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"}],\"st\":\"Stopped\",\"ststr\":\"Stopped 5 min 7 s\"},{\"imei\":\"355172105372898\",\"protocol\":\"concoxgt800\",\"net_protocol\":\"tcp\",\"ip\":\"106.209.164.173\",\"port\":\"10216\",\"active\":\"true\",\"object_expire\":\"true\",\"object_expire_dt\":\"2024-09-29\",\"dt_server\":\"2024-03-12 21:14:17\",\"dt_tracker\":\"2024-03-12 21:14:15\",\"lat\":\"23.32022\",\"lng\":\"85.298222\",\"altitude\":\"0\",\"angle\":\"248\",\"speed\":13,\"params\":{\"gpslev\":\"15\",\"mcc\":\"405\",\"mnc\":\"52\",\"lac\":\"1610\",\"cellid\":\"51259\",\"acc\":\"1\",\"alarm\":\"0\",\"accv\":\"63.66\",\"iccid\":\"89915242000068257964\",\"pump\":\"0\",\"track\":\"1\",\"bats\":\"1\",\"defense\":\"0\",\"batl\":\"6\",\"gsmlev\":\"4\"},\"loc_valid\":\"1\",\"dt_last_stop\":\"2024-03-12 19:46:01\",\"dt_last_idle\":\"0000-00-00 00:00:00\",\"dt_last_move\":\"2024-03-12 21:13:13\",\"name\":\"Okinawa Ridz New\",\"icon\":\"https://www.speedotrack.in/img/markers/objects/land-truck.svg\",\"marker\":\"https://www.speedotrack.in//img/markers/arrow-green.svg\",\"device\":\"V5\",\"sim_number\":\"5754020284633\",\"model\":\"\",\"vin\":\"\",\"plate_number\":\"\",\"odometer\":\"6826.786778999985\",\"engine_hours\":\"1634295\",\"custom_fields\":[],\"address\":\"Bhatitoli, Nagri, Ranchi, Jharkhand, 834004, India\",\"sensors\":[{\"name\":\"Ignition\",\"type\":\"acc\",\"param\":\"acc\",\"value\":0,\"value_full\":\"Off\",\"icon\":\"https://www.speedotrack.in/theme/images/engine.svg\"},{\"name\":\"GPS Signal\",\"type\":\"cust\",\"param\":\"gpslev\",\"value\":\"0.00\",\"value_full\":\"0.00 \",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Device Battery\",\"type\":\"cust\",\"param\":\"batl\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"GSM Level\",\"type\":\"gsm\",\"param\":\"gsmlev\",\"value\":0,\"value_full\":\"0 %\",\"icon\":\"https://www.speedotrack.in/theme/images/gsm.svg\"},{\"name\":\"Charging Status\",\"type\":\"cust\",\"param\":\"bats\",\"value\":0,\"value_full\":\"No\",\"icon\":\"https://www.speedotrack.in/theme/images/default-sensor.svg\"},{\"name\":\"Battery Level\",\"type\":\"batt\",\"param\":\"accv\",\"value\":\"0.00\",\"value_full\":\"0.00 %\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"},{\"name\":\"Battery Voltage\",\"type\":\"batt\",\"param\":\"accv\",\"value\":\"0.00\",\"value_full\":\"0.00 V\",\"icon\":\"https://www.speedotrack.in/theme/images/battery-lev-3.svg\"}],\"st\":\"Moving\",\"ststr\":\"Moving 1 h 20 min 51 s\"}]}');
  dynamic get jsoon => _jsoon;
  set jsoon(dynamic value) {
    _jsoon = value;
  }

  Types? _selectedMapType = Types.normal;
  Types? get selectedMapType => _selectedMapType;
  set selectedMapType(Types? value) {
    _selectedMapType = value;
    value != null
        ? prefs.setString('ff_selectedMapType', value.serialize())
        : prefs.remove('ff_selectedMapType');
  }

  String _carListFilterValue = 'All';
  String get carListFilterValue => _carListFilterValue;
  set carListFilterValue(String value) {
    _carListFilterValue = value;
  }

  String _startDate = '';
  String get startDate => _startDate;
  set startDate(String value) {
    _startDate = value;
  }

  String _endDate = '';
  String get endDate => _endDate;
  set endDate(String value) {
    _endDate = value;
  }

  dynamic _userProfileData;
  dynamic get userProfileData => _userProfileData;
  set userProfileData(dynamic value) {
    _userProfileData = value;
    prefs.setString('ff_userProfileData', jsonEncode(value));
  }

  String _deviceSearchValue = '';
  String get deviceSearchValue => _deviceSearchValue;
  set deviceSearchValue(String value) {
    _deviceSearchValue = value;
  }

  dynamic _valZero = jsonDecode('0');
  dynamic get valZero => _valZero;
  set valZero(dynamic value) {
    _valZero = value;
  }

  dynamic _doubleZero = jsonDecode('0');
  dynamic get doubleZero => _doubleZero;
  set doubleZero(dynamic value) {
    _doubleZero = value;
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    prefs.setBool('ff_isDarkMode', value);
  }

  List<String> _barLabelNames = ['Bar1', 'Bar2', 'Bar3', 'Bar4'];
  List<String> get barLabelNames => _barLabelNames;
  set barLabelNames(List<String> value) {
    _barLabelNames = value;
  }

  void addToBarLabelNames(String value) {
    barLabelNames.add(value);
  }

  void removeFromBarLabelNames(String value) {
    barLabelNames.remove(value);
  }

  void removeAtIndexFromBarLabelNames(int index) {
    barLabelNames.removeAt(index);
  }

  void updateBarLabelNamesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    barLabelNames[index] = updateFn(_barLabelNames[index]);
  }

  void insertAtIndexInBarLabelNames(int index, String value) {
    barLabelNames.insert(index, value);
  }

  List<String> _barLabelValues = ['10', '20', '30', '40'];
  List<String> get barLabelValues => _barLabelValues;
  set barLabelValues(List<String> value) {
    _barLabelValues = value;
  }

  void addToBarLabelValues(String value) {
    barLabelValues.add(value);
  }

  void removeFromBarLabelValues(String value) {
    barLabelValues.remove(value);
  }

  void removeAtIndexFromBarLabelValues(int index) {
    barLabelValues.removeAt(index);
  }

  void updateBarLabelValuesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    barLabelValues[index] = updateFn(_barLabelValues[index]);
  }

  void insertAtIndexInBarLabelValues(int index, String value) {
    barLabelValues.insert(index, value);
  }

  String _password = '123456';
  String get password => _password;
  set password(String value) {
    _password = value;
    prefs.setString('ff_password', value);
  }

  dynamic _containsMoving = jsonDecode('{\"m\":\"Moving\"}');
  dynamic get containsMoving => _containsMoving;
  set containsMoving(dynamic value) {
    _containsMoving = value;
  }

  dynamic _containsStopped = jsonDecode('{\"s\":\"Stopped\"}');
  dynamic get containsStopped => _containsStopped;
  set containsStopped(dynamic value) {
    _containsStopped = value;
  }

  dynamic _containsIdle = jsonDecode('{\"i\":\"Engine idle\"}');
  dynamic get containsIdle => _containsIdle;
  set containsIdle(dynamic value) {
    _containsIdle = value;
  }

  dynamic _containsCnOff = jsonDecode('{\"cn\":0}');
  dynamic get containsCnOff => _containsCnOff;
  set containsCnOff(dynamic value) {
    _containsCnOff = value;
  }

  dynamic _containsIgnitionOn = jsonDecode('{\"i\":\"1\"}');
  dynamic get containsIgnitionOn => _containsIgnitionOn;
  set containsIgnitionOn(dynamic value) {
    _containsIgnitionOn = value;
  }

  bool _isLoadingVehicleData = false;
  bool get isLoadingVehicleData => _isLoadingVehicleData;
  set isLoadingVehicleData(bool value) {
    _isLoadingVehicleData = value;
  }

  bool _showRouteOnTracking = true;
  bool get showRouteOnTracking => _showRouteOnTracking;
  set showRouteOnTracking(bool value) {
    _showRouteOnTracking = value;
    prefs.setBool('ff_showRouteOnTracking', value);
  }

  String _createGeofenceVertices = '';
  String get createGeofenceVertices => _createGeofenceVertices;
  set createGeofenceVertices(String value) {
    _createGeofenceVertices = value;
  }

  List<dynamic> _expiringDevicesList = [];
  List<dynamic> get expiringDevicesList => _expiringDevicesList;
  set expiringDevicesList(List<dynamic> value) {
    _expiringDevicesList = value;
  }

  void addToExpiringDevicesList(dynamic value) {
    expiringDevicesList.add(value);
  }

  void removeFromExpiringDevicesList(dynamic value) {
    expiringDevicesList.remove(value);
  }

  void removeAtIndexFromExpiringDevicesList(int index) {
    expiringDevicesList.removeAt(index);
  }

  void updateExpiringDevicesListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    expiringDevicesList[index] = updateFn(_expiringDevicesList[index]);
  }

  void insertAtIndexInExpiringDevicesList(int index, dynamic value) {
    expiringDevicesList.insert(index, value);
  }

  dynamic _deviceListForOptions;
  dynamic get deviceListForOptions => _deviceListForOptions;
  set deviceListForOptions(dynamic value) {
    _deviceListForOptions = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
