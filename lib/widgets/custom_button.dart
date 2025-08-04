import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _getTextColor(theme),
            ),
          )
        else if (icon != null)
          Icon(
            icon,
            size: 20,
            color: _getTextColor(theme),
          ),
        if ((isLoading || icon != null) && text.isNotEmpty) const SizedBox(width: 8),
        if (text.isNotEmpty)
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              color: _getTextColor(theme),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(theme),
          foregroundColor: _getTextColor(theme),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: _getBorder(theme),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: buttonContent,
      ),
    );
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.colorScheme.primary;
      case ButtonType.secondary:
        return theme.colorScheme.surface;
      case ButtonType.outline:
        return Colors.transparent;
      case ButtonType.premium:
        return const Color(0xFFFFD700);
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.colorScheme.onPrimary;
      case ButtonType.secondary:
        return theme.colorScheme.primary;
      case ButtonType.outline:
        return theme.colorScheme.primary;
      case ButtonType.premium:
        return Colors.black87;
    }
  }

  BorderSide _getBorder(ThemeData theme) {
    switch (type) {
      case ButtonType.outline:
        return BorderSide(color: theme.colorScheme.primary, width: 1.5);
      default:
        return BorderSide.none;
    }
  }
}

enum ButtonType {
  primary,
  secondary,
  outline,
  premium,
}