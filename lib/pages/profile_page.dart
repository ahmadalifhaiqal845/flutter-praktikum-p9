import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../state/auth_state.dart';
import '../widgets/shop_bottom_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.authState});

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    final email = authState.username ?? '';
    final name = email == 'admin@toko.dev' ? 'Admin Toko' : email;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: const Color(0xFFFCF9FF),
        title: const Text('Profil', style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 30,
                color: Color(0xFF35447F),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(color: Color(0xFF9A9AA2), fontSize: 12),
            ),
            const SizedBox(height: 18),
            ListTile(
              dense: true,
              leading: const Icon(Icons.account_circle, size: 18),
              title: const Text('Edit Profil', style: TextStyle(fontSize: 12)),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Edit Profil'),
                  content: const Text('Informasi profil belum dapat diubah.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              dense: true,
              leading: const Icon(Icons.notifications, size: 18),
              title: const Text('Notifikasi', style: TextStyle(fontSize: 12)),
              tileColor: const Color(0xFFE9EBEF),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Notifikasi'),
                  content: const Text('Belum ada notifikasi baru.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: OutlinedButton.icon(
                key: const Key('logout-button'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF535F9B),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: Color(0xFF9EA0AA)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  authState.logout();
                  context.go(AppRoutes.login);
                },
                icon: const Icon(Icons.logout, size: 14),
                label: const Text('Keluar', style: TextStyle(fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ShopBottomNavigation(selectedIndex: 3),
    );
  }
}
