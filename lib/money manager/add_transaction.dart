import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/db_helper.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  //
  int? amount;
  String note = 'Some note';
  String type = 'Income';
  DateTime selectedDate = DateTime.now();

  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  //
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023, 01),
      lastDate: DateTime(2100, 01),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.attach_money_rounded,
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    onChanged: (val) {
                      amount = int.parse(val);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.description_rounded,
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Transaction Notes',
                      ),
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      onChanged: (val) {
                        note = val;
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      inputFormatters: [
                        FilteringTextInputFormatter(
                          RegExp(r'[a-zA-Z]'),
                          allow: true,
                        )
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.moving_rounded,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                ChoiceChip(
                  label: Text(
                    'Income',
                    style: TextStyle(
                      fontSize: 16,
                      color: type == 'Income' ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: type == 'Income' ? true : false,
                  selectedColor: Colors.blueGrey,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = 'Income';
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                ChoiceChip(
                  label: Text(
                    'Expense',
                    style: TextStyle(
                      fontSize: 16,
                      color: type == 'Expense' ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: type == 'Expense' ? true : false,
                  selectedColor: Colors.blueGrey,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = 'Expense';
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  _selectedDate(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blueGrey,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.calendar_today,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      '${selectedDate.day} ${month[selectedDate.month - 1]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (amount != null && note.isNotEmpty) {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(
                      amount!,
                      selectedDate,
                      note,
                      type,
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                  } else {
                    print('Not all values provided');
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
