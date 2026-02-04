import 'package:daily_planner_app/helpers/datetime_helper.dart';
import 'package:daily_planner_app/models/note.dart';
import 'package:daily_planner_app/screens/add_note.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planner'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes added yet'))
          : GroupedListView<Note, DateTime>(
              elements: _notes,
              groupBy: (note) => note.dateOnly,
              groupSeparatorBuilder: (date) => Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  formatDate(date),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              itemBuilder: (context, note) {
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  title: Text(note.title),
                  subtitle: Text(
                    formateTime(note.time),
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _notes.remove(note);
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNote()),
          );
          if (newNote != null) {
            setState(() {
              _notes.add(newNote);
            });
          }
        },
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
