import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';

/// Rounded corners: top-left and bottom-right (radius ~10px).
const double _kCornerRadius = 10;

/// Angled cut: top-right and bottom-left (diagonal cut length).
const double _kAngularCut = 80;

/// Border for the cyber-style input: rounded top-left & bottom-right, angled top-right & bottom-left.
class _AngularInputBorder extends InputBorder {
  const _AngularInputBorder({this.borderColor = AppColors.fieldBorder, this.borderWidth = 1.5});

  final Color borderColor;
  final double borderWidth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  bool get isOutline => true;

  @override
  ShapeBorder scale(double t) {
    return _AngularInputBorder(borderColor: borderColor, borderWidth: borderWidth * t);
  }

  Path _outerPath(Rect rect) {
    final w = rect.width;
    final h = rect.height;
    final r = _kCornerRadius.clamp(0.0, (w < h ? w : h) * 0.5);
    final c = _kAngularCut.clamp(0.0, (w < h ? w : h) * 0.55);
    final path = Path()
      ..moveTo(rect.left + r, rect.top)
      ..lineTo(rect.right - c, rect.top)
      ..lineTo(rect.right, rect.top + c)
      ..lineTo(rect.right, rect.bottom - r)
      ..arcToPoint(Offset(rect.right - r, rect.bottom), radius: Radius.circular(r))
      ..lineTo(rect.left + c, rect.bottom)
      ..lineTo(rect.left, rect.bottom - c)
      ..lineTo(rect.left, rect.top + r)
      ..arcToPoint(Offset(rect.left + r, rect.top), radius: Radius.circular(r));
    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final side = BorderSide(color: borderColor, width: borderWidth);
    return _outerPath(rect.deflate(side.width / 2));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _outerPath(rect);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0,
    double gapPercentage = 0,
    TextDirection? textDirection,
    BorderSide? borderSide,
    Color? borderColor,
  }) {
    final side = borderSide ?? BorderSide(color: this.borderColor, width: borderWidth);
    final paint = Paint()
      ..color = borderColor ?? side.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = side.width;
    canvas.drawPath(_outerPath(rect), paint);
  }

  @override
  InputBorder copyWith({Color? borderColor, double? borderWidth, BorderSide? borderSide}) {
    return _AngularInputBorder(borderColor: borderColor ?? this.borderColor, borderWidth: borderWidth ?? this.borderWidth);
  }
}

/// Custom text field with futuristic angular shape, cyan label/border, dark fill.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autocorrect = true,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.focusNode,
    this.readOnly = false,
    this.showObscureToggle = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorrect;
  final bool enabled;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool readOnly;

  /// When true and [obscureText] is true, shows eye icon to toggle visibility (default true).
  final bool showObscureToggle;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final theme = Theme.of(context);

    Widget? suffix = widget.suffixIcon;
    if (suffix == null && widget.obscureText && widget.showObscureToggle) {
      suffix = IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: AppColors.fieldAccent, size: AppSpacing.iconMd),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        style: IconButton.styleFrom(foregroundColor: AppColors.fieldAccent),
      );
    }

    final normalBorder = _AngularInputBorder(borderColor: AppColors.fieldBorder, borderWidth: 1.5);
    final errorBorder = _AngularInputBorder(borderColor: AppColors.fieldError, borderWidth: 2.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.label!.toUpperCase(),
                  style: theme.textTheme.labelLarge?.copyWith(color: AppColors.fieldAccent, letterSpacing: 1.2, fontWeight: FontWeight.w500),
                ),
              ),
              if (hasError)
                Text(
                  widget.errorText!,
                  style: theme.textTheme.bodySmall?.copyWith(color: AppColors.fieldError, fontStyle: FontStyle.italic),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        ClipPath(
          clipper: _AngularClip(),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autocorrect: widget.autocorrect,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted != null ? (v) => widget.onSubmitted!(v ?? '') : null,
            inputFormatters: widget.inputFormatters,
            style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.fieldText),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(color: AppColors.fieldPlaceholder, letterSpacing: 0.8),
              prefixIcon: widget.prefixIcon,
              suffixIcon: suffix,
              filled: true,
              fillColor: AppColors.fieldBackground,
              border: normalBorder,
              enabledBorder: hasError ? errorBorder : normalBorder,
              focusedBorder: hasError ? errorBorder.copyWith(borderWidth: 2.5) : _AngularInputBorder(borderColor: AppColors.fieldAccent, borderWidth: 1.5),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
              errorStyle: theme.textTheme.bodySmall?.copyWith(color: AppColors.fieldError, fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
    );
  }
}

/// Clips the input to the same shape: rounded top-left & bottom-right, angled top-right & bottom-left.
class _AngularClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final w = size.width;
    final h = size.height;
    final r = _kCornerRadius.clamp(0.0, (w < h ? w : h) * 0.5);
    final c = _kAngularCut.clamp(0.0, (w < h ? w : h) * 0.55);
    final path = Path()
      ..moveTo(rect.left + r, rect.top)
      ..lineTo(rect.right - c, rect.top)
      ..lineTo(rect.right, rect.top + c)
      ..lineTo(rect.right, rect.bottom - r)
      ..arcToPoint(Offset(rect.right - r, rect.bottom), radius: Radius.circular(r))
      ..lineTo(rect.left + c, rect.bottom)
      ..lineTo(rect.left, rect.bottom - c)
      ..lineTo(rect.left, rect.top + r)
      ..arcToPoint(Offset(rect.left + r, rect.top), radius: Radius.circular(r));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
