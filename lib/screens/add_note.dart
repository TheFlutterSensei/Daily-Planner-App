import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
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
                ElevatedButton(onPressed: () {}, child: Text('Pick Date')),
                SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: Text('Pick Time')),
              ],
            ),
            SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 8),
            Expanded(
              child: TextField(
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
        onPressed: () {},
        shape: CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
