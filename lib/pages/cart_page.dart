import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../routes/app_routes.dart';
import '../state/auth_state.dart';
import '../widgets/shop_bottom_navigation.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: const Color(0xFFFCF9FF),
        title: const Text('Keranjang', style: TextStyle(fontSize: 16)),
      ),
      body: AnimatedBuilder(
        animation: authState,
        builder: (context, _) {
          final cartItems = authState.cartItems;
          final total = cartItems.fold<int>(0, (sum, item) {
            final product = findProductById(item.productId);
            return sum + (product == null ? 0 : product.price * item.quantity);
          });

          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            child: Column(
              children: [
                Expanded(
                  child: cartItems.isEmpty
                      ? const Center(child: Text('Keranjang masih kosong.'))
                      : ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            final product = findProductById(item.productId)!;
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              color: const Color(0xFFF5F2FA),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Color(0xFFE7E2EE),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Container(
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
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            product.formattedPrice,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF666672),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      key: Key('decrease-${product.id}'),
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () =>
                                          authState.removeFromCart(product.id),
                                      icon: const Icon(Icons.remove, size: 18),
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                    IconButton(
                                      key: Key('increase-${product.id}'),
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () =>
                                          authState.addToCart(product.id),
                                      icon: const Icon(Icons.add, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F2FA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE1DDE8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        formatRupiah(total),
                        style: const TextStyle(
                          color: Color(0xFF4B5DBD),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF535F9B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    onPressed: cartItems.isEmpty
                        ? null
                        : () => context.go(AppRoutes.checkout),
                    icon: const Icon(Icons.credit_card, size: 15),
                    label: const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const ShopBottomNavigation(selectedIndex: 2),
    );
  }
}
