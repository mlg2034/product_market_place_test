import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feature/product/logic/provider/product_provider.dart';
import 'feature/product/presentation/page/product_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Sales Dashboard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ProductListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
