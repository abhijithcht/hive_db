// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_database/screens/update.dart';
import 'package:hive_flutter/adapters.dart';

import 'create.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
  }

  @override
  Widget build(BuildContext context) {
    _deleteData(int index) {
      dataBox.deleteAt(index);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Screen', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateScreen(),
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('Database Is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: dataBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var getData = box.getAt(index);

                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            index: index,
                            data: getData,
                            titleController: getData.title,
                            descriptionController: getData.description,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    getData.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(getData.description,
                      style: const TextStyle(fontSize: 16)),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteData(index);
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
