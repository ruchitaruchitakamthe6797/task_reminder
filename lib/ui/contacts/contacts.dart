import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'contacts.g.dart';

const String contactsBoxName = "contacts";

@HiveType(typeId: 1)
enum Relationship {
  @HiveField(0)
  Family,
  @HiveField(1)
  Friend,
}

const relationships = <Relationship, String>{
  Relationship.Family: "Family",
  Relationship.Friend: "Friend",
};

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  String desc;
  @HiveField(2)
  String time;
  @HiveField(3)
  String googleLink;
  @HiveField(4)
  String? image;
  // @HiveField(5)
  // File file;

  Contact(this.name, this.time, this.desc, this.googleLink,this.image);
}

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(ContactAdapter());
//   Hive.registerAdapter(RelationshipAdapter());
//   await Hive.openBox<Contact>(contactsBoxName);
//   runApp(MyApp1());
// }
