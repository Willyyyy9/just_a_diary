import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/color_palette.dart';

class HorizontalCalender extends StatefulWidget {
  final Function(DateTime dateTime) onTap;
  const HorizontalCalender({Key? key, required this.onTap}) : super(key: key);

  @override
  State<HorizontalCalender> createState() => _HorizontalCalenderState();
}

class _HorizontalCalenderState extends State<HorizontalCalender> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        reverse: true,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime.now();
          var newDate =
              DateTime(dateTime.year, dateTime.month, dateTime.day - index);

          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(newDate);
            },
            child: Container(
                height: 50,
                width: 60,
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: index == selectedIndex
                        ? ColorPalette.textColor
                        : Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      newDate.day.toString(),
                      style: TextStyle(
                          color: index == selectedIndex
                              ? ColorPalette.backgroundColor
                              : ColorPalette.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${DateFormat('EEE').format(newDate)} ",
                      style: TextStyle(
                        color: index == selectedIndex
                            ? ColorPalette.backgroundColor
                            : ColorPalette.textColor,
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
