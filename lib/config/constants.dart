import 'dart:math';

import 'package:diary/config/local_auth.dart';
import 'package:diary/main.dart';
import 'package:diary/model/entry.dart';
import 'package:diary/pages/home/widgets/support_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/message.dart';
import 'color_palette.dart';

class Constants {
  static String isLockEnabledKey = "isLockEnabled";
  static String isDialogDisabledKey = "isDialogDisabled";
  static String dateTimeListKey = "dateTimeList";
  static String savedTitleKey = "savedTitle";
  static String savedMessageKey = "savedMessage";

  static bool? isLockEnabled;
  static bool? isSupportDialogDisabled = false;

  static void setStringForKey(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static void setBoolForKey(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  static void setStringListForKey(String key, List<String> value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(key, value);
  }

  static Future<List<String>> getStringListForKey(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key) ?? [];
  }

  static Future<String> getStringForKey(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  static void setIsLockEnabled(bool isLockEnabled) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(isLockEnabledKey, isLockEnabled);
  }

  static Future<bool?> getIsLockEnabled() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLockEnabledKey) ?? false;
  }

  static Future<bool> checkIfLockingIsPossible() async {
    return await LocalAuth.authenticate();
    
  }

  static Future<bool> checkLockEnabledAndAuthenticate() async {
    isLockEnabled = await getIsLockEnabled();
    if (isLockEnabled!) {
      return await LocalAuth.authenticate();
    } else {
      return false;
    }
  }

  static getOverallMood(BuildContext context) async {
    try {
      List entries = await objectBox.getMonthEntries().first;
      int counter = 0;
      for (Entry entry in entries) {
        if (entry.mood == "Depressed" ||
            entry.mood == "Anxious" ||
            entry.mood == "Sad") {
          counter++;
        }
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool isDialogDisabled =
          sharedPreferences.getBool(isDialogDisabledKey) ?? false;
      if (!isDialogDisabled) {
        Random random = Random();

        if (counter >= 3) {
          showDialog(
              context: context,
              builder: (context) {
                return SupportDialog(
                  message: Constants.messages[random.nextInt(messages.length)],
                );
              });
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static String formatMonth(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("MMM");
    return dateFormat.format(dateTime);
  }

  static String getMonthFullName(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("MMMM");
    return dateFormat.format(dateTime);
  }

  static int getMoodNumber(List entries, String mood) {
    int counter = 0;
    for (Entry entry in entries) {
      if (entry.mood == mood) {
        counter++;
      }
    }
    return counter;
  }

  static void configureLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..successWidget = const Icon(
        FontAwesomeIcons.circleCheck,
        color: ColorPalette.moodColor,
        size: 45,
      )
      ..errorWidget = const Icon(
        FontAwesomeIcons.circleExclamation,
        color: ColorPalette.textColor,
        size: 45,
      )
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = ColorPalette.textColor
      ..backgroundColor = ColorPalette.moodColor
      ..indicatorColor = ColorPalette.textColor
      ..textColor = ColorPalette.moodColor
      ..maskColor = Colors.black.withOpacity(0.5)
      ..fontSize = 18
      ..textPadding = const EdgeInsets.symmetric(vertical: 25)
      ..textStyle = GoogleFonts.cairo(
          color: ColorPalette.textColor,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))
      ..dismissOnTap = false;
  }

  static AppBarTheme appBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: ColorPalette.backgroundColor,
      titleTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.textColor.withOpacity(0.7),
              fontSize: 18)));

  static List moods = [
    {"mood": "Happy", "color": Colors.green[300]},
    {"mood": "Sad", "color": Colors.grey[300]},
    {"mood": "Angry", "color": Colors.red[300]},
    {"mood": "Anxious", "color": Colors.purple[300]},
    {"mood": "Proud", "color": Colors.yellow},
    {"mood": "Depressed", "color": Colors.blueGrey},
  ];

  static List<Message> messages = [
    Message(
        image: 'assets/images/tired.png',
        subtitle:
            "Rest a little. You've come a long way. Be proud of yourself.",
        title: "Rough couple of days?"),
    Message(
        image: 'assets/images/alone.png',
        subtitle: "You're not alone, it's just in your mind.",
        title: "A little bit down?"),
    Message(
        image: "assets/images/bee.png",
        title: "Friendly Bee Reminder",
        subtitle: "You are enough."),
    Message(
        image: "assets/images/tiredman.png",
        title: "Struggling a bit?",
        subtitle:
            "Order you favorite food and watch your favorite series you deserve to have some quality time with yourself"),
  ];
}
