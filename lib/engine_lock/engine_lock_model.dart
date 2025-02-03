import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'engine_lock_widget.dart' show EngineLockWidget;
import 'package:flutter/material.dart';

class EngineLockModel extends FlutterFlowModel<EngineLockWidget> {
  ///  Local state fields for this page.

  List<String> lockUnlockCommands = [];
  void addToLockUnlockCommands(String item) => lockUnlockCommands.add(item);
  void removeFromLockUnlockCommands(String item) =>
      lockUnlockCommands.remove(item);
  void removeAtIndexFromLockUnlockCommands(int index) =>
      lockUnlockCommands.removeAt(index);
  void insertAtIndexInLockUnlockCommands(int index, String item) =>
      lockUnlockCommands.insert(index, item);
  void updateLockUnlockCommandsAtIndex(int index, Function(String) updateFn) =>
      lockUnlockCommands[index] = updateFn(lockUnlockCommands[index]);

  bool isVehicleLocked = true;

  bool isLoading = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get user Commands Exec)] action in EngineLock widget.
  ApiCallResponse? getDeviceCommandsRes;
  bool lockauth = false;
  // Stores action output result for [Backend Call - API (Gprs Command Engine lock unlock)] action in Button widget.
  ApiCallResponse? getGpsCommandRes;
  // Stores action output result for [Backend Call - API (Gprs Command Engine lock unlock)] action in Button widget.
  ApiCallResponse? getGpsCommandResUnlock;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
