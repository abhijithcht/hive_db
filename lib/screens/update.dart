import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/screens/read.dart';

import '../model/model.dart';

class UpdateScreen extends StatefulWidget {
  final int? index;
  final Data? data;
  final titleController;
  final descriptionController;

  const UpdateScreen(
      {super.key,
      this.index,
      this.data,
      this.titleController,
      this.descriptionController});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late final Box dataBox;
  late final TextEditingController title_Controller;
  late final TextEditingController description_Controller;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('data_box');
    title_Controller = TextEditingController(text: widget.titleController);
    description_Controller =
        TextEditingController(text: widget.descriptionController);
  }

  _updateData() {
    Data newData = Data(
      title: title_Controller.text,
      description: description_Controller.text,
    );
    dataBox.putAt(widget.index!, newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Screen', style: TextStyle(fontSize: 26)),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          TextField(
            controller: title_Controller,
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: description_Controller,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              _updateData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadScreen(),
                ),
              );
            },
            child: const Text('UPDATE DATA'),
          ),
        ],
      ),
    );
  }
}
