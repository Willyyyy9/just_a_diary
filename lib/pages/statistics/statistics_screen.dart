import 'package:diary/main.dart';
import 'package:diary/model/entry.dart';
import 'package:diary/pages/statistics/widgets/chart_card.dart';

import 'package:diary/pages/statistics/widgets/number_of_entries.dart';

import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Entry>>(
        stream: objectBox.getMonthEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List entries = snapshot.data ?? [];
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NumberOfEntries(
                      entriesNumber: entries.length,
                    ),
                    ChartCard(
                      entries: entries,
                    )
                  ]),
            );
          }
        });
  }
}
