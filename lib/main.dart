import 'package:flutter/material.dart';
import 'widgets/replace_button_widget.dart';
import 'widgets/crypto_dropmenu_widget.dart';
import 'widgets/number_textfield_widget.dart';
import 'widgets/title_widget.dart';
import 'api/network_service .dart';
import 'api/coin_model.dart';

void main() async {
  runApp(const MainApp());
  List<CryptoValue> cryptoList = [];
  NetworkService networkService = NetworkService();
  print('ssssssss');
  CoinModel? bitcoin = await networkService.getCoin('aaa').whenComplete(
    () {
      print('BITCOIN:');
    },
  );

  print('next');

  CryptoValue btc = CryptoValue('Btc', 93.14);
  CryptoValue usd = CryptoValue('usd', 64.55);
  CryptoValue tlgm = CryptoValue('tlgm', 41.55);
  CryptoValue coin = CryptoValue('coin', 1);
  CryptoValue swa = CryptoValue('swa', 2.36);
  CryptoValue aaa = CryptoValue('aaa', 14);
  CryptoValue sss = CryptoValue('sss', 3.99999);

  cryptoList.add(btc);
  cryptoList.add(usd);
  cryptoList.add(tlgm);
  cryptoList.add(coin);
  cryptoList.add(swa);
  cryptoList.add(aaa);
  cryptoList.add(sss);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: NumberTextFieldWidget(),
              ),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CryptoDropMenuWidget(),
                    ReplaceButtonWidget(),
                    CryptoDropMenuWidget(),
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

class CryptoValue {
  final String name;
  double price;

  CryptoValue(this.name, this.price);

  void setPrice(double newPrice) {
    price = newPrice;
  }

  double gerPrice() {
    return price;
  }
}
