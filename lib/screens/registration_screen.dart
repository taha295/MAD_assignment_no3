import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:hive/hive.dart';

class RegisterScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final userBox = Hive.box('user');

  void registerUser(BuildContext context) {
    if (userBox.isEmpty) {
      userBox.putAll({
        'name': nameCtrl.text,
        'address': addressCtrl.text,
        'password': passwordCtrl.text,
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Hive.box('user').isNotEmpty) return HomeScreen();

    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: addressCtrl, decoration: InputDecoration(labelText: 'Address')),
            TextField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => registerUser(context), child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
