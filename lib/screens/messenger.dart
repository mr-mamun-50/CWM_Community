import 'package:flutter/material.dart';

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Messenger'),
      ),
    );
  }
}
