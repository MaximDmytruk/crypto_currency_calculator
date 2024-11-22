import 'package:flutter/material.dart';
import 'widgets/replace_button_widget.dart';
import 'widgets/crypto_dropmenu_widget.dart';
import 'widgets/number_textfield_widget.dart';
import 'widgets/title_widget.dart';
import 'api/network_service.dart';
import 'api/coin_model.dart';
import 'api/coin_id.dart';

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

  String result = '';
  String result2 = '';
  String result3 = '';

  @override
  void initState() {
    super.initState();
    getAllCoins();
  }

  Future<void> getAllCoins() async {
    try {
      List<CoinsId> coinsIdsActually = await networkService.getAllActuallyIds();
      setState(() {
        coinIds = coinsIdsActually;
        print('Okey-------------------------------------');
      });
    } catch (e) {
      print("error in mainState = $e");
    }
  }

  void updateResultFirst(String selectedValue) async {
    coinFirst = await networkService.getCoin(selectedValue);
    final coinSecondz = this.coinSecond;
    if (coinSecondz != null) {
      print(
          'Price is = ${coinFirst?.marketData.currentPrice[coinSecondz.symbol.toLowerCase()]}');
      double? someResult =
          coinFirst?.marketData.currentPrice[coinSecondz.symbol.toLowerCase()];
      result3 = someResult.toString();
    }

    setState(() {
      result = selectedValue;
    });
  }

  void updateResultSecond(String selectedValue) async {
    coinSecond = await networkService.getCoin(selectedValue);

    if (coinFirst != null) {
      print(
          'Price is = ${coinFirst?.marketData.currentPrice[coinSecond?.symbol.toLowerCase()]}');
      double? someResult =
          coinFirst?.marketData.currentPrice[coinSecond?.symbol.toLowerCase()];
      String someString =
          '1 ${coinFirst?.id} (${coinFirst?.symbol.toUpperCase()}) = ';
      String somestring2 =
          ' ${coinSecond?.id} (${coinSecond?.symbol.toUpperCase()})';
      result3 = someString + someResult.toString() + somestring2;
    }
    setState(() {
      result2 = selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleWidget(),
              const SizedBox(height: 40),
              NumberTextFieldWidget(),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CryptoDropMenuWidget(
                      coinIds: coinIds,
                      onSelectedValueChanged: updateResultFirst,
                    ),
                    const ReplaceButtonWidget(),
                    CryptoDropMenuWidget(
                      coinIds: coinIds,
                      onSelectedValueChanged: updateResultSecond,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(result),
              Text(result2),
              Text(result3),
            ],
          ),
        ),
      ),
    );
  }
}
