import 'dart:math';

import 'package:expense_tracker/core/constants/colors.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarChartData());
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        backDrawRodData: BackgroundBarChartRodData(
            color: kGreyColor.shade300, toY: 5, show: true),
        gradient:
            LinearGradient(transform: const GradientRotation(pi / 40), colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.tertiary,
        ]),
      )
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(8, (index) {
      switch (index) {
        case 0:
          return makeGroupData(0, 2);
        case 1:
          return makeGroupData(1, 3);
        case 2:
          return makeGroupData(2, 2);
        case 3:
          return makeGroupData(3, 4.5);
        case 4:
          return makeGroupData(4, 3.8);
        case 5:
          return makeGroupData(5, 1.5);
        case 6:
          return makeGroupData(6, 4);
        case 7:
          return makeGroupData(7, 3.8);

        default:
          return throw Error();
      }
    });
  }

  BarChartData mainBarChartData() {
    return BarChartData(
        barGroups: showingGroups(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 35,
                  getTitlesWidget: leftTitle,
                  showTitles: true)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  getTitlesWidget: getTiles,
                  reservedSize: 35,
                  showTitles: true)),
        ));
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style =
        TextStyle(color: kGreyColor, fontWeight: FontWeight.bold, fontSize: 14);

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text(
          '01',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          '02',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          '03',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          '04',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          '05',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          '06',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          '07',
          style: style,
        );
        break;
      case 7:
        text = const Text(
          '08',
          style: style,
        );
        break;

      default:
        text = const Text(
          '',
          style: style,
        );
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitle(double value, TitleMeta meta) {
    const style =
        TextStyle(color: kGreyColor, fontWeight: FontWeight.bold, fontSize: 14);
    String text;
    if (value == 0) {
      text = '₹ 1K';
    } else if (value == 2) {
      text = '₹ 2K';
    } else if (value == 3) {
      text = '₹ 3K';
    } else if (value == 4) {
      text = '₹ 4K';
    } else if (value == 5) {
      text = '₹ 5K';
    } else {
      return const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
