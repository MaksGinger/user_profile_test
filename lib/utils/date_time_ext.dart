import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format() => DateFormat('dd-MM-yyyy').format(this);
}
