import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_database/money%20manager/money_manager.dart';
import 'package:hive_database/screens/read.dart';
import 'package:hive_database/todo/todo_view.dart';

import 'alarm/set_alarm.dart';
import 'expense manager/home.dart';
import 'expense tracker/home_page.dart';

class MainTask extends StatefulWidget {
  const MainTask({Key? key}) : super(key: key);

  @override
  State<MainTask> createState() => _MainTaskState();
}

class _MainTaskState extends State<MainTask> {
  final ButtonStyle customButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey[300],
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );
  final TextStyle customText = const TextStyle(
    fontSize: 22,
    fontFamily: 'Kalam',
  );
  final AppBar customAppBar = AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    title: const Text(
      'Navigation',
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kalam',
        fontSize: 38,
        letterSpacing: 2,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.black,
    elevation: 0,
  );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
    return Scaffold(
      appBar: customAppBar,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 40,
            ),
            child: Wrap(
              spacing: 14,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClockAlarm(),
                      ),
                    );
                  },
                  child: Text(
                    'Set Alarm',
                    style: customText,
                  ),
                ),
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoView(),
                      ),
                    );
                  },
                  child: Text(
                    'Notes App',
                    style: customText,
                  ),
                ),
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReadScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Hive DB',
                    style: customText,
                  ),
                ),
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  child: Text(
                    'Expense Manager',
                    style: customText,
                  ),
                ),
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Expense Tracker',
                    style: customText,
                  ),
                ),
                ElevatedButton(
                  style: customButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoneyManager(),
                      ),
                    );
                  },
                  child: Text(
                    'Money Manager',
                    style: customText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
