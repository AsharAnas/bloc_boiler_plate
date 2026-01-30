import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Options for showing a custom toast via [Fluttertoast].
class AppToastOptions {
  const AppToastOptions({
    this.toastLength = Toast.LENGTH_SHORT,
    this.gravity = ToastGravity.BOTTOM,
    this.timeInSecForIosWeb = 2,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 14.0,
  });

  final Toast toastLength;
  final ToastGravity gravity;
  final int timeInSecForIosWeb;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;

  /// Short toast (about 2s).
  static const short = AppToastOptions(toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 2);

  /// Long toast (about 4s).
  static const long = AppToastOptions(toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 4);

  /// Success style (green background).
  static AppToastOptions success(BuildContext context) => AppToastOptions(toastLength: Toast.LENGTH_SHORT, backgroundColor: Colors.green.shade700, textColor: Colors.white);

  /// Error style (red background).
  static AppToastOptions error(BuildContext context) =>
      AppToastOptions(toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).colorScheme.error, textColor: Colors.white);

  /// Center of screen.
  static AppToastOptions get center => AppToastOptions(gravity: ToastGravity.CENTER);

  /// Top of screen.
  static AppToastOptions get top => AppToastOptions(gravity: ToastGravity.TOP);
}

/// Custom toast messages using [Fluttertoast]. Call [show] or use [BuildContext.showToast].
class AppToast {
  AppToast._();

  /// Shows a custom toast with [message] and optional [options].
  static void show(
    String message, {
    AppToastOptions options = AppToastOptions.short,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity? gravity,
    double? fontSize,
    int? timeInSecForIosWeb,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: options.toastLength,
      gravity: gravity ?? options.gravity,
      timeInSecForIosWeb: (timeInSecForIosWeb ?? options.timeInSecForIosWeb).clamp(1, 10),
      backgroundColor: backgroundColor ?? options.backgroundColor ?? Colors.black87,
      textColor: textColor ?? options.textColor ?? Colors.white,
      fontSize: fontSize ?? options.fontSize,
    );
  }

  /// Hides the current toast.
  static void cancel() {
    Fluttertoast.cancel();
  }
}
