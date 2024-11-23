import 'package:dio/dio.dart';
import 'coin_model.dart';
import 'dart:convert';
import 'coin_id.dart';

class NetworkService {
  static const String url = 'https://api.coingecko.com/api/v3/coins/';
  static const String key = '?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';
  String allIdsUrl =
      'https://api.coingecko.com/api/v3/coins/list?include_platform=true&status=active?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu'; //Отрамати id на усі Coins/

  Future<List<CoinsId>> getAllActuallyIds() async {
    List<CoinsId> coinsIds;
    List<CoinsId> coinsIdsActually = [];
    CoinModel bitcoin;

    coinsIds = await _getAllIds();
    bitcoin = await getCoin('bitcoin');

    for (int i = 0; i < coinsIds.length; i++) {
      for (var key in bitcoin.marketData.currentPrice.keys) {
        if (coinsIds[i].symbol == key) {
          coinsIdsActually.add(coinsIds[i]);
        }
      }
    }
    return coinsIdsActually;
  }

  Future<List<CoinsId>> _getAllIds() async {
    List<CoinsId> coinsIds = [];

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(allIdsUrl);
      dynamic json = jsonDecode(response.data.toString());
      if (json is List) {
        coinsIds = json
            .map((item) => CoinsId.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Помилка - $e');
      rethrow;
    }
    return coinsIds;
  }

  Future<CoinModel> getCoin(String coinSymbol) async {
    CoinModel coin;
    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(url + coinSymbol + key);
      dynamic json = jsonDecode(response.data.toString());
      coin = CoinModel.fromJson(json);
    } catch (e) {
      print('Помилка - $e');
      rethrow;
    }
    return coin;
  }
}
