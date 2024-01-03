// ignore_for_file: use_build_context_synchronously
import 'package:crypto_list/utils/global_variables.dart';
import 'package:crypto_list/models/coin_model.dart';
import 'package:crypto_list/service/isar_service.dart';
import 'package:crypto_list/utils/utils.dart';
import 'package:crypto_list/widgets/coin_search_delegate.dart';
import 'package:crypto_list/widgets/coin_tile.dart';
import 'package:crypto_list/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:crypto_list/service/coin_service.dart';

class CoinList extends StatefulWidget {
  const CoinList({super.key});

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  bool isLoading = false;
  final _coinService = CoinService();

  @override
  void initState() {
    super.initState();
    readCoins();
  }

  // refresh functions
  Future<void> _handleRefresh() async {
    await _fetchCoinList();
    readCoins();
    return await Future.delayed(const Duration(seconds: 1));
  }

  // fetch coin data from api
  Future<Coin> _fetchCoin(String name) async {
    try {
      final coin = await _coinService.getCoin(coinVariablesList[name]);
      return coin;
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
      rethrow;
    }
  }

  // fetch coin list data from api
  Future<void> _fetchCoinList() async {
    try {
      List<Coin> coinList = context.read<IsarService>().currentCoins;
      final newCoinList = await _coinService.getCoinList(coinList);
      context.read<IsarService>().saveAllCoin(newCoinList);
    } on Exception catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
  }

  // add coin to db
  void _addCoin(String coinName) async {
    if (context
        .read<IsarService>()
        .currentCoins
        .any((coin) => coin.name.toLowerCase() == coinName.toLowerCase())) {
      showSnackBar(
        "$coinName is already in list.",
        context,
      );
    } else {
      Coin coin = await _fetchCoin(coinName);
      context.read<IsarService>().saveCoin(coin);
    }
  }

  // read coins from db
  void readCoins() {
    context.read<IsarService>().fetchCoins();
  }

  //delete coin from db
  void deleteCoin(int id) {
    context.read<IsarService>().deleteCoin(id);
  }

  @override
  Widget build(BuildContext context) {
    // coin db
    final isar = context.watch<IsarService>();

    // current coins
    List<Coin> currentCoins = isar.currentCoins;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var query = await showSearch(
            context: context,
            delegate: CoinSearchDelegate(),
          );
          if (query != null && query != "") {
            setState(() {
              isLoading = true;
            });
            _addCoin(query);
            setState(() {
              isLoading = false;
            });
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      drawer: const MyDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADING
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Coins',
                    style: GoogleFonts.dmSerifText(
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                // LIST OF COINS
                Expanded(
                  child: LiquidPullToRefresh(
                    onRefresh: _handleRefresh,
                    height: 300,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: false,
                    child: SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: ListView.builder(
                        itemCount: currentCoins.length,
                        itemBuilder: (context, index) {
                          final coin = currentCoins[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 25, right: 25),
                            child: Slidable(
                                key: Key(coin.name),
                                endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  dismissible: DismissiblePane(
                                    onDismissed: () => deleteCoin(coin.id),
                                  ),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) =>
                                          deleteCoin(coin.id),
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                  ],
                                ),
                                child: CoinTile(
                                  name: coin.name,
                                  price: coin.price,
                                  id: coin.coinId,
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
