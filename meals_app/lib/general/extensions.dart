extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";

  String insertSpaceForCamelCaseString() {
    if (isEmpty) {
      return this;
    }

    final buffer = StringBuffer();
    buffer.write(this[0]);

    for (int i = 1; i < length; i++) {
      if (this[i].toUpperCase() == this[i]) {
        buffer.write(' ');
      }
      buffer.write(this[i]);
    }

    return buffer.toString();
  }

  String textFromEnumName() => split('.').last.insertSpaceForCamelCaseString().capitalize();
}