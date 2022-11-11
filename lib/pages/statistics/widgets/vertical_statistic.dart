import 'package:flutter/material.dart';

class VerticalStatistic extends StatelessWidget {
  const VerticalStatistic(
      {Key? key, required this.title, required this.statistic})
      : super(key: key);
  final String title;
  final String statistic;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(title),
      const SizedBox(
        height: 10,
      ),
      Text(
        statistic,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
