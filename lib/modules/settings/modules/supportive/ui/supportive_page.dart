import 'package:flutter/material.dart';

class SupportivePage extends StatelessWidget {
  const SupportivePage({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content),
      ),
      body: Center(child: Text(content)),
    );
  }
}
