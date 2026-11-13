import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';

class ShopBottomNavigation extends StatelessWidget {
  const ShopBottomNavigation({super.key, required this.selectedIndex});

  final int selectedIndex;

  static const _routes = [
    AppRoutes.home,
    AppRoutes.search,
    AppRoutes.cart,
    AppRoutes.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 64,
      selectedIndex: selectedIndex,
      backgroundColor: const Color(0xFFF0EDF5),
      indicatorColor: const Color(0xFFDDE1FF),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      onDestinationSelected: (index) => context.go(_routes[index]),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Cari'),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
