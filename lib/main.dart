import 'package:diary/config/color_palette.dart';
import 'package:diary/config/constants.dart';
import 'package:diary/config/object_box.dart';
import 'package:diary/pages/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  Constants.configureLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just a Diary',
        theme: ThemeData(
            primaryColor: ColorPalette.backgroundColor,
            primaryTextTheme: GoogleFonts.latoTextTheme(Theme.of(context)
                .textTheme
                .apply(
                    bodyColor: ColorPalette.textColor,
                    displayColor: ColorPalette.textColor)),
            appBarTheme: Constants.appBarTheme,
            scaffoldBackgroundColor: ColorPalette.backgroundColor),
        builder: EasyLoading.init(),
        home: FutureBuilder<bool>(
          future: Constants.checkLockEnabledAndAuthenticate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {

              final isAuth = snapshot.data;
              if (isAuth!) {
                return const MainScreen();
              } else {
                return const MainScreen();
              }
            }
          },
        ));
  }
}
