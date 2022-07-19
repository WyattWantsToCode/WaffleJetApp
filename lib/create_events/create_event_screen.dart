import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/storage.dart';
import 'package:uuid/uuid.dart';

DateTime selectedDate = DateTime.now();

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String uuid = Uuid().v1();
    return Scaffold(
      body: Column(
        children: [
          textInputField("Title", titleController),
          textInputField("Description", descriptionController),
          ElevatedButton(
              onPressed: () {
                selectDate(context);
              },
              child: Text("Select Date")),
          ElevatedButton(
              onPressed: () {
                uploadToStorage(uuid);
              },
              child: Text("picture")),
          TextButton(
              onPressed: () {
                addEventToFirestore(Event(
                    id: uuid,
                    title: titleController.text,
                    startTime: selectedDate,
                    description: descriptionController.text));
              },
              child: Text("place")),
        ],
      ),
    );
  }
}

Widget textInputField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
  );
}

void selectDate(BuildContext context) async {
  DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2020),
      lastDate: DateTime.utc(2025));

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
}
