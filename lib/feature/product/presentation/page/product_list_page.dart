import 'package:flutter/material.dart';
import 'package:product_shop_test_task/app/common/widgets/app_error_widget.dart';
import 'package:product_shop_test_task/app/common/widgets/app_loading_widget.dart';
import 'package:product_shop_test_task/feature/product/presentation/widgets/product_app_bar.dart';
import 'package:product_shop_test_task/feature/product/presentation/widgets/product_card.dart';
import 'package:product_shop_test_task/feature/product/presentation/widgets/product_empty_card.dart';
import 'package:product_shop_test_task/feature/product/presentation/widgets/product_filter_info_card.dart';
import 'package:provider/provider.dart';
import '../../logic/provider/product_provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(),
      body: Column(
        children: [
          ProductFilterInfoCard(),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return AppLoadingWidget();
                }
                if (provider.error != null) {
                  return AppErrorWidget(
                    errorText: provider.error,
                    tryAgainTap: () => provider.loadProducts(),
                  );
                }

                if (provider.filteredProducts.isEmpty) {
                  return ProductEmptyCard();
                }

                return ListView.builder(
                  itemCount: provider.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = provider.filteredProducts[index];
                    return ProductCard(product: product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
