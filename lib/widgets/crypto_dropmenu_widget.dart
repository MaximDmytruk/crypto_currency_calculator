import 'package:flutter/material.dart';

class CryptoDropMenuWidget extends StatefulWidget {
  const CryptoDropMenuWidget({super.key});

  @override
  State<CryptoDropMenuWidget> createState() => _CryptoDropMenuWidgetState();
}

class _CryptoDropMenuWidgetState extends State<CryptoDropMenuWidget> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: const Text(
        'Сurrency',
        style: TextStyle(fontSize: 12),
      ),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      onSelected: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry(value: 'Value 1', label: 'One'),
        DropdownMenuEntry(value: 'Value 2', label: 'two'),
        DropdownMenuEntry(value: 'Value 3', label: 'Three'),
        DropdownMenuEntry(value: 'Value 4', label: 'Four'),
      ],
    );
  }
}
