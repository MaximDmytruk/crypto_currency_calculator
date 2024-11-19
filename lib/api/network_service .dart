import 'package:dio/dio.dart';
import 'coin_model.dart';
import 'dart:convert';
import 'coin_id.dart';

class NetworkService {
  static const String url = 'https://api.coingecko.com/api/v3/coins/';
  static const String key = '?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';
  String test =
      'https://api.coingecko.com/api/v3/coins/list?include_platform=true&status=active?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu'; //Отрамати id на усі Coins/

  Future<List<CoinsId>?> getAllIds() async {
    List<CoinsId>? coins;

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(test);

      dynamic json = jsonDecode(response.data.toString());

      if (json is List) {
        coins = json
            .map((item) => CoinsId.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Помилка - $e');
    }

    return coins;
  }

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
    } catch (e) {
      print('Помилка - $e');
    }

    return coin;
  }
}
