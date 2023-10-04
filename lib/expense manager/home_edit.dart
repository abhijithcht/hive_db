import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/model.dart';

class HomeEdit extends StatefulWidget {
  final int? index;
  final Data3? data3;
  final dynamic nameController;
  final dynamic amountController;
  final dynamic dateController;
  final dynamic timeController;

  final String categories;

  const HomeEdit({
    super.key,
    this.index,
    this.data3,
    required this.nameController,
    required this.amountController,
    required this.dateController,
    required this.timeController,
    required this.categories,
  });

  @override
  State<HomeEdit> createState() => _HomeEditState();
}

class _HomeEditState extends State<HomeEdit> {
  final GlobalKey<FormState> textkey = GlobalKey<FormState>();
  late final Box expenseBox;
  TextEditingController nameController2 = TextEditingController();
  TextEditingController amountController2 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  TextEditingController timeController2 = TextEditingController();
  late String categories2;

  @override
  void dispose() {
    nameController2.dispose();
    amountController2.dispose();
    dateController2.dispose();
    timeController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    expenseBox = Hive.box('data_expense');
    nameController2 = TextEditingController(text: widget.nameController);
    amountController2 = TextEditingController(text: widget.amountController);
    dateController2 = TextEditingController(text: widget.dateController);
    timeController2 = TextEditingController(text: widget.timeController);
    categories = widget.categories.toString();
  }

  _updateData() {
    Data3 newData = Data3(
      name: nameController2.text,
      amount: amountController2.text,
      date: dateController2.text,
      time: timeController2.text,
      category: categories,
    );
    expenseBox.putAt(widget.index!, newData);
  }

  String categories = 'Food';

  var items3 = [
    'Food',
    'Transport',
    'Household',
    'Education',
    'Beauty',
    'Gift',
    'Internet',
    'Balance',
    'Accessories',
    'Rent',
    'Loan',
    'Shopping',
    'Salary',
    'Allowance',
    'Return',
    'Refund',
    'Investment',
    'Other'
  ];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Edit Expenses'),
        centerTitle: true,
        backgroundColor: Colors.black,
        // foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: textkey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  controller: nameController2,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabled: true,
                    hintText: 'Transaction Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => (value!.isEmpty)
                      ? 'Transaction Name cannot be empty'
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 50,
                  left: 50,
                ),
                child: TextFormField(
                  controller: amountController2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabled: true,
                    hintText: 'Transaction Amount',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Transaction Amount cannot be empty'
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  controller: dateController2,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    picked != null && picked != selectedDate
                        ? {
                            setState(
                              () {
                                selectedDate = picked;
                              },
                            )
                          }
                        : null;
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Date cannot be empty' : null,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabled: true,
                    hintText: 'Select Date',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.date_range_rounded,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  controller: timeController2,
                  onTap: () async {
                    var pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );

                    if (pickedTime != null) {
                      if (mounted) {
                        timeController2.text = pickedTime.format(context);
                      }
                    }
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Time cannot be empty' : null,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabled: true,
                    hintText: 'Select Time',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  value: categories,
                  items: items3.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      categories = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      textkey.currentState!.validate() &&
                              nameController2.text.isNotEmpty &&
                              amountController2.text.isNotEmpty &&
                              dateController2.text.isNotEmpty &&
                              timeController2.text.isNotEmpty
                          ? Navigator.pop(context)
                          : null;
                      nameController2.text.isNotEmpty &&
                              amountController2.text.isNotEmpty &&
                              dateController2.text.isNotEmpty &&
                              timeController2.text.isNotEmpty
                          ? _updateData()
                          : null;
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
