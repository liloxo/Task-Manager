import 'package:flutter/material.dart';

showError(BuildContext context, String errorMessage) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Alert',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Text(
            errorMessage,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      });
}
