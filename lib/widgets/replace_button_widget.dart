import 'package:flutter/material.dart';

class ReplaceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReplaceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        width: 48,
        height: 32,
        child: const Icon(
          Icons.repeat,
          color: Colors.white,
        ),
      ),
    );
  }
}
