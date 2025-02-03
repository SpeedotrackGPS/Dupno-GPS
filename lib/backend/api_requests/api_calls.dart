import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Php Api Group Group Code

class PhpApiGroupGroup {
  static String getBaseUrl() => 'https://www.dupnotracker.com/';
  static Map<String, String> headers = {};
  static PhpLoginApiCall phpLoginApiCall = PhpLoginApiCall();
  static PhpGetUserAPIKeyCall phpGetUserAPIKeyCall = PhpGetUserAPIKeyCall();
  static PhpGetUserObjectsCall phpGetUserObjectsCall = PhpGetUserObjectsCall();
  static GetSingleObjectDataCall getSingleObjectDataCall =
      GetSingleObjectDataCall();
  static TestLargeDeviceCall testLargeDeviceCall = TestLargeDeviceCall();
  static FnConnectLOGINTRACKINGApiCall fnConnectLOGINTRACKINGApiCall =
      FnConnectLOGINTRACKINGApiCall();
  static PhpGetEventsOneDayCall phpGetEventsOneDayCall =
      PhpGetEventsOneDayCall();
  static HistoryRouteCall historyRouteCall = HistoryRouteCall();
  static GprsCommandEngineLockUnlockCall gprsCommandEngineLockUnlockCall =
      GprsCommandEngineLockUnlockCall();
  static DeviceGeneralInfoCall deviceGeneralInfoCall = DeviceGeneralInfoCall();
  static GetDeviceHistoryCall getDeviceHistoryCall = GetDeviceHistoryCall();
  static GetUserCommandsExecCall getUserCommandsExecCall =
      GetUserCommandsExecCall();
  static ReportsDownloadCall reportsDownloadCall = ReportsDownloadCall();
  static ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static GetUserProfileDataCall getUserProfileDataCall =
      GetUserProfileDataCall();
  static PlaybackTestHistoryRouteCall playbackTestHistoryRouteCall =
      PlaybackTestHistoryRouteCall();
  static NewPlaybackHistoryRouteCall newPlaybackHistoryRouteCall =
      NewPlaybackHistoryRouteCall();
  static DeviceTripInfoCall deviceTripInfoCall = DeviceTripInfoCall();
  static PlaybackTestAfterErrorCall playbackTestAfterErrorCall =
      PlaybackTestAfterErrorCall();
  static GetUserCommandsCall getUserCommandsCall = GetUserCommandsCall();
  static UpdateOdometerCall updateOdometerCall = UpdateOdometerCall();
  static UpdateEngineHourCall updateEngineHourCall = UpdateEngineHourCall();
  static UpdateCostAndMileageCall updateCostAndMileageCall =
      UpdateCostAndMileageCall();
  static UpdateIconCall updateIconCall = UpdateIconCall();
  static GetMaintainenceListCall getMaintainenceListCall =
      GetMaintainenceListCall();
  static AddMaintainenceCall addMaintainenceCall = AddMaintainenceCall();
  static GetZonesListCall getZonesListCall = GetZonesListCall();
  static AddZonesCall addZonesCall = AddZonesCall();
  static GetEventsCall getEventsCall = GetEventsCall();
  static AddEventCall addEventCall = AddEventCall();
  static ActivateUserEventCall activateUserEventCall = ActivateUserEventCall();
  static DeleteMaintainenceCall deleteMaintainenceCall =
      DeleteMaintainenceCall();
}

