import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:intl/intl.dart';

class ClockAlarm extends StatefulWidget {
  const ClockAlarm({super.key});

  @override
  State<ClockAlarm> createState() => _ClockAlarmState();
}

class _ClockAlarmState extends State<ClockAlarm> {
  DateTime currentTime = DateTime.now();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String formatTime = DateFormat('HH:mm:ss').format(currentTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Alarm',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
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
              height: 50,
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
                // creating alarm after converting hour
                // and minute into integer
                FlutterAlarmClock.createAlarm(
                  hour: hour,
                  minutes: minutes,
                  title: 'Flutter Alarm',
                  skipUi: false,
                );
              },
              child: const Text(
                'Create alarm',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.amberAccent,
              ),
              onPressed: () {
                // show alarm
                FlutterAlarmClock.showAlarms();
              },
              child: const Text(
                'Show Alarms',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(130, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.amberAccent,
                ),
                child: const Text(
                  'Pick a time',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {}),
            Text(formatTime)
          ],
        ),
      ),
    );
  }
}
