import 'package:diary/config/color_palette.dart';
import 'package:diary/config/constants.dart';
import 'package:diary/pages/entry%20list/entry_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';


class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List? dateTimeList = [];
  Future getDateTimeList() async {
    dateTimeList =
        await Constants.getStringListForKey(Constants.dateTimeListKey);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDateTimeList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final events = {
              for (String dateTimeString in dateTimeList!)
                DateTime(
                  DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeString))
                      .year,
                  DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeString))
                      .month,
                  DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeString))
                      .day,
                ): [
                  CleanCalendarEvent(
                    "View all entries for this day",
                    color: Colors.orange,
                    isAllDay: false,
                    startTime: DateTime(
                      DateTime.fromMillisecondsSinceEpoch(
                              int.parse(dateTimeString))
                          .year,
                      DateTime.fromMillisecondsSinceEpoch(
                              int.parse(dateTimeString))
                          .month,
                      DateTime.fromMillisecondsSinceEpoch(
                              int.parse(dateTimeString))
                          .day,
                    ),
                    endTime: DateTime(
                        DateTime.fromMillisecondsSinceEpoch(
                                int.parse(dateTimeString))
                            .year,
                        DateTime.fromMillisecondsSinceEpoch(
                                int.parse(dateTimeString))
                            .month,
                        DateTime.fromMillisecondsSinceEpoch(
                                int.parse(dateTimeString))
                            .day,
                        23,
                        59),
                  )
                ]
            };

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.75,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Calendar(
                            startOnMonday: true,
                            isExpanded: true,
                            onEventSelected: (event) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EntryListScreen(
                                        dateTime: event.startTime,
                                      )));
                            },
                            events: events,
                            onRangeSelected: (range) {},
                            onDateSelected: (date) {},
                            isExpandable: true,
                            locale: 'en_En',
                            todayButtonText: 'Today',
                            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                            eventColor: ColorPalette.buttonColor,
                            selectedColor: ColorPalette.buttonColor,
                            dayOfWeekStyle: const TextStyle(
                                color: ColorPalette.textColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 11),
                          ),
                        ),
                      ),
                    )
                  ]),
            );
          }
        });
  }
}
