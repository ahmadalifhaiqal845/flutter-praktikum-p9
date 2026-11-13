import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toko_app/main.dart';

void main() {
  testWidgets('login returns to the requested deep link', (tester) async {
    await tester.pumpWidget(const TokoApp(initialLocation: '/home/product/3'));
    await tester.pumpAndSettle();

    expect(find.text('Login Toko'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('username-field')), 'Sari');
    await tester.enterText(find.byKey(const Key('password-field')), 'password');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Smartwatch'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(
      find.text('Smartwatch dengan fitur pintar untuk menemani aktivitasmu.'),
      findsOneWidget,
    );
  });

  testWidgets('login guard opens home, product detail, and logs out', (
    tester,
  ) async {
    await tester.pumpWidget(const TokoApp());
    await tester.pumpAndSettle();

    expect(find.text('Login Toko'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('username-field')), 'Budi');
    await tester.enterText(find.byKey(const Key('password-field')), 'password');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Toko Saya'), findsOneWidget);
    expect(find.text('Sepatu Running'), findsOneWidget);
    expect(find.text('Rp 580.000'), findsOneWidget);

    await tester.tap(find.byKey(const Key('product-card-1')));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(
      find.text('Sepatu running ringan dan nyaman untuk aktivitas olahraga.'),
      findsOneWidget,
    );
    expect(find.text('Tambah ke keranjang'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logout-button')));
    await tester.pumpAndSettle();

    expect(find.text('Login Toko'), findsOneWidget);
  });
}
