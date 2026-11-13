import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/auth_state.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.authState,
  });

  final Product product;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9FF),
        title: Text(product.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4654B8), Color(0xFF673AB7)],
                  ),
                ),
                child: Icon(product.icon, color: Colors.white, size: 64),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            product.formattedPrice,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.description),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              authState.addToCart(product.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} ditambahkan ke keranjang'),
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Tambah ke keranjang'),
          ),
        ],
      ),
    );
  }
}
