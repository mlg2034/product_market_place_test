import 'package:flutter/material.dart';

class ProductEmptyCard extends StatelessWidget {
  const ProductEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Товары не найдены',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
