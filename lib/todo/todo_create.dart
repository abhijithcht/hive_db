import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/todo/todo_view.dart';

import '../model/model.dart';

class TodoCreate extends StatefulWidget {
  const TodoCreate({Key? key}) : super(key: key);

  @override
  State<TodoCreate> createState() => _TodoCreateState();
}

class _TodoCreateState extends State<TodoCreate> {
  late FocusNode title;
  late FocusNode notes;

  @override
  void dispose() {
    title.dispose();
    notes.dispose();
    super.dispose();
  }

  late final Box noteBox;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    title = FocusNode();
    notes = FocusNode();
    noteBox = Hive.box('data_box');
  }

  _createData() {
    Data newData = Data(
      title: titleController.text,
      description: bodyController.text,
    );

    noteBox.add(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              _createData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoView(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
            ),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              focusNode: title,
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Kalam',
                color: Colors.black,
              ),
              maxLines: 1,
              controller: titleController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Title',
              ),
              onSubmitted: (term) {
                title.unfocus();
                FocusScope.of(context).requestFocus(notes);
              },
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Kalam',
                color: Colors.black,
              ),
              textCapitalization: TextCapitalization.sentences,
              focusNode: notes,
              textInputAction: TextInputAction.done,
              maxLines: null,
              controller: bodyController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Note',
              ),
            ),
          ),
          WillPopScope(
            child: const Text(''),
            onWillPop: () async {
              _createData();
              return true;
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.limeAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: 'hour',
                      hintStyle: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Kalam',
                        color: Colors.black,
                      ),
                    ),
                    controller: hourController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: TextField(
                    decoration: const InputDecoration.collapsed(
                      hintText: 'minute',
                      hintStyle: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Kalam',
                        color: Colors.black,
                      ),
                    ),
                    controller: minuteController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.tealAccent,
            ),
            onPressed: () {
              int hour;
              int minutes;
              hour = int.parse(hourController.text);
              minutes = int.parse(minuteController.text);
              FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
            },
            child: const Text(
              'Create alarm',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Kalam',
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(130, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.amberAccent,
            ),
            onPressed: () {
              _createData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoView(),
                ),
              );
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Kalam',
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
