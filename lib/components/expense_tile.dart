import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';
import '../model/expense_item.dart';

class ExpenseTile extends StatefulWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  final newExpenseNameController2 = TextEditingController();
  final newExpenseAmountController2 = TextEditingController();

  void save() {
    if (newExpenseNameController2.text.isNotEmpty &&
        newExpenseAmountController2.text.isNotEmpty) {
      // create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController2.text,
        amount: newExpenseAmountController2.text,
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
    newExpenseNameController2.clear();
    newExpenseAmountController2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            label: 'Delete',
            padding: const EdgeInsets.only(top: 12),
            onPressed: widget.deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(
            autoClose: true,
            label: 'Edit',
            padding: const EdgeInsets.only(top: 12),
            onPressed: null,
            icon: Icons.edit,
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.black,
            borderRadius: BorderRadius.circular(8),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: ListTile(
          splashColor: Colors.redAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              widget.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              '\$${widget.amount}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                backgroundColor: Colors.blueGrey[300],
                title: const Text('Add new expense'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //expense name
                    TextField(
                      autofocus: true,
                      controller: newExpenseNameController2,
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
                      controller: newExpenseAmountController2,
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
                    child: const Text('Update'),
                  ),
                  //cancel button
                  MaterialButton(
                    onPressed: cancel,
                    child: const Text('Cancel'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
