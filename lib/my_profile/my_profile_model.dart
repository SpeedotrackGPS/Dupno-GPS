import '/backend/api_requests/api_calls.dart';
import '/components/profile_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_profile_widget.dart' show MyProfileWidget;
import 'package:flutter/material.dart';

class MyProfileModel extends FlutterFlowModel<MyProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get User Profile Data)] action in MyProfile widget.
  ApiCallResponse? userProfileDataRes;
  // Model for ProfileCard component.
  late ProfileCardModel profileCardModel;

  @override
  void initState(BuildContext context) {
    profileCardModel = createModel(context, () => ProfileCardModel());
  }

  @override
  void dispose() {
    profileCardModel.dispose();
  }
}
