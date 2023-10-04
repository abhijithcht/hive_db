import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_database/components/expense_summary.dart';
import 'package:hive_database/components/expense_tile.dart';
import 'package:hive_database/data/expense_data.dart';
import 'package:hive_database/model/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[200],
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              autofocus: true,
              controller: newExpenseNameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              inputFormatters: [
                FilteringTextInputFormatter(
                  RegExp(r'[a-zA-Z]'),
                  allow: true,
                )
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Expense Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            //expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  // //update
  // updateItem() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       elevation: 0,
  //       backgroundColor: Colors.blueGrey[200],
  //       title: const Text('Add new expense'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           //expense name
  //           TextField(
  //             autofocus: true,
  //             controller: newExpenseNameController,
  //             keyboardType: TextInputType.text,
  //             textCapitalization: TextCapitalization.sentences,
  //             inputFormatters: [
  //               FilteringTextInputFormatter(
  //                 RegExp(r'[a-zA-Z]'),
  //                 allow: true,
  //               )
  //             ],
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               hintText: 'Expense Name',
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 12,
  //           ),
  //           //expense amount
  //           TextField(
  //             controller: newExpenseAmountController,
  //             keyboardType: TextInputType.number,
  //             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               hintText: 'Amount',
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         // save button
  //         MaterialButton(
  //           onPressed: update,
  //           child: const Text('Update'),
  //         ),
  //         //cancel button
  //         MaterialButton(
  //           onPressed: cancel,
  //           child: const Text('Cancel'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // // update
  // void update() {
  //   if (newExpenseNameController.text.isNotEmpty &&
  //       newExpenseAmountController.text.isNotEmpty) {
  //     // create expense item
  //     ExpenseItem newExpense = ExpenseItem(
  //       name: newExpenseNameController.text,
  //       amount: newExpenseAmountController.text,
  //       dateTime: DateTime.now(),
  //     );
  //     //add the new expense
  //     Provider.of<ExpenseData>(context, listen: false).updateItem(
  //       index,
  //       ExpenseItem(
  //         name: newExpenseNameController.text,
  //         amount: newExpenseAmountController.text,
  //         dateTime: DateTime.now(),
  //       ),
  //     );
  //   }
  //   Navigator.pop(context);
  //   clear();
  // }

  // save
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      //add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.blueGrey[200],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              // weekly summary
              ExpenseSummary(
                startOfWeek: value.startOfWeekDate(),
              ),

              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped: ((p0) => deleteExpense(
                        value.getAllExpenseList()[index],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
