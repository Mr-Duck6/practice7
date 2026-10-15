import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/date_picker_screen.dart';
import 'screens/error_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_books_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reserve_screen.dart';
import 'screens/scaffold_with_nav_bar.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _pendingRoute;

  bool get isAuthenticated => _isAuthenticated;
  String? get pendingRoute => _pendingRoute;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  void setPendingRoute(String? route) {
    _pendingRoute = route;
  }
}

final authNotifier = AuthNotifier();
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/catalog',
  refreshListenable: authNotifier,
  errorBuilder: (context, state) => ErrorScreen(errorUri: state.uri.toString()),
  redirect: (context, state) {
    final loggedIn = authNotifier.isAuthenticated;
    final isLoggingIn = state.matchedLocation == '/login';
    final isProtected = state.matchedLocation.contains('/reserve');

    if (isProtected && !loggedIn) {
      authNotifier.setPendingRoute(state.uri.toString());
      return '/login';
    }

    if (loggedIn && isLoggingIn) {
      final redirectTo = authNotifier.pendingRoute ?? '/catalog';
      authNotifier.setPendingRoute(null);
      return redirectTo;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              builder: (context, state) {
                final genre = state.uri.queryParameters['genre'];
                return CatalogScreen(selectedGenre: genre);
              },
              routes: [
                GoRoute(
                  path: 'book/:bookId',
                  builder: (context, state) {
                    final bookId = state.pathParameters['bookId']!;
                    return BookScreen(bookId: bookId);
                  },
                  routes: [
                    GoRoute(
                      path: 'reserve',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final bookId = state.pathParameters['bookId']!;
                        return ReserveScreen(bookId: bookId);
                      },
                      routes: [
                        GoRoute(
                          path: 'date-picker',
                          parentNavigatorKey: _rootNavigatorKey,
                          builder: (context, state) => const DatePickerScreen(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my-books',
              builder: (context, state) => const MyBooksScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);