import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// Reusable error state: icon, message, optional retry button.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, this.onRetry, this.icon, this.retryLabel = 'Retry'});

  final String message;
  final VoidCallback? onRetry;
  final Widget? icon;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? Icon(Icons.error_outline, size: AppSpacing.iconLg, color: context.colorScheme.error),
            const SizedBox(height: AppSpacing.md),
            Text(message, textAlign: TextAlign.center, style: context.textTheme.bodyLarge),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: AppSpacing.iconSm),
                label: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
