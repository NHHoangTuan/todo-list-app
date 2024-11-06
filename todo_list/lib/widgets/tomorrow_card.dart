import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TomorrowCard extends StatelessWidget {
  final DateTime deadline;

  const TomorrowCard({
    Key? key,
    required this.deadline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(deadline);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[700]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.upcoming,
            color: Colors.orange[900],
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'Tomorrow, $timeString',
            style: TextStyle(
              color: Colors.orange[900],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
