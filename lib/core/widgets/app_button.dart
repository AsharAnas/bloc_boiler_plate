import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';

/// Button style variant.
enum AppButtonVariant {
  primary,
  secondary,
  outlined,
  text,
}

/// Custom button with built-in loader. Disabled when [isLoading] is true.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = true,
    this.icon,
    this.minHeight = 48,
  }) : assert(
         label != null || child != null,
         'Provide either label or child',
       );

  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final bool isLoading;
  final AppButtonVariant variant;
  final bool fullWidth;
  final Widget? icon;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = isLoading ? null : onPressed;
    final content = _buildContent(context, theme);

    final buttonChild = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
      child: content,
    );

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, minHeight),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            disabledBackgroundColor: AppColors.background,
            disabledForegroundColor: theme.colorScheme.onPrimary,
          ),
          child: buttonChild,
        );
        break;
      case AppButtonVariant.secondary:
        button = FilledButton.tonal(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, minHeight),
          ),
          child: buttonChild,
        );
        break;
      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, minHeight),
          ),
          child: buttonChild,
        );
        break;
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(fullWidth ? double.infinity : 0, minHeight),
          ),
          child: buttonChild,
        );
        break;
    }

    return button;
  }

  Widget _buildContent(BuildContext context, ThemeData theme) {
    if (isLoading) {
      final loaderColor = variant == AppButtonVariant.primary
          ? theme.colorScheme.onPrimary
          : theme.colorScheme.primary;
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
        ),
      );
    }

    if (icon != null && (label != null || child != null)) {
      return Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: AppSpacing.sm),
          label != null ? Text(label!) : child!,
        ],
      );
    }

    if (icon != null) {
      return icon!;
    }

    return label != null ? Text(label!) : child!;
  }
}
