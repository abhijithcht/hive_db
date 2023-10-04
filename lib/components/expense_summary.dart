import 'package:flutter/material.dart';
import 'package:hive_database/bar%20graph/bar_graph.dart';
import 'package:hive_database/data/expense_data.dart';
import 'package:hive_database/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  // calculate max amount in bar graph
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculationDailyExpenseSummary()[sunday] ?? 0,
      value.calculationDailyExpenseSummary()[monday] ?? 0,
      value.calculationDailyExpenseSummary()[tuesday] ?? 0,
      value.calculationDailyExpenseSummary()[wednesday] ?? 0,
      value.calculationDailyExpenseSummary()[thursday] ?? 0,
      value.calculationDailyExpenseSummary()[friday] ?? 0,
      value.calculationDailyExpenseSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest
    values.sort();
    // get largest amount(last)
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  // calculate the week total
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculationDailyExpenseSummary()[sunday] ?? 0,
      value.calculationDailyExpenseSummary()[monday] ?? 0,
      value.calculationDailyExpenseSummary()[tuesday] ?? 0,
      value.calculationDailyExpenseSummary()[wednesday] ?? 0,
      value.calculationDailyExpenseSummary()[thursday] ?? 0,
      value.calculationDailyExpenseSummary()[friday] ?? 0,
      value.calculationDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 0),
      ),
    );
    String monday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 1),
      ),
    );
    String tuesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 2),
      ),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 3),
      ),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 4),
      ),
    );
    String friday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 5),
      ),
    );
    String saturday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 6),
      ),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          // week total
          Row(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Week Total: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${calculateWeekTotal(
                  value,
                  sunday,
                  monday,
                  tuesday,
                  wednesday,
                  thursday,
                  friday,
                  saturday,
                )}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 240,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculationDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculationDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculationDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculationDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calculationDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculationDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculationDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