class PhpLoginApiCall {
  Future<ApiCallResponse> call({
    String? username = 'flaves',
    String? password = '123456',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Php Login Api',
      apiUrl:
          '${baseUrl}login.php?username=$username&password=$password&mobile=false',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PhpGetUserAPIKeyCall {
  Future<ApiCallResponse> call({
    String? usernameForApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Php Get User API key',
      apiUrl:
          '${baseUrl}api/api.php?api=server&ver=1.0&key=2C805608B18ED88096531BC30C8F1008&cmd=GET_USER_API_KEY,$usernameForApiKey',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PhpGetUserObjectsCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Php Get User Objects',
      apiUrl:
          '${baseUrl}api/api.php?api=user&ver=1.0&key=$userApiKey&cmd=USER_GET_OBJECTS&s=352503092775862',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSingleObjectDataCall {
  Future<ApiCallResponse> call({
    String? deviceImeiForData = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get SingleObject Data',
      apiUrl:
          '${baseUrl}api/api.php?api=user&ver=1.0&key=0F81DB92DEA0BA1240375BE6EBB97677&cmd=OBJECT_GET_LOCATIONS,$deviceImeiForData;',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TestLargeDeviceCall {
  Future<ApiCallResponse> call({
    String? apiKey = '',
    int? pageNumber = 1,
    String? rows = '1000',
    String? fv = 'total',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'test large device',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$apiKey&cmd=USER_GET_OBJECTS&page=$pageNumber&rows=$rows&sidx=name&sord=ASC&ff=status&fv=$fv',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FnConnectLOGINTRACKINGApiCall {
  Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'fn Connect LOGIN TRACKING Api',
      apiUrl: '${baseUrl}func/fn_connect.php',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'cmd': "login",
        'mobile': "false",
        'remember_me': "true",
        'username': username,
        'password': password,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PhpGetEventsOneDayCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '0F81DB92DEA0BA1240375BE6EBB97677',
    int? pageNumber = 1,
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Php Get Events One Day',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=OBJECT_GET_LAST_EVENTS&page=$pageNumber&rows=20',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class HistoryRouteCall {
  Future<ApiCallResponse> call({
    String? userApiKey = 'DE94E9E4F69FFCBAF1820F61BA8B8564',
    String? deviceImeiForHistoryData = '350544505840549',
    String? startDate = '2024-03-03 00:00:00',
    String? endDate = '2024-04-03 00:00:00',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'History Route',
      apiUrl:
          '${baseUrl}api/api.php?api=user&ver=1.0&key=$userApiKey&cmd=OBJECT_GET_ROUTE,$deviceImeiForHistoryData,$startDate,$endDate,5',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GprsCommandEngineLockUnlockCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImeiForLockUnlock = '',
    String? lockUnlockCommandForDevice = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Gprs Command Engine lock unlock',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=OBJECT_CMD_GPRS',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': "Comand",
        'type': "ascii",
        'cmd': lockUnlockCommandForDevice,
        'imei': deviceImeiForLockUnlock,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeviceGeneralInfoCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImeiForInfo = '',
    String? dateFrom = '',
    String? dateTo = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'deviceGeneralInfo',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=REPORT_GENERAL',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': deviceImeiForInfo,
        'dtf': dateFrom,
        'dtt': dateTo,
        'speed_limit': "60",
        'stop_duration': "1",
        'data_items':
            "route_start,route_end,route_length,move_duration,stop_duration,stop_count,top_speed,avg_speed,overspeed_count,fuel_consumption,avg_fuel_consumption,fuel_cost,engine_work,engine_idle,odometer,engine_hours,driver,trailer",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDeviceHistoryCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? reportName = '',
    String? reportType = '',
    String? reportFormat = '',
    String? deviceImeiForReport = '',
    String? dateFrom = '',
    String? dateTo = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Device History',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=REPORT',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'report_id': "4",
        'name': reportName,
        'type': reportType,
        'ignore_empty_reports': false,
        'format': reportFormat,
        'show_coordinates': true,
        'show_addresses': false,
        'zones_addresses': false,
        'stop_duration': 1,
        'speed_limit': 80,
        'imei': deviceImeiForReport,
        'marker_ids': "1",
        'zone_ids': "1",
        'sensor_names': "1",
        'data_items':
            "route_start,route_end,route_length,move_duration,stop_duration,stop_count,top_speed,avg_speed,overspeed_count,fuel_consumption,avg_fuel_consumption,fuel_cost,engine_work,engine_idle,odometer,engine_hours,driver,trailer",
        'other': "1",
        'schedule_period': "1",
        'schedule_email_address': "1",
        'dtf': dateFrom,
        'dtt': dateTo,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserCommandsExecCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImeiForCommandList = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get user Commands Exec',
      apiUrl:
          '${baseUrl}api/api.php?api=user&ver=1.0&key=$userApiKey&cmd=OBJECT_GET_CMD_EXEC,$deviceImeiForCommandList',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ReportsDownloadCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? reportName = '',
    String? reportType = '',
    String? reportFormat = '',
    bool? ignoreEmptyReports,
    bool? showCoordinates = true,
    bool? showAddresses,
    bool? zoneAddresses,
    int? stopDuration = 1,
    int? speedLimit = 80,
    String? selectedVehicleForReport = '',
    String? markerIdForReport = '',
    String? zoneIdForReport = '',
    String? sensorNamesForReport = '',
    String? dataItems =
        'route_start,route_end,route_length,move_duration,stop_duration,stop_count,top_speed,avg_speed,overspeed_count,fuel_consumption,avg_fuel_consumption,fuel_cost,engine_work,engine_idle,odometer,engine_hours,driver,trailer',
    String? otherItemsForReport = '',
    String? schedulePeriod = '',
    String? scheduleEmailAddresses = '',
    String? dateFrom = '',
    String? dateTo = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Reports Download',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=REPORT',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': reportName,
        'type': reportType,
        'format': reportFormat,
        'ignore_empty_reports': ignoreEmptyReports,
        'show_coordinates': showCoordinates,
        'show_addresses': showAddresses,
        'zones_addresses': zoneAddresses,
        'stop_duration': stopDuration,
        'speed_limit': speedLimit,
        'imei': selectedVehicleForReport,
        'marker_ids': markerIdForReport,
        'zone_ids': zoneIdForReport,
        'sensor_names': sensorNamesForReport,
        'data_items': dataItems,
        'other': otherItemsForReport,
        'schedule_period': schedulePeriod,
        'schedule_email_address': scheduleEmailAddresses,
        'dtf': dateFrom,
        'dtt': dateTo,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ChangePasswordCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? oldPassword = '',
    String? newPassword = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'change Password',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=CHANGE_PASSWORD',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserProfileDataCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get User Profile Data',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=GET_USER_PROFILE',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PlaybackTestHistoryRouteCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImei = '',
    String? startDate = '',
    String? endDate = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'PlaybackTestHistoryRoute',
      apiUrl:
          '$baseUrl/api.php?api=user&ver=1.0&key=EA65D4BA8273DCF57F82E5AB84D611A4&cmd=OBJECT_GET_ROUTE%2C111111111111111%2C1jan%2000%3A00%3A00%2C10june%2000%3A00%3A00%2C1',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class NewPlaybackHistoryRouteCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImei = '',
    String? dateFrom = '',
    String? dateTo = '',
    String? minStopDuration = '2',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'NewPlaybackHistoryRoute',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=LOAD_ROUTE_DATA',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': deviceImei,
        'dtf': dateFrom,
        'dtt': dateTo,
        'min_stop_duration': minStopDuration,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeviceTripInfoCall {
  Future<ApiCallResponse> call({
    String? apiKey = '',
    String? deviceImei = '',
    String? startDate = '',
    String? endDate = '',
    String? stops = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Device Trip Info',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$apiKey&cmd=OBJECT_GET_TRIPS,$deviceImei,$startDate,$endDate,$stops',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PlaybackTestAfterErrorCall {
  Future<ApiCallResponse> call({
    String? apiKey = '',
    String? selectedDeviceImei = '',
    String? startDate = '',
    String? endDate = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'PlaybackTestAfterError',
      apiUrl:
          '${baseUrl}api/api.php?api=user&ver=1.0&key=$apiKey&cmd=OBJECT_GET_ROUTE,$selectedDeviceImei,$startDate,$endDate,1',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserCommandsCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImei = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get User Commands',
      apiUrl:
          '$baseUrl/api/api.php?api=user&ver=1.0&key=$userApiKey&cmd=OBJECT_GET_CMDS,$deviceImei',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateOdometerCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImei = '',
    String? odometerValue = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Update Odometer',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=EDIT_OBJECT_ODOMETER',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': deviceImei,
        'odometer': odometerValue,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateEngineHourCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? deviceImei = '',
    String? engineHourValue = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Update Engine Hour',
      apiUrl:
          '$baseUrl/api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=EDIT_OBJECT_ENGINE_HOUR',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': deviceImei,
        'engine_hours': engineHourValue,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateCostAndMileageCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? selectedDeviceImei = '',
    String? fuelCost = '',
    String? mileage = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Update Cost and Mileage',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=EDIT_OBJECT_FUEL_COST_AND_MILEAGE',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': selectedDeviceImei,
        'cost': fuelCost,
        'mileage': mileage,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateIconCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? selectedDeviceImei = '',
    String? iconString = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Update Icon',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=EDIT_OBJECT_ICON',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imei': selectedDeviceImei,
        'icon': iconString,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetMaintainenceListCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Maintainence List',
      apiUrl:
          '$baseUrl/api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=USER_GET_MAINTENANCE,*',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddMaintainenceCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? name = '',
    String? imeis = '',
    bool? dataList,
    bool? popup,
    bool? odo,
    String? odoInterval = '',
    String? odoLast = '',
    bool? engh,
    String? enghInterval = '',
    String? enghLast = '',
    bool? days,
    String? daysInterval = '',
    String? daysLast = '',
    bool? odoLeft,
    String? odoLeftNum = '',
    bool? daysLeft,
    String? daysLeftNum = '',
    bool? updateLast,
    bool? enghLeft,
    String? enghLeftNum = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Add Maintainence',
      apiUrl:
          '$baseUrl/api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=USER_ADD_MAINTENANCE',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': name,
        'imeis': imeis,
        'data_list': dataList,
        'popup': popup,
        'odo': odo,
        'odo_interval': odoInterval,
        'odo_last': odoLast,
        'engh': engh,
        'engh_interval': enghInterval,
        'engh_last': enghLast,
        'days': days,
        'days_interval': daysInterval,
        'days_last': daysLast,
        'odo_left': odoLeft,
        'odo_left_num': odoLeftNum,
        'engh_left': enghLeft,
        'engh_left_num': enghLeftNum,
        'days_left': daysLeft,
        'days_left_num': daysLeftNum,
        'update_last': updateLast,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetZonesListCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'get Zones List',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=USER_GET_ZONES',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddZonesCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? zoneName = '',
    String? zoneVertices = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Add Zones',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=USER_ADD_ZONE',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'name': zoneName,
        'vertices': zoneVertices,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetEventsCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get Events',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=GET_USER_EVENTS',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddEventCall {
  Future<ApiCallResponse> call({
    String? type = '',
    String? userApiKey = '',
    String? name = '',
    bool? active = true,
    String? imei = '',
    String? checkedValue = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Add Event ',
      apiUrl:
          '${baseUrl}api/api.php?ver=1.0&api=mobile&key=$userApiKey&cmd=SAVE_EVENT',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'type': type,
        'notify_push': true,
        'imei': imei,
        'checked_value': checkedValue,
        'day_time':
            "{\"dt\":false,\"mon\":false,\"mon_from\":\"00:00\",\"mon_to\":\"24:00\",\"tue\":false,\"tue_from\":\"00:00\",\"tue_to\":\"24:00\",\"wed\":false,\"wed_from\":\"00:00\",\"wed_to\":\"24:00\",\"thu\":false,\"thu_from\":\"00:00\",\"thu_to\":\"24:00\",\"fri\":false,\"fri_from\":\"00:00\",\"fri_to\":\"24:00\",\"sat\":false,\"sat_from\":\"00:00\",\"sat_to\":\"24:00\",\"sun\":false,\"sun_from\":\"00:00\",\"sun_to\":\"24:00\"}",
        'name': name,
        'active': active,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ActivateUserEventCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? eventId = '',
    bool? active = true,
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Activate User Event',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=ACTIVATE_USER_EVENT',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'event_id': eventId,
        'active': active,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteMaintainenceCall {
  Future<ApiCallResponse> call({
    String? userApiKey = '',
    String? serviceId = '',
  }) async {
    final baseUrl = PhpApiGroupGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'delete Maintainence',
      apiUrl:
          '${baseUrl}api/api.php?api=mobile&ver=1.0&key=$userApiKey&cmd=USER_DELETE_MAINTENANCE',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'service_id': serviceId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Php Api Group Group Code

class WhatshappMessageCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? phoneNo = '',
    String? address = '',
    String? vehicleType = '',
  }) async {
    final ffApiRequestBody = '''
{
  "apiKey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NGUyYWU5Y2FkYzg1MWQzNDQxMzEwNSIsIm5hbWUiOiJTcGVlZG90cmFjayBHUFMgUHJpdmF0ZSBMaW1pdGVkIDk1OTIiLCJhcHBOYW1lIjoiQWlTZW5zeSIsImNsaWVudElkIjoiNjY0ZTJhZTljYWRjODUxZDM0NDEzMGZlIiwiYWN0aXZlUGxhbiI6IkJBU0lDX01PTlRITFkiLCJpYXQiOjE3MTY2NTg2NTV9.XAD69emYFZxia_n9Y38mSiIQ6iE9suJIXPQkna149V4",
  "campaignName": "dupno",
  "destination": "+8801700787000",
  "userName": "Speedotrack GPS Private Limited 9592",
  "templateParams": [
    "${escapeStringForJson(name)}",
    "${escapeStringForJson(phoneNo)}",
    "${escapeStringForJson(address)}",
    "${escapeStringForJson(vehicleType)}"
  ],
  "source": "new-landing-page form",
  "media": {
    "url": "https://whatsapp-media-library.s3.ap-south-1.amazonaws.com/IMAGE/6353da2e153a147b991dd812/5442184_confidentmansuit.png"
  },
  "buttons": [],
  "carouselCards": [],
  "location": {}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Whatshapp message',
      apiUrl: 'https://backend.aisensy.com/campaign/t1/api/v2',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
