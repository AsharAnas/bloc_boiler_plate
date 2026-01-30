import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;
  bool get isSmallScreen => screenWidth < 600;

  void hideKeyboard() => FocusScope.of(this).unfocus();

  void showSnackBar(String message, {Duration? duration, bool isError = false}) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? (isError ? const Duration(seconds: 4) : const Duration(seconds: 2)),
        backgroundColor: isError ? colorScheme.error : null,
      ),
    );
  }
}
