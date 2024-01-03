import 'package:isar/isar.dart';
part 'coin_model.g.dart';

@collection
class Coin {
  Id id = Isar.autoIncrement;
  final String name;
  final double price;
  final String coinId;

  Coin({required this.name, required this.price, required this.coinId});

  factory Coin.fromJson(Map<String, dynamic> json, String coinId) {
    return Coin(
      name: json['data'][coinId]['name'],
      price: json['data'][coinId]['quote']['USD']['price'].toDouble(),
      coinId: coinId,
    );
  }

  static List<Coin> getJsonList(Map<String, dynamic> json) {
    List<Coin> response = [];
    final resultKeys = json['data']!.keys.toList();
    for (var coinId in resultKeys) {
      response.add(Coin(
        name: json['data']![coinId]['name'],
        price: json['data']![coinId]['quote']['USD']['price'].toDouble(),
        coinId: coinId,
      ));
    }
    return response;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'coinId': coinId,
      };
}
