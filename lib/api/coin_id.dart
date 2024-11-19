// To parse this JSON data, do
//
//     final coinsId = coinsIdFromJson(jsonString);

import 'dart:convert';

List<CoinsId> coinsIdFromJson(String str) =>
    List<CoinsId>.from(json.decode(str).map((x) => CoinsId.fromJson(x)));

class CoinsId {
  String id;
  String symbol;
  String name;

  CoinsId({
    required this.id,
    required this.symbol,
    required this.name,
  });

  factory CoinsId.fromJson(Map<String, dynamic> json) => CoinsId(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
      );
}
