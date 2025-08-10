import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  const HourlyForecastItem({
    super.key,
    required this.label,
    required this.icon,
    required this.value,

    
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: ClipRRect(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Icon(icon, size: 25),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
