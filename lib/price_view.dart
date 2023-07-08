import 'package:flutter/material.dart';

class PriceView extends StatefulWidget {
  const PriceView({super.key});

  @override
  State<PriceView> createState() => _PriceViewState();
}

class _PriceViewState extends State<PriceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuste de ganacias'),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}