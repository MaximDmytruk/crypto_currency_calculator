import 'package:crypto_calculator/api/coin_id.dart';
import 'package:crypto_calculator/api/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CryptoDropMenuWidget extends StatefulWidget {
  final List<CoinsId> coinIds;
  CryptoDropMenuWidget({super.key, required this.coinIds});

  @override
  State<CryptoDropMenuWidget> createState() => _CryptoDropMenuWidgetState();
}

class _CryptoDropMenuWidgetState extends State<CryptoDropMenuWidget> {
  String? _selectedValue;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: textEditingController,
      requestFocusOnTap: true,
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
      dropdownMenuEntries:
          widget.coinIds.map<DropdownMenuEntry<String>>((CoinsId coin) {
        return DropdownMenuEntry<String>(
          value: coin.id,
          label: coin.name,
        );
      }).toList(),
    );
  }
}
