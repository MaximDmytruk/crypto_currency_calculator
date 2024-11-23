import 'package:flutter/material.dart';

class TitleCrypto extends StatelessWidget {
  const TitleCrypto({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Cryptocurrency Converter Calculator',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
