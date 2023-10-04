import 'package:flutter/cupertino.dart';
import 'package:hive_database/data/hive_database.dart';
import 'package:hive_database/datetime/date_time_helper.dart';
import 'package:hive_database/model/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // prepare data to display
  final db = HiveDatabase();

  void prepareData() {
    // if there exists data, get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // //update
  // void updateItem(int index, ExpenseItem editExpense) {
  //   final box = Hive.box<ExpenseItem>('expense_database');
  //   overallExpenseList.insert(index, editExpense);
  //   notifyListeners();
  // }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon,tue,etc...) from a dateTime object
  String getDayname(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayname(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  convert overall list of expenses into a daily expense summary

  e.g.
   overallExpenseList =

   [
   [food,23/08/23,$80],
   [drinks,24/08/23,$60],
   [food,25/08/23,$80],
   [drinks,24/08/23,$60],
   [food,26/08/23,$180],
   [drinks,27/08/23,$70],
   ]

   ->
   DailyExpenseSummary =
   [
   [230823:$80],
   [240823:$120],
   [250823:$80],
   [260823:$180],
   [270823:$70],
   ]

   */

  Map<String, double> calculationDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date (yyyymmdd) : amountTotalForDay
    };
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
