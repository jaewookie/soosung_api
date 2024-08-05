import 'package:flutter/material.dart';

class MainScreenButtons extends StatefulWidget {
  final int? screens;

  const MainScreenButtons({
    super.key,
    this.screens,
  });

  @override
  State<MainScreenButtons> createState() => _MainScreenButtonsState();
}

class _MainScreenButtonsState extends State<MainScreenButtons> {
  // // late NetworkModel _networkProvider;

  // late var screenList = List<Widget>.empty();
  // late var serviceList = List<Widget>.empty();

  late var homeButtonName = List<String>.empty();

  double pixelRatio = 0.75;

  late var buttonNum = 0;
  late List<String> buttonName;
  late List<double> buttonPositionWidth;
  late List<double> buttonPositionHeight;
  late List<double> buttonSize;

  late double buttonRadius;

  late List<double> buttonSize1;
  late List<double> buttonSize2;

  late int buttonNumbers;

  int buttonWidth = 0;
  int buttonHeight = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // screenList = [
    //   const ServiceScreenFinal(),
    //   const LinkConnectorScreen(),
    //   const AdminScreen(),
    //   const ConfigScreen()
    // ];
    // serviceList = [ShippingMenuFinal(), TraySelectionFinal(), HotelServiceMenu()];
  }

  @override
  Widget build(BuildContext context) {
    // // _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    if (widget.screens == 0) {
      // 메인 화면
      buttonNum = 8;

      buttonSize = [350, 130];

      buttonName = [
        "Task Generation",
        "Task Operation",
        "Heartbeat Setting",
        "Query Task Status",
        "Query Device Status",
        "Device Control",
        "Attribute Settings",
        "WCS/EV"
      ];

      buttonRadius = 30;
    }

    return Stack(children: [
      Container(
        margin: EdgeInsets.fromLTRB(30, 15, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < buttonNum; i++)
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.redAccent),
                        borderRadius:
                            BorderRadius.circular(buttonRadius * pixelRatio)),
                    fixedSize: Size(buttonSize[buttonWidth] * pixelRatio,
                        buttonSize[buttonHeight] * pixelRatio)),
                onPressed: () {},
                child: Text(buttonName[i],
                    style: TextStyle(fontSize: 30, color: Colors.black), textAlign: TextAlign.center,),
              ),
          ],
        ),
      ),
    ]);
  }
}
