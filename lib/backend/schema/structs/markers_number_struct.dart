// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MarkersNumberStruct extends BaseStruct {
  MarkersNumberStruct({
    LatLng? coordinates,
    String? value,
  })  : _coordinates = coordinates,
        _value = value;

  // "coordinates" field.
  LatLng? _coordinates;
  LatLng? get coordinates => _coordinates;
  set coordinates(LatLng? val) => _coordinates = val;

  bool hasCoordinates() => _coordinates != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  static MarkersNumberStruct fromMap(Map<String, dynamic> data) =>
      MarkersNumberStruct(
        coordinates: data['coordinates'] as LatLng?,
        value: data['value'] as String?,
      );

  static MarkersNumberStruct? maybeFromMap(dynamic data) => data is Map
      ? MarkersNumberStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'coordinates': _coordinates,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'coordinates': serializeParam(
          _coordinates,
          ParamType.LatLng,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static MarkersNumberStruct fromSerializableMap(Map<String, dynamic> data) =>
      MarkersNumberStruct(
        coordinates: deserializeParam(
          data['coordinates'],
          ParamType.LatLng,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MarkersNumberStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MarkersNumberStruct &&
        coordinates == other.coordinates &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([coordinates, value]);
}

MarkersNumberStruct createMarkersNumberStruct({
  LatLng? coordinates,
  String? value,
}) =>
    MarkersNumberStruct(
      coordinates: coordinates,
      value: value,
    );
