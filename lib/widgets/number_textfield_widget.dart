import 'package:flutter/material.dart';

class NumberTextFieldWidget extends StatefulWidget {
  const NumberTextFieldWidget({super.key});

  @override
  State<NumberTextFieldWidget> createState() => _NumberTextFieldWidgetState();
}

class _NumberTextFieldWidgetState extends State<NumberTextFieldWidget> {
  late TextEditingController textController;
  String text = '';

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: textController,
          onSubmitted: (value) {
            setState(() {
              text = textController.text;
            });
          },
        ),
      ),
    );
  }
}


//  decoration: InputDecoration(
//         border: OutlineInputBorder(),