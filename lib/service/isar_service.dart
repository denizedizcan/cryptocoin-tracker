import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto_list/models/coin_model.dart';

class IsarService extends ChangeNotifier {
  static late Isar isar;

  final List<Coin> currentCoins = [];

  static Future<void> initialize() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [CoinSchema],
        directory: dir.path,
      );
    }
  }

  Future<void> fetchCoins() async {
    List<Coin> fetchedCoins = await isar.coins.where().findAll();
    currentCoins.clear();
    currentCoins.addAll(fetchedCoins);
    notifyListeners();
  }

  Future<void> saveCoin(Coin coin) async {
    await isar.writeTxn(() => isar.coins.put(coin));
    fetchCoins();
  }

  Future<void> saveAllCoin(List<Coin> coinList) async {
    await isar.writeTxn<List<int>>(() => isar.coins.putAll(coinList));
    fetchCoins();
  }

  Future<void> cleanDb() async {
    await isar.writeTxn(() => isar.clear());
    await fetchCoins();
  }

  Future<void> deleteCoin(int id) async {
    await isar.writeTxn(() => isar.coins.delete(id));
    await fetchCoins();
  }
}
