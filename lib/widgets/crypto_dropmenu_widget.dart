import 'package:crypto_calculator/api/coin_id.dart';
import 'package:flutter/material.dart';

import '../api/network_service.dart';

class CryptoDropMenu extends StatefulWidget {
  final List<CoinsId> coinIds;
  final ValueChanged<String> onSelectedValueChanged;

  const CryptoDropMenu(
      {super.key, required this.coinIds, required this.onSelectedValueChanged});

  @override
  State<CryptoDropMenu> createState() => _CryptoDropMenuState();
}

class _CryptoDropMenuState extends State<CryptoDropMenu> {
  String? _selectedValue;
  NetworkService networkService = NetworkService();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: textEditingController,
      requestFocusOnTap: true,
      label: const Text(
        'Сurrency',
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.white,
        ),
      ),
      onSelected: (value) async {
        setState(() {
          _selectedValue = value;
        });
        String? newSelectedValue = _selectedValue;
        if (newSelectedValue != null) {
          widget.onSelectedValueChanged(newSelectedValue);
        }
      },
      dropdownMenuEntries: widget.coinIds.map<DropdownMenuEntry<String>>((
        CoinsId coin,
      ) {
        return DropdownMenuEntry<String>(
          value: coin.id,
          label: coin.name,
        );
      }).toList(),
    );
  }
}
