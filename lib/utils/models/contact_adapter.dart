import 'package:contact_app/utils/models/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 2;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      phoneNumber: fields[3] as String,
      nickName: fields[4] as String,
      email: fields[5] as String,
      groups: (fields[6] as List).cast<String>(),
      notes: fields[7] as String,
      relationship: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.nickName)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.groups)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.relationship);
  }
}
