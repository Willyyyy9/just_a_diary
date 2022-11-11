import 'package:diary/config/constants.dart';
import 'package:diary/pages/statistics/widgets/bar_chart_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/color_palette.dart';
import 'mood_widget.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({Key? key, required this.entries}) : super(key: key);
  final List entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              const Text(
                "Entries according to mood",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textColor),
              ),
              const SizedBox(
                height: 16,
              ),
              BarChartWidget(
                entries: entries,
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                  runSpacing: 1,
                  children: Constants.moods
                      .map((mood) => MoodWidget(
                          moodName: mood['mood'], moodColor: mood['color']))
                      .toList()),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    const TextSpan(text: '* This statistic is based on '),
                    TextSpan(
                      text:
                          Constants.getMonthFullName(DateTime.now()).toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textColor),
                    ),
                    const TextSpan(text: ' only'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
