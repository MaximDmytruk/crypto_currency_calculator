import 'dart:math';

import 'package:dio/dio.dart';
import 'coin_model.dart';
import 'dart:convert';
import 'coin_id.dart';

class NetworkService {
  static const String url = 'https://api.coingecko.com/api/v3/coins/';
  static const String key = '?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu';
  String test =
      'https://api.coingecko.com/api/v3/coins/list?include_platform=true&status=active?&x_cg_demo_api_key=CG-Bs4ineosVYngbcSDiQkAN7mu'; //Отрамати id на усі Coins/

  Future<List<CoinsId>> getAllIds() async {
    List<CoinsId> coinsIds = [];

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(test);
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

  Future<List<CoinsId>> getAllActuallyIds() async {
    List<CoinsId> coinsIds;
    List<CoinsId> coinsIdsActually = [];
    CoinModel bitcoin;

    coinsIds = await getAllIds();
    print('getAllIds----------------------------------');
    print(coinsIds.first.name);
    bitcoin = await getBitcoin();
    print('getBitcoin----------------------------------');

    for (int i = 0; i < coinsIds.length; i++) {
      for (var key in bitcoin.marketData.currentPrice.keys) {
        if (coinsIds[i].symbol == key) {
          coinsIdsActually.add(coinsIds[i]);
        }
      }
    }
    //   if (bitcoin.marketData.currentPrice.containsKey(coinsIds[i].symbol)) {
    //     coinsIdsActually.add(coinsIds[i]);
    //   }
    // }
    for (var element in coinsIdsActually) {
      print(element.symbol);
    }

    return coinsIdsActually;
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

  Future<CoinModel> getBitcoin() async {
    CoinModel coin;

    final Dio dio = Dio();

    try {
      final Response<String> response = await dio.get(url + 'bitcoin' + key);

      dynamic json = jsonDecode(response.data.toString());
      coin = CoinModel.fromJson(json);
    } catch (e) {
      print('Помилка - $e');
      rethrow;
    }

    return coin;
  }
}
