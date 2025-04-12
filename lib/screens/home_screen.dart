import 'dart:io';
import 'package:flutter/material.dart';
import 'location_form.dart';
import 'package:hive/hive.dart';
import '../models/location_note.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notesBox = Hive.box('notes');

  void deleteNote(int index) {
    notesBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notes = notesBox.values.map((e) => LocationNote.fromMap(Map<String, dynamic>.from(e))).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Saved Locations")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, i) {
          final note = notes[i];
          return Card(
            child: ListTile(
              title: Text(note.name),
              subtitle: Text(note.description),
              leading: note.imagePath != null ? Image.file(File(note.imagePath!), width: 50) : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => LocationForm(index: i, note: note)));
                    setState(() {});
                  }),
                  IconButton(icon: Icon(Icons.delete), onPressed: () => deleteNote(i)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => LocationForm()));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
