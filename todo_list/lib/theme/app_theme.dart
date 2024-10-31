import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.amber[300]!,
        error: Colors.red,
      ),
      primarySwatch: Colors.amber,
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        floatingLabelStyle: TextStyle(color: Colors.black),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.amber[200],
        selectionColor: Colors.amber[200],
        selectionHandleColor: Colors.amber,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: Colors.amber.shade200,
        headerForegroundColor: Colors.black,
        dayForegroundColor: MaterialStateProperty.all(Colors.black),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.red.shade600),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.green.shade600),
        ),
        // dayOverlayColor: WidgetStatePropertyAll(Colors.amber.shade200),
        dayStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        // todayBorder: BorderSide(color: Colors.amber),
      ),
      timePickerTheme: TimePickerThemeData(
        //backgroundColor: Colors.amber,
        //dialHandColor: Colors.amber,
        dialBackgroundColor: Colors.amber[50],
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Colors.grey),
        ),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Colors.grey),
        ),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.red.shade600),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.green.shade600),
        ),
        //dayPeriodColor: Colors.blue[400],
      ),
    );
  }
}
