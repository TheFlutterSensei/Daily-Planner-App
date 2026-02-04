import 'package:daily_planner_app/helpers/datetime_helper.dart';
import 'package:daily_planner_app/models/note.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DateTime? selectedDate;
  DateTime? selectedTime;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final now = DateTime.now();
      setState(() {
        selectedTime = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void addNote() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Date is required')));
      return;
    }
    if (selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Time is required')));
      return;
    }
    if (_title.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title is required')));
      return;
    }
    if (_content.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Content is required')));
      return;
    }
    Navigator.pop(
      context,
      Note(
        title: _title.text,
        content: _content.text,
        date: selectedDate!,
        time: selectedTime!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: pickDate,
                  child: Text(
                    selectedDate == null
                        ? 'Pick Date'
                        : formatDate(selectedDate!),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: pickTime,
                  child: Text(
                    selectedTime == null
                        ? 'Pick Time'
                        : formateTime(selectedTime!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: _title,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _content,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        shape: CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
