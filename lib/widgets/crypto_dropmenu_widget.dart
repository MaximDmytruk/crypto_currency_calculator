import 'package:crypto_calculator/api/coin_id.dart';
import 'package:crypto_calculator/api/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../api/network_service.dart';

class CryptoDropMenuWidget extends StatefulWidget {
  final List<CoinsId> coinIds;
  final ValueChanged<String> onSelectedValueChanged;

  CryptoDropMenuWidget(
      {super.key, required this.coinIds, required this.onSelectedValueChanged});

  @override
  State<CryptoDropMenuWidget> createState() => _CryptoDropMenuWidgetState();
}

class _CryptoDropMenuWidgetState extends State<CryptoDropMenuWidget> {
  String? _selectedValue;
  NetworkService networkService = NetworkService();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: textEditingController,
      requestFocusOnTap: true,
      label: const Text('Сurrency', style: TextStyle(fontSize: 12)),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      onSelected: (value) async {
        setState(() {
          _selectedValue = value;
        });
        // CoinModel coin = await networkService.getCoin(_selectedValue!);
        // print(coin.name);
        widget.onSelectedValueChanged(_selectedValue!);
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
