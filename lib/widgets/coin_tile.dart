import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinTile extends StatelessWidget {
  final String name;
  final double price;
  final String id;

  const CoinTile({
    super.key,
    required this.name,
    required this.price,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          leading: SvgPicture.asset(
            'assets/$id.svg',
            height: 25,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                price.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                'assets/usd-cryptocurrency.svg',
                height: 25,
              ),
            ],
          )),
    );
  }
}
