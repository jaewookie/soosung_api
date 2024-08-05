import 'package:flutter/material.dart';

class NetworkModel with ChangeNotifier {
  String? startUrl;
  String? comPort;
  String? endPoint;
  String? targetAdr;
  String navUrl = "cmd/nav_point";
  String chgUrl = "cmd/charge";
  String stpUrl = "cmd/cancel_goal";
  String rsmUrl = "cmd/resume_nav";
  String positionURL = "reeman/android_target";
  String moveBaseStatusUrl = 'reeman/movebase_status';
  List<String>? getPoseData;
  String? currentGoal;

  dynamic getApiData;

  String? servTable;

  dynamic APIGetData;
  dynamic APIPostData;

  NetworkModel(
      {this.getPoseData, this.currentGoal, this.comPort, this.startUrl, this.endPoint, this.targetAdr});

  void APITargetAdr() {
    targetAdr = "http://$startUrl:$comPort/$endPoint";
    notifyListeners();
  }
}
