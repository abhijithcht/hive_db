import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_add.dart';
import 'home_edit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Box expenseBox;

  @override
  void initState() {
    super.initState();
    expenseBox = Hive.box('data_expense');
  }

  @override
  Widget build(BuildContext context) {
    deleteData(int index) {
      expenseBox.deleteAt(index);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Expense'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text(
                'Add transactions to View them',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: expenseBox.length,
                    itemBuilder: (context, index) {
                      var box = value;
                      var getData = box.getAt(index);

                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: Dismissible(
                          key: Key(getData.name),
                          background: Container(
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(
                              () {
                                deleteData(index);
                              },
                            );
                          },
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                  ),
                                  title: const Text(
                                    "Delete Expense",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  elevation: 0,
                                  content: const Text(
                                      "Are you sure you want to delete this item ?"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Yes,sure"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeEdit(
                                      index: index,
                                      data3: getData,
                                      nameController: getData.name,
                                      amountController: getData.amount,
                                      dateController: getData.date,
                                      timeController: getData.time,
                                      categories: getData.category,
                                    ),
                                  ),
                                );
                              },
                              leading: Text(
                                getData.category,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                  getData.date,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  getData.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              trailing: Text(
                                "\$${getData.amount}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              isThreeLine: true,
                              textColor: Colors.black,
                              iconColor: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdd(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
