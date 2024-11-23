import 'package:flutter/material.dart';
import 'widgets/replace_button_widget.dart';
import 'widgets/crypto_dropmenu_widget.dart';
import 'widgets/number_textfield_widget.dart';
import 'widgets/result_text.dart';
import 'widgets/title_widget.dart';
import 'api/network_service.dart';
import 'api/coin_model.dart';
import 'api/coin_id.dart';
import 'hellpers/hellpers.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  final NetworkService networkService = NetworkService();

  List<CoinModel> coinsList = [];
  List<CoinsId> coinIds = [];

  CoinModel? coinFirst;
  CoinModel? coinSecond;

  String nameOfFirstCoin = '';
  String nameOfSecondCoin = '';

  String contentFromTextField = '';
  double result = -1;

  @override
  void initState() {
    super.initState();
    getAllCoins();
  }

  void _swapCoins() {
    setState(() {
      final tempCoin = coinFirst;
      coinFirst = coinSecond;
      coinSecond = tempCoin;

      final tempName = nameOfFirstCoin;
      nameOfFirstCoin = nameOfSecondCoin;
      nameOfSecondCoin = tempName;

      _updateResult();
    });
  }

  Future<void> getAllCoins() async {
    try {
      List<CoinsId> coinsIdsActually = await networkService.getAllActuallyIds();
      setState(() {
        coinIds = coinsIdsActually;
      });
    } catch (e) {
      print("error in mainState = $e");
    }
  }

  void _updateResult() {
    if (coinFirst != null &&
        coinSecond != null &&
        contentFromTextField.isNotEmpty) {
      double quantity = isDouble(contentFromTextField);
      if (quantity != -1) {
        double? price = coinFirst
            ?.marketData.currentPrice[coinSecond?.symbol.toLowerCase()];
        if (price != null) {
          setState(() {
            result = price * quantity;
          });
        }
      }
    }
  }

  void _updateResultFirst(String selectedValue) async {
    coinFirst = await networkService.getCoin(selectedValue);
    _updateResult();
    setState(() {
      nameOfFirstCoin = selectedValue;
    });
  }

  void _updateResultSecond(String selectedValue) async {
    coinSecond = await networkService.getCoin(selectedValue);
    _updateResult();
    setState(() {
      nameOfSecondCoin = selectedValue;
    });
  }

  String resultInString() {
    String resultString = '';

    if (result > 0) {
      resultString =
          '${contentFromTextField} ${nameOfFirstCoin.toUpperCase()} = ${result.toString()} ${nameOfSecondCoin.toUpperCase()}';
    }

    return resultString;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleCrypto(),
            const SizedBox(height: 40),
            NumberTextFieldWidget(onSelectedValueChanged: (text) {
              setState(() {
                contentFromTextField = text;
              });
              _updateResult();
            }),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CryptoDropMenu(
                    coinIds: coinIds,
                    onSelectedValueChanged: _updateResultFirst,
                  ),
                  ReplaceButton(
                    onPressed: _swapCoins,
                  ),
                  CryptoDropMenu(
                    coinIds: coinIds,
                    onSelectedValueChanged: _updateResultSecond,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ResultText(
              text: resultInString(),
            ),
          ],
        ),
      ),
    );
  }
}
