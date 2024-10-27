import 'package:flutter/material.dart';

class CustomProfileField extends StatelessWidget {
  const CustomProfileField({
      this.icon =Icons.keyboard_arrow_right_rounded,
      required this.onPressed,
      required this.title,
      required this.value,
      super.key});

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.w300),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(icon, size: 18, color: Colors.grey[500],),
            )
          ],
        ),
      ),
    );
  }
}
