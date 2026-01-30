import 'package:flutter/material.dart';

/// Full-screen loading overlay. Use when blocking the whole screen.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (message != null) ...[const SizedBox(height: 16), Text(message!, style: Theme.of(context).textTheme.bodyMedium)],
        ],
      ),
    );
  }
}

/// Inline loader for buttons or small areas.
class AppLoaderInline extends StatelessWidget {
  const AppLoaderInline({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: const CircularProgressIndicator.adaptive());
  }
}
