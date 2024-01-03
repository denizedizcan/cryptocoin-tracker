import 'dart:convert';
import 'package:crypto_list/models/coin_model.dart';
import 'package:crypto_list/utils/global_variables.dart';
import 'package:crypto_list/utils/variable.dart';
import 'package:http/http.dart' as http;

class CoinService {
  CoinService();

  Future<Coin> getCoin(String coinId) async {
    final Map<String, String> headers = {"X-CMC_PRO_API_KEY": apiKey};
    final response = await http
        .get(Uri.parse('$baseUrl?aux=cmc_rank&id=$coinId'), headers: headers);
    if (response.statusCode == 200) {
      return Coin.fromJson(jsonDecode(response.body), coinId);
    } else {
      throw Exception('Failed to load coin');
    }
  }

  Future<List<Coin>> getCoinList(List<Coin> coinList) async {
    final Map<String, String> headers = {
      "X-CMC_PRO_API_KEY": apiKey,
    };

    List<String> coinIdList = coinList.map((coin) => coin.coinId).toList();

    final response = await http.get(
        Uri.parse('$baseUrl?aux=cmc_rank&id=${coinIdList.join(",")}'),
        headers: headers);
    if (response.statusCode == 200) {
      List<Coin> newList = Coin.getJsonList(jsonDecode(response.body));

      for (var oldCoin in coinList) {
        newList
            .where((newCoin) => oldCoin.name == newCoin.name)
            .forEach((matchingCoin) {
          matchingCoin.id = oldCoin.id;
        });
      }

      return newList;
    } else {
      throw Exception('Failed to load coin');
    }
  }
}
