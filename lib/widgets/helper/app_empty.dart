import 'package:flutter/material.dart';

class AppEmpty extends StatelessWidget {
  final String title;

  const AppEmpty({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: const TextStyle(fontSize: 24)));
  }
}
