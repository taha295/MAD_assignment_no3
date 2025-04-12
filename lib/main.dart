import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/registration_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  await Hive.openBox('notes');
  runApp(MaterialApp(home: RegisterScreen(), debugShowCheckedModeBanner: false));
}
