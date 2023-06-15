import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String message;
  const AppError(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
