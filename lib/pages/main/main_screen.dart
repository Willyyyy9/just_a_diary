import 'package:diary/config/constants.dart';

import 'package:diary/pages/calender/calender_screen.dart';
import 'package:diary/pages/home/home_screen.dart';
import 'package:diary/pages/main/widgets/post_button.dart';
import 'package:diary/pages/statistics/statistics_screen.dart';
import 'package:diary/pages/terms/terms_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../config/color_palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    CalenderScreen(),
    StatisticsScreen(),
    TermsScreen()
  ];

  void handleLock() async {
    bool isPossible = await Constants.checkIfLockingIsPossible();
    if (isPossible) {
      Constants.setIsLockEnabled(!Constants.isLockEnabled!);
      Constants.isLockEnabled = await Constants.getIsLockEnabled();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Diary",
              style: TextStyle(
                  color: ColorPalette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          actions: [
            InkWell(
                onTap: () async {
                  Constants.isLockEnabled = await Constants.getIsLockEnabled();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: ColorPalette.moodColor,
                          content: Text(
                            Constants.isLockEnabled!
                                ? "Your Diary will open without your fingerprint."
                                : "Your Diary will open with your fingerprint.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.textColor,
                              fontSize: 28,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  handleLock();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  Constants.isLockEnabled! ? "Unlock" : "Lock",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.textColor,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.textColor,
                                  ),
                                ))
                          ],
                        );
                      });
                },
                child: Icon(
                  Constants.isLockEnabled! ? Icons.lock : Icons.lock_open,
                  color: ColorPalette.textColor,
                )),
            const PostButton(),
          ],
        ),
        bottomNavigationBar: FloatingNavbar(
          backgroundColor: Colors.white,
          selectedBackgroundColor: ColorPalette.buttonColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: ColorPalette.textColor,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
          },
          currentIndex: bottomIndex,
          items: [
            FloatingNavbarItem(
              icon: Icons.home,
            ),
            FloatingNavbarItem(
              icon: Icons.calendar_month,
            ),
            FloatingNavbarItem(
              icon: Icons.bar_chart,
            ),
            FloatingNavbarItem(
              icon: Icons.article_outlined,
            ),
          ],
        ),
        body: screens[bottomIndex]);
  }
}
