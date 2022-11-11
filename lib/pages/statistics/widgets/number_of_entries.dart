import 'package:diary/config/constants.dart';
import 'package:diary/pages/statistics/widgets/vertical_statistic.dart';
import 'package:flutter/material.dart';

class NumberOfEntries extends StatelessWidget {
  const NumberOfEntries({Key? key, required this.entriesNumber})
      : super(key: key);
  final int entriesNumber;

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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            VerticalStatistic(
                title: "Month",
                statistic: Constants.formatMonth(DateTime.now())),
            const SizedBox(
                height: 80, child: VerticalDivider(color: Colors.grey)),
            VerticalStatistic(
                title: "Days", statistic: DateTime.now().day.toString()),
            const SizedBox(
                height: 80, child: VerticalDivider(color: Colors.grey)),
            VerticalStatistic(
                title: "Entries", statistic: entriesNumber.toString()),
          ]),
        ),
      ),
    );
  }
}
