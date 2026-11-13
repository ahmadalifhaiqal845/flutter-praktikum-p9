import 'package:flutter/material.dart';

import '../state/auth_state.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Nama: '),
            const SizedBox(height: 8),
            Text(authState.username ?? 'Pengguna'),
            const SizedBox(height: 24),
            const Text('Metode pembayaran: Transfer bank / COD'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                authState.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pembayaran berhasil.')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Bayar sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
