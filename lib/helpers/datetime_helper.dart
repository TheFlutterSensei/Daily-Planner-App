import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMM, y').format(date);
}

String formateTime(DateTime time) {
  return DateFormat('hh:mm a').format(time);
}
