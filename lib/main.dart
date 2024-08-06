import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:soosung_api/Providers/NetworkModel.dart';

import 'Screens/MainScreen.dart';

void main() async {
  Permission.location.request();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => NetworkModel(
              startUrl: 'IP',
              comPort: 'PORT',
              endPoint: 'ENDPOINT',
              targetAdr: 'tata',
              getPoseData: [],
              apiKeyBody: {},
            )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soosung API TEST Web',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          // scaffoldBackgroundColor: const Color(0xff191919),
          // textTheme: TextTheme(
          //   //영어폰트용
          //   titleLarge: GoogleFonts.roboto(
          //       color: const Color(0xffF0F0F0), fontSize: 45),
          //   titleMedium: GoogleFonts.roboto(
          //       color: const Color(0xffB7B7B7), fontSize: 32),
          //   bodyLarge: GoogleFonts.roboto(
          //       color: const Color(0xffB7B7B7), fontSize: 28),
          //   bodyMedium: GoogleFonts.roboto(
          //       color: const Color(0xffB7B7B7), fontSize: 24),
          //   bodySmall: GoogleFonts.roboto(
          //       color: const Color(0xffB7B7B7), fontSize: 20),
          //
          //   //한글폰트용
          //   displayLarge: const TextStyle(
          //     fontFamily: 'kor',
          //     fontWeight: FontWeight.bold,
          //     fontSize: 90,
          //     color: Color(0xffF0F0F0),
          //   ),
          //
          //   displayMedium: const TextStyle(
          //       fontFamily: 'kor',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 85,
          //       color: Color(0xffF0F0F0)),
          //
          //   displaySmall: const TextStyle(
          //       fontFamily: 'kor',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 65,
          //       color: Color(0xffF0F0F0)),
          //   // 네비게이션모듈 : 배경 글씨, 목적지명
          //
          //   headlineLarge: const TextStyle(
          //       fontFamily: 'kor',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 40,
          //       color: Color(0xffF0F0F0)),
          //
          //   headlineMedium: const TextStyle(
          //       fontFamily: 'kor',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20,
          //       color: Color(0xffF0F0F0)),
          //
          //   headlineSmall: const TextStyle(
          //       fontFamily: 'kor',
          //       fontWeight: FontWeight.bold,
          //       fontSize: 30,
          //       color: Color(0xffF0F0F0)),
          // ),
        ),
        home: const MainScreen(),
      ),
    ),
  );
}