import 'package:flutter/material.dart';
import 'widgets/replace_button_widget.dart';
import 'widgets/crypto_dropmenu_widget.dart';
import 'widgets/number_textfield_widget.dart';
import 'widgets/title_widget.dart';
import 'api/network_service .dart';
import 'api/coin_model.dart';
import 'api/coin_id.dart';

void main() async {
  runApp(const MainApp());

  // CoinModel? bitcoin = await networkService.getBitcoin().whenComplete(
  //   () {
  //     print('BITCOIN:');
  //   },
  // );
  // if (bitcoin != null) {
  //   for (var element in bitcoin.marketData.currentPrice.keys) {
  //     symbolsList.add(element);

  //     // CoinModel? coin = await networkService.getCoin();
  //     // if (coin != null) {
  //     //   coinsList.add(coin);
  //     // }
  //   }
  // }
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
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: NumberTextFieldWidget(),
              ),
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
                    ),
                    const ReplaceButtonWidget(),
                    CryptoDropMenuWidget(
                      coinIds: coinIds,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
