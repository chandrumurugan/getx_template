import 'package:go_router/go_router.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/products/views/product_list_screen.dart';
import '../../features/products/views/product_detail_screen.dart';
import '../../features/cart/views/cart_screen.dart';
import '../../features/orders/views/order_history_screen.dart';
import '../../features/whishlist/views/wishlist_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final product = state.extra as Map<String, dynamic>;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/wishlist',
      builder: (context, state) => const WishlistScreen(),
    ),
  ],
);