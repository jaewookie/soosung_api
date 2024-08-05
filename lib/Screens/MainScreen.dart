import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soosung_api/Utills/callApi.dart';

import '../Providers/NetworkModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.parsePoseData}) : super(key: key);
  final dynamic parsePoseData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late NetworkModel _networkProvider;

  final TextEditingController configController = TextEditingController();

  // late SharedPreferences _prefs;

  late var buttonNum = 0;
  late List<String> buttonName;
  late List<double> buttonSize;
  late double buttonRadius;

  int portIdx = 0;
  int buttonWidth = 0;
  int buttonHeight = 1;

  late List<String> comPorts;
  late List<String> endPoints;

  String? hostUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initSharedPreferences();
    _updateData();
  }

  // // SharedPreferences 초기화 함수
  // Future<void> _initSharedPreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }

  void _updateData() async {
    // _prefs.clear();
    // if (_prefs.getString('robotIp') != null) {
    //   _networkProvider.startUrl = _prefs.getString('robotIp');
    // }
    // if (_prefs.getBool('robotInit') == null) {
    //   robotInit = false;
    // } else {
    //   robotInit = _prefs.getBool('robotInit')!;
    // }
    // _networkProvider.hostIP();
    getting(_networkProvider.targetAdr!, true);

    await Future.delayed(const Duration(milliseconds: 500));
  }

  dynamic getting(String apiAdr, bool jsonMap) async {
    // String apiAddress = hostIP + comPortNum + "/" + endPoint + "/";
    String apiAddress = apiAdr;
    String jsonDataParse = "";
    // print('$apiAddress');

    NetworkGet network = NetworkGet(apiAddress);

    dynamic getApiData = await network.getAPI();

    if (jsonMap == true) {
      _networkProvider.getApiData = getApiData;
    } else {
      jsonDataParse = jsonEncode(getApiData);
      jsonDataParse = jsonDataParse.splitMapJoin(
          '{',
          onMatch: (Match m) {
            return '${m[0]!}' + '\n';
          },
          onNonMatch: (String n) {
            return n + '';
          });
      jsonDataParse = jsonDataParse.splitMapJoin(
          '},',
          onMatch: (Match m) {
            return '${m[0]!}' + '\n';
          },
          onNonMatch: (String n) {
            return n + '';
          });
      jsonDataParse = jsonDataParse.splitMapJoin(
          ',',
          onMatch: (Match m) {
            return '${m[0]!}' + '\n';
          },
          onNonMatch: (String n) {
            return n + '';
          });
      jsonDataParse = jsonDataParse.splitMapJoin(
          '}',
          onMatch: (Match m) {
            return '${m[0]!}' + '';
          },
          onNonMatch: (String n) {
            return n + '\n';
          });

      _networkProvider.getApiData = jsonDataParse;

      // _networkProvider.getApiData = jsonEncode(getApiData);

    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _networkProvider = Provider.of<NetworkModel>(context, listen: false);

    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    hostUrl = "http://ip:port/services/";

    buttonNum = 8;

    buttonSize = [200, 50];

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

    comPorts = ['1000', '2000', '3000'];
    // app : 1000, wcs : 2000, wms : 3000
    endPoints = [
      'genAgvSchedulingTask',
      'Task Operation',
      'healthyBeat',
      'queryTaskStatus',
      'queryDeviceStatus',
      'deviceControl',
      'deviceParamSet',
      'lift_operation'
    ];

    buttonRadius = 30;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: buttonSize[buttonHeight] * 1.1,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child: Container(
            width: (4 * buttonSize[buttonWidth]) / 3 + 20,
            height: buttonSize[buttonHeight],
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // verticalDirection: VerticalDirection.up,
                children: [
                  Container(
                    height: buttonSize[buttonHeight],
                    width: buttonSize[buttonWidth],
                    child: TextField(
                      controller: configController,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      showCursor: true,
                      cursorColor: Colors.white,
                      onSubmitted: (value) {
                        // _prefs.setString(
                        //     'robotIp', value);
                        setState(() {
                          _networkProvider.startUrl = value;
                          // _networkProvider.hostIP();
                        });
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FilledButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _networkProvider.startUrl = configController.text;
                          // _networkProvider.hostIP();
                        });
                      });
                      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      //     overlays: []);
                    },
                    style: FilledButton.styleFrom(
                        enableFeedback: false,
                        fixedSize: Size(buttonSize[buttonWidth] / 3,
                            buttonSize[buttonHeight]),
                        backgroundColor: const Color.fromRGBO(80, 80, 255, 0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ]),
          ),
        ),
        leadingWidth: ((4 * buttonSize[buttonWidth]) / 3 + 20) * 1.1,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Text(
              "API Target Address : [${_networkProvider.targetAdr}]",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight,
        ),
        child: Stack(children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 30, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < buttonNum; i++)
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(buttonRadius)),
                        fixedSize: Size(
                            buttonSize[buttonWidth], buttonSize[buttonHeight])),
                    onPressed: () {
                      // setState(() {
                      //   _networkProvider.targetAdr =
                      //   "https://reqres.in/api/users/${i + 1}";
                      // });
                      setState(() {
                        // API 테스트 후 수정 및 적용 할 부분
                        _networkProvider.comPort = comPorts[portIdx];
                        _networkProvider.endPoint = endPoints[i];
                        _networkProvider.APITargetAdr();
                        portIdx++;
                        if(portIdx == 3){
                          portIdx = 0;
                        }
                      });
                      getting(_networkProvider.targetAdr!, false);
                    },
                    child: Text(
                      buttonName[i],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: Text(
                      '${_networkProvider.getApiData}',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )),
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}
