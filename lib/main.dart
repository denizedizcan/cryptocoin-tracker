import 'package:crypto_list/pages/coin_list.dart';
import 'package:crypto_list/service/isar_service.dart';
import 'package:crypto_list/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  //init isar
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IsarService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CoinList(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
