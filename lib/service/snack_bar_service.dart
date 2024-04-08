import 'package:flutter/material.dart';

Future<void> showSnackBar({
  required BuildContext context,
  required String message,
  required Color color,
  required IconData icon,
}) async {
  await ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 30),
              Expanded(child: Center(child: Text(message))),
              const SizedBox(width: 30),
            ],
          ),
          width: 300,
          backgroundColor: color, // Set background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 1000,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      )
      .closed
      .then((reason) {
    // Handle closure if needed
  });
}
