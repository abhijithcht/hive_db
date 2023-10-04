import 'package:hive_database/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Individualbar> barData = [];

  // initialize bar data
  void initializeBarData() {
    barData = [
      //sun
      Individualbar(x: 0, y: sunAmount),
      //mon
      Individualbar(x: 1, y: monAmount),
      //tue
      Individualbar(x: 2, y: tueAmount),
      //wed
      Individualbar(x: 3, y: wedAmount),
      //thur
      Individualbar(x: 4, y: thurAmount),
      //fri
      Individualbar(x: 5, y: friAmount),
      //sat
      Individualbar(x: 6, y: satAmount),
    ];
  }
}
