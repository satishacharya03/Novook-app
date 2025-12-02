import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novook_mobile/src/features/auth/presentation/login_screen.dart';
import 'package:novook_mobile/src/features/book_player/presentation/book_player_screen.dart';
import 'package:novook_mobile/src/features/home/presentation/explore_screen.dart';
import 'package:novook_mobile/src/features/home/presentation/home_screen.dart';
import 'package:novook_mobile/src/features/home/domain/book.dart';
import 'package:novook_mobile/src/features/library/presentation/library_screen.dart';
import 'package:novook_mobile/src/features/profile/presentation/profile_screen.dart';
import 'package:novook_mobile/src/routing/scaffold_with_navbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorExploreKey = GlobalKey<NavigatorState>(debugLabel: 'explore');
final _shellNavigatorLibraryKey = GlobalKey<NavigatorState>(debugLabel: 'library');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavbar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorExploreKey,
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLibraryKey,
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/book/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final book = state.extra as Book?;
          if (book != null) {
            return BookPlayerScreen(book: book);
          }
          final id = state.pathParameters['id']!;
          return BookPlayerScreen(
            book: Book(
              id: id,
              title: 'Loading...',
              author: '',
              fileUrl: 'https://pdfobject.com/pdf/sample.pdf',
              type: 'pdf',
            ),
          );
        },
      ),
    ],
  );
}
