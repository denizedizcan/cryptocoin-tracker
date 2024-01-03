import 'package:isar/isar.dart';
import 'dart:math';

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
      price:
          roundDouble(json['data'][coinId]['quote']['USD']['price'].toDouble()),
      coinId: coinId,
    );
  }

  static List<Coin> getJsonList(Map<String, dynamic> json) {
    List<Coin> response = [];
    final resultKeys = json['data']!.keys.toList();
    for (var coinId in resultKeys) {
      response.add(Coin(
        name: json['data']![coinId]['name'],
        price: roundDouble(
            json['data']![coinId]['quote']['USD']['price'].toDouble()),
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

double roundDouble(double value) {
  int places = 2;
  if (value < 1.0) {
    String stringValue = value.toString();
    int dotIndex = stringValue.indexOf('.');
    for (int i = dotIndex; i < stringValue.length; i++) {
      if (stringValue[i] != '0' && stringValue[i] != '.') {
        places = dotIndex + i;
        break;
      }
    }
  }
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
