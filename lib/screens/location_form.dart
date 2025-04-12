import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../models/location_note.dart';

class LocationForm extends StatefulWidget {
  final int? index;
  final LocationNote? note;

  LocationForm({this.index, this.note});

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  File? imageFile;
  final notesBox = Hive.box('notes');

  @override
  void initState() {
    if (widget.note != null) {
      nameCtrl.text = widget.note!.name;
      descCtrl.text = widget.note!.description;
      if (widget.note!.imagePath != null) {
        imageFile = File(widget.note!.imagePath!);
      }
    }
    super.initState();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => imageFile = File(img.path));
  }

  void saveNote() {
    final note = LocationNote(name: nameCtrl.text, description: descCtrl.text, imagePath: imageFile?.path);
    final noteMap = note.toMap();

    if (widget.index != null) {
      notesBox.putAt(widget.index!, noteMap);
    } else {
      notesBox.add(noteMap);
    }
    Navigator.pop(context);
  }

  void removeImage() {
    setState(() => imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.index != null ? "Edit Note" : "New Note")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Location Name')),
            TextField(controller: descCtrl, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 10),
            imageFile != null
                ? Column(
              children: [
                Image.file(imageFile!, height: 150),
                TextButton(onPressed: removeImage, child: Text("Remove Picture"))
              ],
            )
                : TextButton(onPressed: pickImage, child: Text("Pick Picture")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveNote, child: Text(widget.index != null ? "Update" : "Save"))
          ],
        ),
      ),
    );
  }
}
