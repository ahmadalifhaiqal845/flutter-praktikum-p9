import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../routes/app_routes.dart';
import '../state/auth_state.dart';
import '../widgets/shop_bottom_navigation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.authState});

  final AuthState authState;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();
    final results = dummyProducts.where((product) {
      return product.name.toLowerCase().contains(normalizedQuery) ||
          product.category.toLowerCase().contains(normalizedQuery);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: const Color(0xFFFCF9FF),
        title: const Text('Cari Produk', style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            TextField(
              key: const Key('search-field'),
              decoration: InputDecoration(
                hintText: 'Cari produk',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('Produk tidak ditemukan.'))
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final product = results[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          leading: Container(
                            width: 44,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8A7BCC),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(
                              product.icon,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontSize: 13),
                          ),
                          subtitle: Text(
                            product.category,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF777782),
                            ),
                          ),
                          trailing: Text(
                            product.formattedPrice,
                            style: const TextStyle(fontSize: 10),
                          ),
                          onTap: () => context.push(
                            '${AppRoutes.home}/product/${product.id}',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ShopBottomNavigation(selectedIndex: 1),
    );
  }
}
