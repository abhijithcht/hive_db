// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 1;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class Data3Adapter extends TypeAdapter<Data3> {
  @override
  final int typeId = 3;

  @override
  Data3 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data3(
      name: fields[4] as String,
      amount: fields[5] as dynamic,
      date: fields[6] as String,
      time: fields[7] as String,
      category: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Data3 obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data3Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
