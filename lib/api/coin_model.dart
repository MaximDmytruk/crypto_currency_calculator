class CoinModel {
  String id;
  String symbol;
  String name;
  MarketData marketData;

  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.marketData,
  });

  CoinModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        symbol = json["symbol"],
        name = json["name"],
        marketData = MarketData.fromJson(json["market_data"]);
}

class MarketData {
  Map<String, double> currentPrice;

  MarketData({required this.currentPrice});

  MarketData.fromJson(Map<String, dynamic> json)
      : currentPrice = Map<String, dynamic>.from(json["current_price"])
            .map((str, dbl) => MapEntry<String, double>(str, dbl.toDouble()));
}
