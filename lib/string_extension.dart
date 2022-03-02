extension StringExtension on String {
  String get withOutSpecialChars => replaceAll(RegExp(r'[^\w\s]+'), '');
}
