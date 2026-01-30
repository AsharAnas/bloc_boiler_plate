extension StringX on String {
  /// Returns true if string is null or empty or only whitespace.
  static bool isNullOrBlank(String? value) => value == null || value.trim().isEmpty;

  /// First letter uppercase, rest unchanged.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// First letter of each word uppercase.
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((e) => e.capitalize).join(' ');
  }
}

extension NullableStringX on String? {
  bool get isNullOrBlank => StringX.isNullOrBlank(this);
}
