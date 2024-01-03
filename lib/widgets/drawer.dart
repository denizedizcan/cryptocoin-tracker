import 'package:crypto_list/pages/settings_page.dart';
import 'package:crypto_list/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(Icons.currency_bitcoin),
          ),
          DrawerTile(
            title: 'Coins',
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          DrawerTile(
            title: 'Settings',
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
