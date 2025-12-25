import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class DesignSystem {
  static final DesignSystem _instance = Platform.isIOS
      ? IOSDesignSystem()
      : AndroidDesignSystem();
  static DesignSystem get instance => _instance;

  // Colors
  Color get primaryColor;
  Color get backgroundColor;
  Color get surfaceColor;
  Color get textColor;

  // Typography
  TextStyle get headlineLarge;
  TextStyle get bodyMedium;

  // Widgets
  Widget scaffold({required Widget body, Widget? sidebar});
  Widget card({required Widget child, VoidCallback? onTap});
  Widget button({required String text, required VoidCallback onPressed});
}

class IOSDesignSystem extends DesignSystem {
  @override
  Color get primaryColor => const Color(0xFFFF3B30); // Soft Red / System Red
  @override
  Color get backgroundColor => const Color(0xFFF2F2F7); // iOS System Background
  @override
  Color get surfaceColor => const Color(0xFFFFFFFF);
  @override
  Color get textColor => const Color(0xFF000000);

  @override
  TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: textColor,
    letterSpacing: -0.5,
  );

  @override
  TextStyle get bodyMedium => GoogleFonts.inter(fontSize: 17, color: textColor);

  @override
  Widget scaffold({required Widget body, Widget? sidebar}) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      child: Row(
        children: [
          if (sidebar != null) sidebar,
          Expanded(child: body),
        ],
      ),
    );
  }

  @override
  Widget card({required Widget child, VoidCallback? onTap}) {
    // Basic Glassmorphism placeholder - will enhance with glass_kit later
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child),
      ),
    );
  }

  @override
  Widget button({required String text, required VoidCallback onPressed}) {
    return CupertinoButton.filled(onPressed: onPressed, child: Text(text));
  }
}

class AndroidDesignSystem extends DesignSystem {
  @override
  Color get primaryColor => const Color(0xFFB3261E); // Material Red
  @override
  Color get backgroundColor => const Color(0xFFFFFBFE);
  @override
  Color get surfaceColor => const Color(0xFFFFFBFE); // Material Surface
  @override
  Color get textColor => const Color(0xFF1C1B1F);

  @override
  TextStyle get headlineLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: textColor,
  );

  @override
  TextStyle get bodyMedium =>
      GoogleFonts.outfit(fontSize: 16, color: textColor);

  @override
  Widget scaffold({required Widget body, Widget? sidebar}) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: sidebar != null ? Drawer(child: sidebar) : null,
      body: body,
    );
  }

  @override
  Widget card({required Widget child, VoidCallback? onTap}) {
    return Card(
      elevation: 0,
      color: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Material You large corners
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: child,
      ),
    );
  }

  @override
  Widget button({required String text, required VoidCallback onPressed}) {
    return FilledButton(onPressed: onPressed, child: Text(text));
  }
}
