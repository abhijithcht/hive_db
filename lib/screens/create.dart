import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/model/model.dart';

import 'read.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final Box dataBox;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
  }

  _createData() {
    Data newData = Data(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    dataBox.add(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CreateScreen',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _descriptionController,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              _createData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadScreen(),
                ),
              );
            },
            child: const Text('ADD DATA'),
          ),
        ],
      ),
    );
  }
}
