import 'package:dio/dio.dart';
import 'coin_model.dart';
import 'dart:convert';

class NetworkService {
  static const String url = 'https://api.coingecko.com/api/v3/coins/';
  static const String key = '?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';
  String test =
      'https://api.coingecko.com/api/v3/coins/list?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu'; //Отрамати id на усі Coins/

  Future<CoinModel?> getCoin(String coinSymbol) async {
    CoinModel? coin;

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(url + coinSymbol + key);

      dynamic json = jsonDecode(response.data.toString());
      coin = CoinModel.fromJson(json);
    } catch (e) {
      print('Помилка - $e');
    }

    return coin;
  }

  Future<CoinModel?> getBitcoin() async {
    CoinModel? coin;

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(url + 'bitcoin' + key);

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
