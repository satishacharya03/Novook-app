import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novook/src/features/auth/presentation/login_screen.dart';
import 'package:novook/src/features/book_player/presentation/book_player_screen.dart';
import 'package:novook/src/features/home/presentation/explore_screen.dart';
import 'package:novook/src/features/home/presentation/home_screen.dart';
import 'package:novook/src/features/home/domain/book.dart';
import 'package:novook/src/features/library/presentation/library_screen.dart';
import 'package:novook/src/features/profile/presentation/profile_screen.dart';
import 'package:novook/src/features/settings/presentation/settings_screen.dart';
import 'package:novook/src/features/search/presentation/search_screen.dart';
import 'package:novook/src/features/trending/presentation/trending_screen.dart';
import 'package:novook/src/features/downloads/presentation/downloads_screen.dart';
import 'package:novook/src/routing/scaffold_with_navbar.dart';
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
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/search',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/trending',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TrendingScreen(),
      ),
      GoRoute(
        path: '/downloads',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DownloadsScreen(),
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
