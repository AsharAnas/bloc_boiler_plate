import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_toast.dart';

export '../utils/app_toast.dart' show AppToast, AppToastOptions;

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

  /// Shows a toast (Fluttertoast). Use for simple success/error feedback.
  void showSnackBar(String message, {Duration? duration, bool isError = false}) {
    final sec = (duration?.inSeconds ?? (isError ? 4 : 2)).clamp(1, 10);
    AppToast.show(
      message,
      options: AppToastOptions(
        toastLength: sec > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        timeInSecForIosWeb: sec,
        backgroundColor: isError ? colorScheme.error : null,
        textColor: Colors.white,
      ),
    );
  }

  /// Shows a custom toast with full control over message and options.
  void showToast(String message, {AppToastOptions? options, Color? backgroundColor, Color? textColor, ToastGravity? gravity, double? fontSize, int? timeInSecForIosWeb}) {
    AppToast.show(
      message,
      options: options ?? AppToastOptions.short,
      backgroundColor: backgroundColor,
      textColor: textColor,
      gravity: gravity,
      fontSize: fontSize,
      timeInSecForIosWeb: timeInSecForIosWeb,
    );
  }
}
