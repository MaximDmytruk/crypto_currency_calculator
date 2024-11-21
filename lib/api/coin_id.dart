
import 'dart:convert';

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
