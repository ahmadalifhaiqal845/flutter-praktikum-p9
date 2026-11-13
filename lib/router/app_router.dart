import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../pages/cart_page.dart';
import '../pages/checkout_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/product_detail_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../routes/app_routes.dart';
import '../state/auth_state.dart';

GoRouter createAppRouter(AuthState authState, {String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ?? AppRoutes.home,
    refreshListenable: authState,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      if (!authState.isLoggedIn && !isLoggingIn) {
        return '${AppRoutes.login}?from=${Uri.encodeComponent(state.uri.toString())}';
      }

      if (authState.isLoggedIn && isLoggingIn) {
        final destination = state.uri.queryParameters['from'];
        if (destination != null &&
            destination.startsWith('/') &&
            !destination.startsWith('//') &&
            destination != AppRoutes.login) {
          return destination;
        }
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(authState: authState),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => SearchPage(authState: authState),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => CheckoutPage(authState: authState),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => CartPage(authState: authState),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => ProfilePage(authState: authState),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomePage(authState: authState),
        routes: [
          GoRoute(
            path: AppRoutes.productDetail,
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              final product = id == null ? null : findProductById(id);
              if (product == null) {
                return NotFoundPage(location: state.uri.toString());
              }
              return ProductDetailPage(product: product, authState: authState);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return NotFoundPage(location: state.uri.toString());
    },
  );
}
