class Note {
  final String title;
  final String content;
  final DateTime date;
  final DateTime time;

  const Note({
    required this.title,
    required this.content,
    required this.date,
    required this.time,
  });

  DateTime get dateOnly => DateTime(date.year, date.month, date.day);
}
