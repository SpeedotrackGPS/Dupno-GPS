import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'commands_list_widget.dart' show CommandsListWidget;
import 'package:flutter/material.dart';

class CommandsListModel extends FlutterFlowModel<CommandsListWidget> {
  ///  Local state fields for this page.

  bool isLoading = true;

  List<dynamic> sentCommandsList = [];
  void addToSentCommandsList(dynamic item) => sentCommandsList.add(item);
  void removeFromSentCommandsList(dynamic item) =>
      sentCommandsList.remove(item);
  void removeAtIndexFromSentCommandsList(int index) =>
      sentCommandsList.removeAt(index);
  void insertAtIndexInSentCommandsList(int index, dynamic item) =>
      sentCommandsList.insert(index, item);
  void updateSentCommandsListAtIndex(int index, Function(dynamic) updateFn) =>
      sentCommandsList[index] = updateFn(sentCommandsList[index]);

  List<dynamic> execCommandsList = [];
  void addToExecCommandsList(dynamic item) => execCommandsList.add(item);
  void removeFromExecCommandsList(dynamic item) =>
      execCommandsList.remove(item);
  void removeAtIndexFromExecCommandsList(int index) =>
      execCommandsList.removeAt(index);
  void insertAtIndexInExecCommandsList(int index, dynamic item) =>
      execCommandsList.insert(index, item);
  void updateExecCommandsListAtIndex(int index, Function(dynamic) updateFn) =>
      execCommandsList[index] = updateFn(execCommandsList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get user Commands Exec)] action in CommandsList widget.
  ApiCallResponse? deviceExecCommandsRes;
  // Stores action output result for [Backend Call - API (get User Commands)] action in CommandsList widget.
  ApiCallResponse? sentCommandsRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
