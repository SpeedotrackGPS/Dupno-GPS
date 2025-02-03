import '/flutter_flow/flutter_flow_util.dart';
import 'engine_lock_unsupported_widget.dart' show EngineLockUnsupportedWidget;
import 'package:flutter/material.dart';

class EngineLockUnsupportedModel
    extends FlutterFlowModel<EngineLockUnsupportedWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
