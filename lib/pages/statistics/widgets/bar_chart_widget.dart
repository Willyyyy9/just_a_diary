import 'dart:math';

import 'package:diary/config/color_palette.dart';
import 'package:diary/config/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({Key? key, required this.entries}) : super(key: key);
  final List entries;

  double generateRandomNumber(int max) {
    Random random = Random();
    return random.nextInt(20).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: BarChart(
          swapAnimationDuration: const Duration(milliseconds: 300), // Optional
          swapAnimationCurve: Curves.linear,
          BarChartData(
              alignment: BarChartAlignment.center,
              maxY: entries.length.toDouble(),
              minY: 0,
              groupsSpace: 12,
              barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        Constants.moods[groupIndex]['mood'] + '\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (rod.toY).toInt().toString(),
                            style: TextStyle(
                              color: Constants.moods[groupIndex]['color'],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  )),
              borderData: FlBorderData(
                  border: const Border(
                      bottom:
                          BorderSide(width: 1.5, color: ColorPalette.textColor),
                      left: BorderSide(
                          width: 1.5, color: ColorPalette.textColor))),
              gridData: FlGridData(
                  drawVerticalLine: false,
                  checkToShowHorizontalLine: ((value) => value % 2 == 0),
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                        color: ColorPalette.textColor, strokeWidth: 0.6);
                  }),
              titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: entries.isEmpty
                          ? 1
                          : entries.length % 4 == 0
                              ? entries.length / 4
                              : 2,
                      reservedSize: 38,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      reservedSize: 38,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 38,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 38,
                    ),
                  )),
              barGroups: Constants.moods.map(
                (mood) {
                  return BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(
                        toY: Constants.getMoodNumber(entries, mood['mood'])
                            .toDouble(),
                        width: 20,
                        color: mood['color'],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  ]);
                },
              ).toList())),
    );
  }
}
