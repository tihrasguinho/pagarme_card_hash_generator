extension StringExtension on String {
  String get cardNumbersOnly => replaceAll(' ', '');

  String get cardExpirationNumbersOnly => replaceAll('/', '');
}
