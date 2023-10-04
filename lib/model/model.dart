import 'package:hive/hive.dart';

part "model.g.dart";

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  Data({
    required this.title,
    required this.description,
  });
}

@HiveType(typeId: 3)
class Data3 {
  @HiveField(4)
  String name;
  @HiveField(5)
  dynamic amount;
  @HiveField(6)
  String date;
  @HiveField(7)
  String time;
  @HiveField(9)
  String category;

  Data3({
    required this.name,
    required this.amount,
    required this.date,
    required this.time,
    required this.category,
  });
}
