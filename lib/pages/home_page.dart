import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../routes/app_routes.dart';
import '../state/auth_state.dart';
import '../widgets/shop_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 48,
        backgroundColor: const Color(0xFFFCF9FF),
        title: const Text('Toko Saya', style: TextStyle(fontSize: 16)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 600 ? 2 : 1;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dummyProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 14,
              mainAxisSpacing: 12,
              childAspectRatio: columns == 2 ? 1.42 : 1.55,
            ),
            itemBuilder: (context, index) {
              final product = dummyProducts[index];
              return _ProductCard(product: product);
            },
          );
        },
      ),
      bottomNavigationBar: const ShopBottomNavigation(selectedIndex: 0),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: const Color(0xFFF5F2FA),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        key: Key('product-card-${product.id}'),
        onTap: () => context.push('${AppRoutes.home}/product/${product.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4654B8), Color(0xFF673AB7)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Icon(product.icon, color: Colors.white, size: 34),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 8, 9, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      product.category,
                      style: const TextStyle(
                        color: Color(0xFF777782),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.formattedPrice,
                      style: const TextStyle(
                        color: Color(0xFF4B5DBD),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
