double parseDecimal(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.parse(value.toString());
}

int parseInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.parse(value.toString());
}

DateTime parseDateTime(dynamic value) => DateTime.parse(value as String);

DateTime? parseDateTimeOrNull(dynamic value) {
  if (value == null) return null;
  return DateTime.parse(value as String);
}
