import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeCard extends StatelessWidget {
  final DateTime deadline;

  DateTimeCard({required this.deadline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        border: Border.all(color: Colors.grey[700]!), // Border color
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today, // Calendar icon
            color: Colors.grey[900],
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            DateFormat('dd MMM HH:mm').format(deadline), // Định dạng `deadline`
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
