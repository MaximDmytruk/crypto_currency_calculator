import 'package:flutter/material.dart';

class ReplaceButtonWidget extends StatefulWidget {
  const ReplaceButtonWidget({super.key});

  @override
  State<ReplaceButtonWidget> createState() => _ReplaceButtonWidgetState();
}

class _ReplaceButtonWidgetState extends State<ReplaceButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print('Іконка натиснута');
      },
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        width: 52,
        height: 32,
        child: const Icon(
          Icons.repeat,
          color: Colors.white,
        ),
      ),
    );
  }
}
