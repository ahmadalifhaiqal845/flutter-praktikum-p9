import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
    required this.description,
  });

  final int id;
  final String name;
  final String category;
  final int price;
  final IconData icon;
  final String description;

  String get formattedPrice => formatRupiah(price);
}

String formatRupiah(int amount) {
  final groupedPrice = amount.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp $groupedPrice';
}

const List<Product> dummyProducts = [
  Product(
    id: 1,
    name: 'Sepatu Running',
    category: 'Olahraga',
    price: 580000,
    icon: Icons.directions_run,
    description: 'Sepatu running ringan dan nyaman untuk aktivitas olahraga.',
  ),
  Product(
    id: 2,
    name: 'Tas Travel',
    category: 'Aksesoris',
    price: 420000,
    icon: Icons.work,
    description: 'Tas travel praktis dengan ruang penyimpanan yang luas.',
  ),
  Product(
    id: 3,
    name: 'Smartwatch',
    category: 'Elektronik',
    price: 980000,
    icon: Icons.watch,
    description: 'Smartwatch dengan fitur pintar untuk menemani aktivitasmu.',
  ),
  Product(
    id: 4,
    name: 'Kacamata Hitam',
    category: 'Fashion',
    price: 260000,
    icon: Icons.checkroom,
    description: 'Kacamata hitam bergaya untuk melengkapi penampilan.',
  ),
  Product(
    id: 5,
    name: 'Headphone',
    category: 'Elektronik',
    price: 690000,
    icon: Icons.headphones,
    description: 'Headphone nyaman dengan suara jernih untuk keseharian.',
  ),
];

Product? findProductById(int id) {
  for (final product in dummyProducts) {
    if (product.id == id) return product;
  }
  return null;
}
