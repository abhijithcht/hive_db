import 'package:flutter/material.dart';
import 'package:hive_database/todo/todo_create.dart';
import 'package:hive_flutter/adapters.dart';

import 'todo_update.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late final Box noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box('data_box');
  }

  @override
  Widget build(BuildContext context) {
    deleteData(int index) {
      noteBox.deleteAt(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 26,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.deepOrange,
      ),
      body: ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text(
                'Notes are empty',
              ),
            );
          } else {
            return ListView.builder(
              itemCount: noteBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var getData = box.getAt(index);

                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoUpdate(
                            index: index,
                            data: getData,
                            titleController: getData.title,
                            bodyController: getData.description,
                          ),
                        ),
                      );
                    },
                    splashColor: Colors.blue,
                    dense: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                    visualDensity: const VisualDensity(
                      vertical: 3,
                    ),
                    tileColor: Colors.amberAccent,
                    textColor: Colors.black,
                    iconColor: Colors.black,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodoUpdate(
                              index: index,
                              data: getData,
                              titleController: getData.title,
                              bodyController: getData.description,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                    title: Text(
                      getData.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'Kalam',
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      getData.description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Kalam',
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteData(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 130,
        child: FittedBox(
          child: FloatingActionButton.extended(
            foregroundColor: Colors.black,
            isExtended: true,
            icon: const Icon(Icons.add_circle),
            backgroundColor: Colors.blue,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoCreate(),
                ),
              );
            },
            label: const Text(
              'Create',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Kalam',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
