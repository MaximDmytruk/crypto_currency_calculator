import 'package:dio/dio.dart';
import 'coin_model.dart';
import 'dart:convert';

class NetworkService {
  static const String url = 'https://api.coingecko.com/api/v3/coins/';
  static const String key = '?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';
  String symbol = 'bitcoin';
  String url2 =
      'https://api.coingecko.com/api/v3/coins/bitcoin?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';

  Future<CoinModel?> getCoin(String coinSymbol) async {
    CoinModel? coin;

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(url2);

      dynamic json = jsonDecode(response.data.toString());
      coin = CoinModel.fromJson(json);
      print(coin.id);
      print(coin.name);
      print(coin.marketData.currentPrice['php']);
    } catch (e) {
      print('Помилка - $e');
    }

    return coin;
  }
}
